import 'dart:developer';
import 'package:nti_ecommerce_team4/core/network/dio_helper.dart';
import 'package:nti_ecommerce_team4/features/admin_product/data/models/product_model.dart';

class ProductService {
  Future<List<ProductModel>> getProducts() async {
    try {

      final response = await DioHelper.get(url: "products");
      
      if (response.data != null && response.data['items'] != null) {
        final data = response.data['items'] as List;
        return data.map((json) => ProductModel.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
     // log("Error fetching products in Admin: $e");
      return [];
    }
  }

  Future<bool> addProduct(ProductModel product) async {
    try {
      final data = product.toJson();
      final response = await DioHelper.post(url: "products", data: data);
      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
     // log("Error adding product: $e");
      return false;
    }
  }

  Future<bool> deleteProduct(String id) async {
    try {
      final response = await DioHelper.delete(url: "products/$id");
      return response.statusCode == 200 || response.statusCode == 204;
    } catch (e) {
      return false;
    }
  }

  Future<List<ProductModel>> searchProducts(String query) async {
    try {
      final response = await DioHelper.get(url: "products", queryParameters: {"name": query});
      if (response.data != null && response.data['items'] != null) {
        final data = response.data['items'] as List;
        return data.map((json) => ProductModel.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }
}
