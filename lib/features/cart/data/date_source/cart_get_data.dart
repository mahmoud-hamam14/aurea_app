import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:nti_ecommerce_team4/core/network/token_manager.dart';
import 'package:nti_ecommerce_team4/features/cart/data/models/cart_item_model.dart';

import '../../../../core/network/dio_helper.dart';

class CartRemoteDataSource {
  final Dio _dio = Dio(
    BaseOptions(baseUrl: "https://accessories-eshop.runasp.net/api/"),
  );

  Future<List<CartItemModel>> getCart() async {
    final token = await TokenManager.getToken();

    final response = await _dio.get(
      "cart",

      options: Options(headers: {"Authorization": "Bearer $token"}),
    );

    final List items = response.data["cartItems"] ?? [];

    return items.map((item) => CartItemModel.fromJson(item)).toList();
  }

  Future<void> deleteCartItem(String id) async {
    final token = await TokenManager.getToken();

    await _dio.request(
      "cart/items/$id",
      options: Options(
        method: "DELETE",
        headers: {"Authorization": "Bearer $token", "Content-Type": "*/*"},
      ),
      data: {"id": id},
    );
  }
  Future<dynamic> addToCart({required String productId, int quantity = 1}) async {
    try {
      final response = await DioHelper.post(
        url: "cart/items",
        data: {
          "productId": productId,
          "quantity": quantity,
        },
      );
      return response.data;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}