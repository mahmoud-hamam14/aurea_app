import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nti_ecommerce_team4/features/cart/presentation/cubits/add_to_cart_cubit.dart';
import 'package:nti_ecommerce_team4/features/cart/presentation/cubits/add_to_cart_state.dart';
import 'package:nti_ecommerce_team4/features/home/presentation/cubits/products_cubit/products_cubit.dart';
import 'package:nti_ecommerce_team4/features/home/presentation/cubits/products_cubit/products_states.dart';
import 'package:nti_ecommerce_team4/features/products/presentation/widgets/sparkle_favorite_button.dart';

import 'package:nti_ecommerce_team4/core/routes/app_routes.dart';


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
        builder: (context, state) {
          if (state is ProductsLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductsFailiurState) {
            return const Center(child: Text("something went wrong"));
          } else if (state is ProductsSuccessState) {
            return LayoutBuilder(
              builder: (context, constraints) {
                // Determine column count based on available width
                int crossAxisCount = 2;
                if (constraints.maxWidth > 900) {
                  crossAxisCount = 4;
                } else if (constraints.maxWidth > 600) {
                  crossAxisCount = 3;
                }

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.70,
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
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
                          Navigator.pushNamed(
                            context,
                            AppRoutes.productDetails,
                            arguments: product.id,
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
                                    top: 4,
                                    right: 4,
                                    child: SparkleFavoriteButton(size: 32),
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
                                BlocBuilder<AddToCartCubit, AddToCartState>(
                                  builder: (context, state) {
                                    if (state is AddToCartLoading && state.buttonId == "addToCart_${product.id}") {
                                      return const SizedBox(
                                        width: 30,
                                        height: 30,
                                        child: CircularProgressIndicator(strokeWidth: 2),
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
                                      iconSize: 18,
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
