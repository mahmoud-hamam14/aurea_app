import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nti_ecommerce_team4/features/cart/presentation/cubits/add_to_cart_cubit.dart';
import 'package:nti_ecommerce_team4/features/cart/presentation/cubits/add_to_cart_state.dart';
import 'package:nti_ecommerce_team4/features/products/data/date_source/product_details_remote_data_source.dart';
import 'package:nti_ecommerce_team4/features/products/presentation/cubits/product_details_cubit.dart';
import 'package:nti_ecommerce_team4/generated/l10n.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/theme_extensions.dart';
import '../../../cart/data/date_source/cart_get_data.dart';
import '../widgets/add_cart_button.dart';
import '../widgets/buy_now_button.dart';
import '../widgets/chain_divider.dart';
import '../widgets/expandabe_description.dart';
import '../widgets/hero_caroasal.dart';
import '../widgets/price_row.dart';
import '../widgets/quantity_stipper.dart';
import '../widgets/rating_row.dart';
import '../widgets/related_rail.dart';
import '../widgets/section_label.dart';
import '../widgets/specs_acordion.dart';
import '../widgets/start_rating.dart';
import '../widgets/title_row.dart';
import '../../../../core/utils/app_colors.dart';


class ProductDetailsScreen extends StatefulWidget {
  final String productId;
  const ProductDetailsScreen({super.key, required this.productId});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  String? toastMessage;
  Timer? _toastTimer;
  int qty = 1;

