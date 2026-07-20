import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nti_ecommerce_team4/features/admin_product/data/models/product_model.dart';
import 'package:nti_ecommerce_team4/features/admin_product/presentation/cubits/product_cubit.dart';
import 'package:nti_ecommerce_team4/features/admin_product/presentation/cubits/product_state.dart';

class AddProductListview extends StatelessWidget {
  final Function(int) onCountChanged;
  const AddProductListview({super.key, required this.onCountChanged});
  

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Expanded(
      child: Column(
        children: [
          
          TextField(
            decoration: const InputDecoration(
              labelText: 'Search...',
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: (query) {
              context.read<ProductCubit>().searchProducts(query);
            },
          ),

          Expanded(
            child: BlocBuilder<ProductCubit, ProductState>(
              builder: (context, state) {
                if (state is ProductLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ProductLoaded) {
                  final products = state.products;
                  if (products.isEmpty) {
                    return const Center(child: Text("No products found"));
                  }
                  onCountChanged(products.length);
                  return ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            spacing: 15,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  'assets/images/product.png',
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  spacing: 3,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      product.name ?? "No Name", 
                                      style: theme.textTheme.bodyLarge?.copyWith(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18,
                                        fontFamily: 'PlayfairDisplay',
                                      ),
                                    ),
                                    Text(
                                      "\$${product.price ?? 0}",
                                      style: theme.textTheme.headlineSmall?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: theme.colorScheme.primary,
                                      ),
                                    ),
                                    Text(
                                      "In Stock: ${product.stock ?? 0} units",
                                      style: theme.textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                       
                                  context.read<ProductCubit>().deleteProduct(product.id!);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("Product deleted")),
                                  );
                                },
                                icon: SvgPicture.asset(
                                  "assets/icons/delete.svg",
                                  height: 20,
                                  width: 20,
                                  color: theme.iconTheme.color,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else if (state is ProductError) {
                  return Center(child: Text(state.message));
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}