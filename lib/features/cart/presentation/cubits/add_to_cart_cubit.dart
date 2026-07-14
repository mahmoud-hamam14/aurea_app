import 'package:dio/dio.dart';
import 'package:nti_ecommerce_team4/core/error/api_error_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/date_source/cart_get_data.dart';
import 'add_to_cart_state.dart';

class AddToCartCubit extends Cubit<AddToCartState> {
  final CartRemoteDataSource cartRemoteDataSource;

  AddToCartCubit(this.cartRemoteDataSource) : super(CartInitial());

  Future<void> addToCart(
       int quantity,
     {required String productId,
    required String buttonId,
  }) async {
    emit(AddToCartLoading(buttonId: buttonId));
    try {
      final response = await cartRemoteDataSource.addToCart(
        productId: productId,
        quantity: quantity,
      );

      String successMsg = "Product added successfully";
      if (response != null &&
          response is Map &&
          response.containsKey('message')) {
        successMsg = response['message']?.toString() ?? successMsg;
      }

      emit(AddToCartSuccess(message: successMsg, buttonId: buttonId));
    } on DioException catch (e) {
      String errorMsg = "Failed to add product";
      if (e.response?.data != null) {
        final apiError = ApiErrorModel.fromJson(e.response!.data);
        errorMsg = apiError.errorMessage;
      }
      emit(CartError(errorMessage: errorMsg));
    } catch (e) {
      emit(CartError(errorMessage: "An unexpected error occurred"));
    }
  }
}
