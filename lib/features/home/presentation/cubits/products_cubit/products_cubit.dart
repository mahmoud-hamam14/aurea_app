import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nti_ecommerce_team4/features/home/data/date_source/products_data_source.dart';
import 'package:nti_ecommerce_team4/features/home/presentation/cubits/products_cubit/products_states.dart';

class ProductsCubit extends Cubit<ProductsStates> {
  ProductsCubit() : super(ProductsInitialState());

  final ProductsDataSource remoteDataSource = ProductsDataSource();

  Set<String> favoriteIds = {};

  Future<void> getProducts() async {
    emit(ProductsLoadingState());
    try {
      final products = await remoteDataSource.getProducts();

      emit(ProductsSuccessState(
        products: products,
        favoriteIds: favoriteIds, 
      ));
    }on DioException catch (e) {
      if(e.type == DioExceptionType.connectionTimeout
      || e.type == DioExceptionType.receiveTimeout){
        emit(ProductsFailiurState(message: "Request timeout"));
      }
      else if(e.type== DioExceptionType.connectionError){
        emit(ProductsFailiurState(message:"No Internet Connection"));
      }
      else{
        emit(ProductsFailiurState(message: "Server Error"));
      }
    }
    catch(e){
      emit(ProductsFailiurState(message: "Unexpected error"));
    }
  }

  void toggleFavorite(String productId) {
    if (favoriteIds.contains(productId)) {
      favoriteIds.remove(productId);
    } else {
      favoriteIds.add(productId);
    }

    if (state is ProductsSuccessState) {
      final currentState = state as ProductsSuccessState;

      emit(currentState.copyWith(
        favoriteIds: Set.from(favoriteIds),
      ));
    }
  }
}