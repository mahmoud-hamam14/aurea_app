import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nti_ecommerce_team4/features/cart/data/date_source/cart_get_data.dart';
import 'package:nti_ecommerce_team4/features/cart/data/models/cart_item_model.dart';
import 'package:nti_ecommerce_team4/features/cart/presentation/cubits/cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRemoteDataSource _dataSource = CartRemoteDataSource();

  List<CartItemModel> _cartItems = [];

  CartCubit() : super(CartInitialState());

  Future<void> getCart() async {
    emit(CartLoadingState());
    try {
      _cartItems = await _dataSource.getCart();
      _calculateAndEmit();
    } catch (e) {
      emit(CartErrorState(errorMessage: e.toString()));
    }
  }

  void _calculateAndEmit() {
    double subtotal = 0;
    double discount = 0;

    for (var item in _cartItems) {
      subtotal += item.basePricePerUnit * item.quantity;
      // Discount is per unit: (base - final) * quantity
      discount += (item.basePricePerUnit - item.finalPricePerUnit) * item.quantity;
    }

    // Add a generic seasonal offer if needed, but here we assume it's part of the items or 10%
    // Let's stick to the items' specific discounts first as they come from the API
    // Or if the requirement says exactly 10% off the whole subtotal:
    // discount = subtotal * 0.10; 
    
    double total = subtotal - discount;

    emit(CartSuccessState(
      items: List.from(_cartItems),
      subtotal: subtotal,
      discount: discount,
      total: total,
    ));
  }

  Future<void> updateQuantity(String itemId, int newQuantity) async {
    if (newQuantity < 1) return;
    
    // Find item
    final index = _cartItems.indexWhere((item) => item.itemId == itemId);
    if (index != -1) {
      // Create updated item (CartItemModel is immutable based on the code provided, so we create a new instance)
      final item = _cartItems[index];
      _cartItems[index] = CartItemModel(
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
      
      _calculateAndEmit();
      
      // Optionally sync with server here if there was an update endpoint
      // try { await _dataSource.updateQuantity(itemId, newQuantity); } catch(e) { ... }
    }
  }

  Future<void> deleteCartItem(String id) async {
    // Optimistic delete
    final removedItem = _cartItems.firstWhere((item) => item.itemId == id);
    _cartItems.removeWhere((item) => item.itemId == id);
    _calculateAndEmit();

    try {
      await _dataSource.deleteCartItem(id);
    } catch (e) {
      // Revert if failed
      _cartItems.add(removedItem);
      _calculateAndEmit();
      emit(CartErrorState(errorMessage: "Failed to delete item: ${e.toString()}"));
    }
  }
}
