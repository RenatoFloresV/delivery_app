import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:delivery_app/models/food_card_model.dart';
import 'package:delivery_app/services/repositories/products/products_repository.dart';
import 'package:equatable/equatable.dart';
part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final ProductsRepository getAllProductsUseCase;

  ProductsCubit(this.getAllProductsUseCase) : super(ProductsInitial());

  Future<void> loadProducts() async {
    try {
      final productStreamData = getAllProductsUseCase.getAllProducts();
      productStreamData.listen((products,) {
        emit(ProductsLoaded(products));
      });
    } on SocketException {
      emit(const ProductsError('No Internet connection'));
    } catch (e) {
      emit(ProductsError(e.toString()));
    }
  }
  Future<void> productForCategory(categoryName) async {
    try {
      final productStreamData = getAllProductsUseCase.getProductsForCategory(categoryName);
      productStreamData.listen((products,) {
        emit(ProductsLoaded(products));
      });
    } on SocketException {
      emit(const ProductsError('No Internet connection'));
    } catch (e) {
      emit(ProductsError(e.toString()));
    }
  }

  Future<void> addProductForCategory(FoodCardModel model, categoryName, selectedImage) async {
    return await getAllProductsUseCase.addProductForCategory(model, categoryName, selectedImage);
  }
}
