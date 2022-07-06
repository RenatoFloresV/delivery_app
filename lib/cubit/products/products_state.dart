part of 'products_cubit.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object> get props => [];
}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsLoaded extends ProductsState {
  final List<FoodCardModel> products;
  const ProductsLoaded(
      [this.products = const []]);

  @override
  List<Object> get props => [products];

  @override
  String toString() => 'Products loaded';
}

class ProductsNoLoaded extends ProductsState {}

class ProductsError extends ProductsState {
  final String error;

  const ProductsError(this.error);

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'ProductsError { error: $error }';
}
