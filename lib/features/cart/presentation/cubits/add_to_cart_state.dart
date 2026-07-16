import 'package:nti_ecommerce_team4/features/cart/data/models/cart_item_model.dart';


sealed class AddToCartState {}

final class CartInitial extends AddToCartState {}

final class CartLoading extends AddToCartState {}

final class CartSuccess extends AddToCartState {
  final List<CartItemModel> cartItems;
  CartSuccess({required this.cartItems});
}

final class CartError extends AddToCartState {
  final String errorMessage;
  CartError({required this.errorMessage});
}

final class AddToCartLoading extends AddToCartState {
  final String buttonId; // 'buyNow' or 'addToCart'
  AddToCartLoading({required this.buttonId});
}

final class AddToCartSuccess extends AddToCartState {
  final String message;
  final String buttonId;
  AddToCartSuccess({required this.message, required this.buttonId});
}
