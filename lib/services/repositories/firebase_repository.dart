import '../../models/index.dart';

abstract class FirebaseRepository {
  //cart products repository
  Future<void> addProduct(FoodCardModel model);
  Future<void> deleteProduct(id);
  Future<void> deleteAllProducts();
  Stream<List<FoodCardModel>> getCartProducts();

// category repository
  Stream<List<CategoryModel>> getAllCategories();
  Future<void> deleteCategory(id);
  Future<void> add(id);

  // products repository
  Stream<List<FoodCardModel>> getAllProducts();
  Future<void> addProductForCategory(FoodCardModel model, categoryName);

  //products for category repository
  Stream<List<FoodCardModel>> getProductsForCategory(categoryName);
}
