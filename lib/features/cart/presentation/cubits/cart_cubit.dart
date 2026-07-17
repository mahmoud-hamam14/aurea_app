import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nti_ecommerce_team4/features/cart/data/date_source/cart_get_data.dart';
import 'package:nti_ecommerce_team4/features/cart/data/models/cart_item_model.dart';
import 'package:nti_ecommerce_team4/features/cart/presentation/cubits/cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRemoteDataSource dataSource = CartRemoteDataSource();

  List<CartItemModel> cartItems = [];

  CartCubit() : super(CartInitialState());

  Future<void> getCart() async {
    emit(CartLoadingState());
    try {
      cartItems = await dataSource.getCart();
      calculateAndEmit();
    } catch (e) {
      emit(CartErrorState(errorMessage: e.toString()));
    }
  }

  void calculateAndEmit() {
    double subtotal = 0;
    double discount = 0;

    for (var item in cartItems) {
      subtotal += item.basePricePerUnit * item.quantity;
      discount += (item.basePricePerUnit - item.finalPricePerUnit) * item.quantity;
    }


    double total = subtotal - discount;

    emit(CartSuccessState(
      items: List.from(cartItems),
      subtotal: subtotal,
      discount: discount,
      total: total,
    ));
  }

  Future<void> updateQuantity(String itemId, int newQuantity) async {
    if (newQuantity < 1) return;


    final index = cartItems.indexWhere((item) => item.itemId == itemId);
    if (index != -1) {
      final item = cartItems[index];
      cartItems[index] = CartItemModel(
        itemId: item.itemId,
        productId: item.productId,
        productName: item.productName,
        productCoverUrl: item.productCoverUrl,
        productStock: item.productStock,
        weightInGrams: item.weightInGrams,
        quantity: newQuantity,
        discountPercentage: item.discountPercentage,
        basePricePerUnit: item.basePricePerUnit,
        finalPricePerUnit: item.finalPricePerUnit,
        totalPrice: item.finalPricePerUnit * newQuantity,
      );

      
      calculateAndEmit();

    }
  }

  Future<void> deleteCartItem(String id) async {
    final removedItem = cartItems.firstWhere((item) => item.itemId == id);
    cartItems.removeWhere((item) => item.itemId == id);
    calculateAndEmit();

    try {
      await dataSource.deleteCartItem(id);
    } catch (e) {
      cartItems.add(removedItem);
      calculateAndEmit();
      emit(CartErrorState(errorMessage: "Failed to delete item: ${e.toString()}"));
    }
  }
}
