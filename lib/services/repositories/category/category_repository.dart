import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/models/categorys_model.dart';

class CategoryRepository {
  final _categorysCollection =
      FirebaseFirestore.instance.collection('categories');

  Stream<List<CategoryModel>> getAllCategories() {
    return _categorysCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => CategoryModel.fromSnapshot(doc))
          .toList();
    });
  }

  Future<void> deleteCategory(id) async {
    return _categorysCollection.doc(id).delete();
  }

  Future<void> add(id) async {
    return _categorysCollection.doc(id).set({'categoryName': id});
  }
}
