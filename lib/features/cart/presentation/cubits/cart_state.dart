import '../../data/models/cart_model.dart';

sealed class CartState {}

final class CartInitial extends CartState {}

final class CartLoading extends CartState {}

final class CartSuccess extends CartState {
  final List<CartModel> cartItems;
  CartSuccess({required this.cartItems});
}

final class CartError extends CartState {
  final String errorMessage;
  CartError({required this.errorMessage});
}

final class AddToCartLoading extends CartState {
  final String buttonId; // 'buyNow' or 'addToCart'
  AddToCartLoading({required this.buttonId});
}

final class AddToCartSuccess extends CartState {
  final String message;
  final String buttonId;
  AddToCartSuccess({required this.message, required this.buttonId});
}
