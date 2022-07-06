part of 'cart_products_cubit.dart';

abstract class CartProductsState extends Equatable {
  const CartProductsState();

  @override
  List<Object> get props => [];
}

class CartProductsInitial extends CartProductsState {}

class CartProductsLoading extends CartProductsState {}

class CartProductsLoaded extends CartProductsState {
  final List<FoodCardModel> cartProducts;

  const CartProductsLoaded([this.cartProducts = const []]);

  @override
  List<Object> get props => [cartProducts];

  @override
  String toString() => 'CartProducts loaded';
}

class CartProductsNoLoaded extends CartProductsState {}

class CartProductsError extends CartProductsState {
  final String error;

  const CartProductsError(this.error);

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'CartProductsError { error: $error }';
}
