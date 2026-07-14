import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:nti_ecommerce_team4/features/products/data/models/product_model.dart';
import 'package:nti_ecommerce_team4/features/products/data/models/review_model.dart';
import '../../../../core/network/dio_helper.dart';

class ProductDetailsRemoteDataSource {
  // Required task: get product by id
  Future<ProductItem> getProductDetails(String productId) async {
    try {
      final response = await DioHelper.dio.get(
        "products/$productId",
        options: Options(contentType: null),
      );
      log("Product details response: ${response.data}");
      return ProductItem.fromJson(response.data);
    } catch (e) {
      log("Error fetching product details: $e");
      rethrow;
    }
  }

  // Required task: get reviews
  Future<ReviewResponse> getReviews(String productId) async {
    try {
      final response = await DioHelper.dio.get(
        "reviews/$productId",
        queryParameters: {"page": 1, "pageSize": 10},
        options: Options(contentType: null),
      );
      return ReviewResponse.fromJson(response.data);
    } catch (e) {
      log("Error fetching reviews: $e");
      rethrow;
    }
  }
}
