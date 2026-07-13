import 'package:flutter/material.dart';
import 'package:nti_ecommerce_team4/features/admin_product/presentation/widgets/product_service.dart';
import 'product_model.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Product> products = [];
  List<Product> filteredProducts = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    final data = await ProductService().getProducts();
    setState(() {
      products = data;
      filteredProducts = data; 
      isLoading = false;
    });
  }

  void searchProducts(String query) {
    final results = products.where((product) =>
      (product.name ?? "").toLowerCase().contains(query.toLowerCase()) ||
      (product.description ?? "").toLowerCase().contains(query.toLowerCase()) ||
      (product.descriptionArabic ?? "").toLowerCase().contains(query.toLowerCase())
    ).toList();

    setState(() {
      filteredProducts = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search Products')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Search...',
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: searchProducts,
                  ),
                ),
                Expanded(
                  child: filteredProducts.isEmpty
                      ? const Center(child: Text("No products found"))
                      : ListView.builder(
                          itemCount: filteredProducts.length,
                          itemBuilder: (context, index) {
                            final product = filteredProducts[index];
                            return ListTile(
                              title: Text(product.name ?? "No Name"),
                              subtitle: Text(
                                "Price: \$${product.price ?? 0} | Stock: ${product.stock ?? 0}",
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
    );
  }
}