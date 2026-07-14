import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nti_ecommerce_team4/core/theme/app_theme.dart';
import 'package:nti_ecommerce_team4/features/cart/presentation/cubits/add_to_cart_cubit.dart';
import 'package:nti_ecommerce_team4/features/home/presentation/cubits/products_cubit/products_cubit.dart';
import 'package:nti_ecommerce_team4/features/home/presentation/cubits/products_cubit/products_states.dart';

import '../../../cart/presentation/cubits/add_to_cart_state.dart';

import '../../../products/presentation/screens/product_details_screen.dart';

class AllProductGridView extends StatelessWidget {
  const AllProductGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddToCartCubit, AddToCartState>(
      listener: (context, state) {
        if (state is AddToCartSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 2),
            ),
          );
        } else if (state is CartError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 2),
            ),
          );
        }
      },
      child: BlocBuilder<ProductsCubit, ProductsStates>(
        buildWhen: (previous, current) =>
            current is ProductsLoadingState ||
            current is ProductsFailiurState ||
            current is ProductsSuccessState,
        builder: (context, state) {

        if (state is ProductsLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProductsFailiurState) {
          return const Center(child: Text("something went wrong"));
        } else if (state is ProductsSuccessState) {
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.70,
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: state.products.length,
            itemBuilder: (context, index) {
              final product = state.products[index];
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 0,
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProductDetailsScreen(
                              productId: product.id,
                            ),
                      ),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                product.coverPictureUrl,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(Icons.image_not_supported);
                                },
                              ),
                            ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.8),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.favorite_border,
                                    color: AppColors.darkBackground,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        product.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${product.price} SAR",
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Color.fromARGB(255, 158, 125, 16),
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(width: 5),
                          BlocBuilder<AddToCartCubit, AddToCartState>(
                            builder: (context, state) {
                              if (state is AddToCartLoading && state.buttonId == "addToCart_${product.id}") {
                                return const SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: CircularProgressIndicator(strokeWidth: 2),
                                  ),
                                );
                              }
                              return IconButton.filled(
                                onPressed: () {
                                  context.read<AddToCartCubit>().addToCart(
                                        1,
                                        productId: product.id,
                                        buttonId: "addToCart_${product.id}",
                                      );
                                },
                                icon: const Icon(Icons.add),
                                iconSize: 20,
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    ),
);
  }
}
