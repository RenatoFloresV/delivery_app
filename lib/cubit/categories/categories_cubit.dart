import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:delivery_app/models/categorys_model.dart';
import 'package:delivery_app/services/repositories/category/category_repository.dart';
import 'package:equatable/equatable.dart';
part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final CategoryRepository getAllCategoriesUseCase;
  CategoriesCubit(this.getAllCategoriesUseCase) : super(CategoriesInitial());

  Future<void> getCategories() async {
    try {
      final productStreamData = getAllCategoriesUseCase.getAllCategories();
      productStreamData.listen((name) {
        emit(CategoriesLoaded(name));
      });
    } on SocketException {
      emit(const CategoriesError('No Internet connection'));
    } catch (e) {
      emit(CategoriesError(e.toString()));
    }
  }

  // Future<void> addCategory(CategoryModel model) async {
  //   final response = await getAllCategoriesUseCase.addCategory(model);
  //   return response;
  // }

  Future<void> deleteCategory(id) async {
    final response = await getAllCategoriesUseCase.deleteCategory(id);

    return response;
  }

  Future<void> add(id) async {
    final response = await getAllCategoriesUseCase.add(id);
    return response;
  }

}
