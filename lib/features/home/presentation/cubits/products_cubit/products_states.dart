import 'package:nti_ecommerce_team4/features/home/data/models/products_model.dart';

abstract class ProductsStates {}

class ProductsInitialState extends ProductsStates{}

class ProductsLoadingState extends ProductsStates{}

class ProductsSuccessState extends ProductsStates {
  final List<ProductsModel> products;
  final Set<String> favoriteIds;

  ProductsSuccessState({
    required this.products,
    required this.favoriteIds,
  });

  ProductsSuccessState copyWith({
    List<ProductsModel>? products,
    Set<String>? favoriteIds,
  }) {
    return ProductsSuccessState(
      products: products ?? this.products,
      favoriteIds: favoriteIds ?? this.favoriteIds,
    );
  }
}

class ProductsFailiurState extends ProductsStates{}