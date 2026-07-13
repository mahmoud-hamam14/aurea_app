import 'package:dio/dio.dart';
import 'package:nti_ecommerce_team4/features/admin_product/presentation/widgets/product_model.dart';


class ProductService {
  final Dio dio = Dio(BaseOptions(baseUrl: "https://accessories-eshop.runasp.net/api"));

  Future<List<Product>> getProducts() async {
    try {
      final response = await dio.get("/products");
      return (response.data as List)
          .map((json) => Product.fromJson(json))
          .toList();
    } catch (e) {
      print("Error fetching products: $e");
      return [];
    }
  }

  Future<void> addProduct(Product product) async {
    try {
      final response = await dio.post("/products", data: product.toJson());
      print("Product added: ${response.data}");
    } catch (e) {
      print("Error adding product: $e");
    }
  }

  Future<void> deleteProduct(String id) async {
    try {
      final response = await dio.delete("/products/$id");
      print("Product deleted: ${response.data}");
    } catch (e) {
      print("Error deleting product: $e");
    }
  }
}