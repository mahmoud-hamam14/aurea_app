import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nti_ecommerce_team4/features/admin_product/presentation/cubits/product_cubit.dart';
import 'package:nti_ecommerce_team4/features/admin_product/presentation/cubits/product_state.dart';

class AddProductListview extends StatelessWidget {
  final Function(int) onCountChanged;
  const AddProductListview({super.key, required this.onCountChanged});

  void _showDeleteDialog(BuildContext context, String productId, String productName) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text("Delete Product"),
        content: Text("Are you sure you want to delete '$productName'?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              context.read<ProductCubit>().deleteProduct(productId);
              Navigator.pop(dialogContext);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Deleting $productName...")),
              );
            },
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Expanded(
      child: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductLoaded) {
            final products = state.products;
            
            WidgetsBinding.instance.addPostFrameCallback((_) {
              onCountChanged(products.length);
            });

            if (products.isEmpty) {
              return const Center(child: Text("No products found"));
            }

            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: product.coverPictureUrl != null && product.coverPictureUrl!.isNotEmpty
                              ? Image.network(
                                  product.coverPictureUrl!,
                                  width: 70,
                                  height: 70,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => 
                                      Image.asset('assets/images/product.png', width: 70, height: 70),
                                )
                              : Image.asset('assets/images/product.png', width: 70, height: 70),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name ?? "No Name",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  fontFamily: 'PlayfairDisplay',
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "SAR ${product.price ?? 0}",
                                style: TextStyle(
                                  color: theme.colorScheme.primary, 
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Changed to standard Material Icon for guaranteed visibility
                        IconButton(
                          onPressed: () {
                            if (product.id != null) {
                              _showDeleteDialog(context, product.id!, product.name ?? "this product");
                            }
                          },
                          icon: const Icon(
                            Icons.delete_outline_rounded,
                            color: Colors.redAccent,
                            size: 26,
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
    );
  }
}