  void showToast(String msg) {
    _toastTimer?.cancel();
    setState(() => toastMessage = msg);
    _toastTimer = Timer(const Duration(milliseconds: 1800), () {
      if (mounted) setState(() => toastMessage = null);
    });
  }
  @override
  void dispose() {
    _toastTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              ProductDetailsCubit(ProductDetailsRemoteDataSource())
                ..getProductDetails(widget.productId),
        ),
        BlocProvider(
          create: (context) => AddToCartCubit(CartRemoteDataSource()),
        ),
      ],
      child: Scaffold(
        body: BlocListener<AddToCartCubit, AddToCartState>(
          listener: (context, state) {
            final s = S.of(context);
            if (state is AddToCartSuccess) {
              if (state.buttonId == 'buyNow') {
                Navigator.pushNamed(context, AppRoutes.cart);
              } else {
                showToast(s.addedToCart(state.message));
              }
            } else if (state is CartError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                  backgroundColor: Colors.black87,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          },
          child: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
            builder: (context, state) {
              if (state is ProductDetailsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ProductDetailsError) {
                return Center(child: Text(state.errorMessage));
              } else if (state is ProductDetailsSuccess) {
                final product = state.product;
                final reviews = state.reviews;
                final relatedProducts = state.relatedProducts;

                final List<String> gallery = [product.coverPictureUrl];
                if (product.productPictures.isNotEmpty) {
                  gallery.addAll(product.productPictures);
                }

                return LayoutBuilder(
                  builder: (context, constraints) {
                    final bool isWide = constraints.maxWidth > 900;

                    return Center(
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: isWide ? 1150 : double.infinity,
                        ),
                        margin: EdgeInsets.symmetric(
                          vertical: isWide ? 40 : 0,
                          horizontal: isWide ? 40 : 0,
                        ),
                        decoration: BoxDecoration(
                          color: context.cardColor,
                          borderRadius: BorderRadius.circular(isWide ? 34 : 0),
                          boxShadow: isWide
                              ? [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.08),
                                    blurRadius: 30,
                                    offset: const Offset(0, 10),
                                  ),
                                ]
                              : null,
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Stack(
                          children: [
                            if (isWide)
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: HeroCarousel(
                                      bagCount: 0,
                                      images: gallery,
                                      onBack: () => Navigator.pop(context),
                                      onAdd: () {
                                        context.read<AddToCartCubit>().addToCart(
                                          qty, productId: product.id, buttonId: 'addToCart',
                                        );
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    flex: 6,
                                    child: SingleChildScrollView(
                                      padding: const EdgeInsets.all(40),
                                      child: _buildProductInfo(
                                        product,
                                        reviews,
                                        relatedProducts,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            else
                              SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    HeroCarousel(
                                      bagCount: 0,
                                      images: gallery,
                                      onBack: () => Navigator.pop(context),
                                      onAdd: () {
                                        context.read<AddToCartCubit>().addToCart(
                                          qty, productId: product.id, buttonId: 'addToCart',
                                        );
                                      },
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: _buildProductInfo(
                                        product,
                                        reviews,
                                        relatedProducts,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            _buildToastOverlay(),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildProductInfo(product, reviews, relatedProducts) {
    final s = S.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleRow(name: product.name, arabicName: product.arabicName),
        const SizedBox(height: 12),
        RatingRow(
          rating: product.rating.toDouble(),
          reviewsCount: product.reviewsCount,
        ),
        const SizedBox(height: 18),
        PriceRow(
          price: product.price.toDouble(),
          discountPercentage: product.discountPercentage,
        ),
        const ChainDivider(),
        SectionLabel(icon: Icons.notes_rounded, label: s.description),
        const SizedBox(height: 12),
        ExpandableDescription(
          description: product.description,
          arabicDescription: product.arabicDescription,
        ),
        const SizedBox(height: 30),

        Builder(
          builder: (blocContext) {
            return Row(
              children: [
                Expanded(
                  child: BlocBuilder<AddToCartCubit, AddToCartState>(
                    builder: (context, cartState) {
                      if (cartState is AddToCartLoading &&
                          cartState.buttonId == 'buyNow') {
                        return const Center(
                          child: SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        );
                      }
                      return BuyNowButton(
                        onTap: () {
                          blocContext.read<AddToCartCubit>().addToCart(
                            qty, buttonId: 'buyNow', productId: product.id,
                          );
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: BlocBuilder<AddToCartCubit, AddToCartState>(
                    builder: (context, cartState) {
                      if (cartState is AddToCartLoading &&
                          cartState.buttonId == 'addToCart') {
                        return const Center(
                          child: SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        );
                      }
                      return AddToCartButton(
                        onAdded: () {
                          blocContext.read<AddToCartCubit>().addToCart(
                            qty, productId: product.id, buttonId: 'addToCart',
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),

        const SizedBox(height: 32),
        SpecsAccordion(product: product),
        const SizedBox(height: 28),
        QuantityStepper(
          value: qty,
          onChanged: (v) {
            if (v <= product.stock) {
              setState(() => qty = v);
            } else {
              showToast(s.itemsInStock(product.stock));
            }
          },
        ),
        const SizedBox(height: 32),
        if (relatedProducts != null && relatedProducts.isNotEmpty) ...[
          SectionLabel(icon: Icons.auto_awesome_rounded, label: s.relatedProducts),
          const SizedBox(height: 16),
          RelatedRail(
            relatedProducts: relatedProducts,
            onQuickAdd: (name) => showToast(s.addedToCart(name)),
            onQuickRemove: () {},
          ),
          const SizedBox(height: 32),
        ],
        if (reviews.isNotEmpty) ...[
          SectionLabel(
            icon: Icons.reviews_outlined,
            label: s.customerReviews,
          ),
          const SizedBox(height: 20),
          ...reviews
              .take(3)
              .map(
                (review) => Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            review.userName,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                          const Spacer(),
                          StarRating(
                            rating: review.rating.toDouble(),
                            size: 13,
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        review.comment,
                        style: TextStyle(
                          color: context.textSecondary,
                          fontSize: 13.5,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        ],
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildToastOverlay() {
    if (toastMessage == null) return const SizedBox.shrink();
    return Positioned(
      left: 20,
      right: 20,
      bottom: 40,
      child: Center(
        child: AnimatedSlide(
          duration: const Duration(milliseconds: 260),
          curve: Curves.easeOutBack,
          offset: toastMessage == null ? const Offset(0, 0.4) : Offset.zero,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 220),
            opacity: toastMessage == null ? 0 : 1,
            child: IgnorePointer(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: context.isDark
                      ? AppColors.darkSurfaceAlt
                      : Colors.black,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Text(
                  toastMessage!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
