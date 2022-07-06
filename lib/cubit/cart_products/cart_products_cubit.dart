import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:delivery_app/models/food_card_model.dart';
import 'package:delivery_app/services/repositories/cart_products/cart_products_repository.dart';
import 'package:equatable/equatable.dart';
part 'cart_products_state.dart';

class CartProductsCubit extends Cubit<CartProductsState> {
  final CartProductsRepository getAllProductsCart;

  CartProductsCubit(this.getAllProductsCart) : super(CartProductsInitial());

  Future<void> loadCartProducts(uid) async {
    
    try {
      final productStreamData = getAllProductsCart.getCartProducts(uid);
      productStreamData.listen((products) {
        emit(CartProductsLoaded(products));
      });
    } on SocketException {
      emit(const CartProductsError('No Internet connection'));
    } catch (e) {
      emit(CartProductsError(e.toString()));
    }
  }

  Future<void> addProduct(uid, model) async {
    final response = await getAllProductsCart.addProduct(uid, model);
    return response;
  }

  Future<void> deleteProduct(uid, id) async {
    final response = await getAllProductsCart.deleteProduct(uid, id);
    return response;
  }



  Future<void> deleteAllProducts(uid) async {
    final response = await getAllProductsCart.deleteAllProducts(uid);
    return response;
  }
}
