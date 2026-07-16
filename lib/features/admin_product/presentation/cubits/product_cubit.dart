import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nti_ecommerce_team4/features/admin_product/presentation/cubits/product_state.dart';
import '../../data/date_source/product_service.dart';
import '../../data/models/product_model.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductService service;

  ProductCubit(this.service) : super(ProductInitial());

  Future<void> loadProducts() async {
    emit(ProductLoading());
    final products = await service.getProducts();
    emit(ProductLoaded(products));
  }

  Future<void> addProduct(ProductModel product) async {
    try {
      final success = await service.addProduct(product);
      
      if (success) {
        log("Product added successfully, reloading list...");
        await loadProducts();
      } else {
        emit(ProductError("Server rejected the product. Check logs for details."));
      }
    } on DioException catch (e) {
      String errorMessage = "Failed to add product";
      if (e.response?.data != null) {
        errorMessage = "Server Error: ${e.response?.data}";
      }
      emit(ProductError(errorMessage));
    } catch (e) {
      emit(ProductError("An unexpected error occurred: $e"));
    }
  }

  Future<void> deleteProduct(String id) async {
    final success = await service.deleteProduct(id);
    if (success) {
      await loadProducts();
    } else {
      emit(ProductError("Failed to delete product"));
    }
  }

  Future<void> searchProducts(String query) async {
    emit(ProductLoading());
    final products = await service.searchProducts(query);
    emit(ProductLoaded(products));
  }
}
