import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nti_ecommerce_team4/features/admin_product/presentation/widgets/product_service.dart';

class AddProductListview extends StatefulWidget {
  final Function(int) onCountChanged;
  const AddProductListview({super.key,required this.onCountChanged});

  @override
  State<AddProductListview> createState() => _AddProductListviewState();
}

class _AddProductListviewState extends State<AddProductListview> {
  List<dynamic> products = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    setState(() {
       isLoading = true;});
    final data = await ProductService().getProducts();
    setState(() {
      products = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (isLoading) {
      return const Expanded(
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (products.isEmpty) {
      return const Expanded(
        child: Center(child: Text("No products found")),
      );
    }

    return Expanded(
      child: ListView.builder(
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
                          product['nameEn'] ?? "No Name",
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                            fontFamily: 'PlayfairDisplay',
                          ),
                        ),
                        Text(
                          "\$${product['price'] ?? 0}",
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        Text(
                          "In Stock: ${product['stock'] ?? 0} units",
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      await ProductService().deleteProduct(product['id']);
                      _loadProducts(); 
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
      ),
    );
  }
}