import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/models/food_card_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProductsRepository {
  final _products = FirebaseFirestore.instance.collection('categories');
  String? categoryName;

  Stream<List<FoodCardModel>> getAllProducts() {
    return _products.doc('awa').collection('awa').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return FoodCardModel(
          id: doc.id,
          name: doc['name'],
          price: doc['price'],
          imgUrl: doc['imgUrl'],
        );
      }).toList();
    });
  }

  Future<void> addProductForCategory(
      FoodCardModel model, categoryName, File selectedImage) async {
    final Reference storageReference =
        FirebaseStorage.instance.ref().child('$categoryName/${model.name}');
    final UploadTask uploadTask = storageReference.putFile(selectedImage);
    final TaskSnapshot downloadUrl =
        (await uploadTask.whenComplete(() => print('File Uploaded')));
    final String url = (await downloadUrl.ref.getDownloadURL());
    model.imgUrl = url;
    return FirebaseFirestore.instance
        .collection('categories')
        .doc(categoryName)
        .collection(categoryName)
        .doc(model.name)
        .set({
          'name': model.name,
          'price': model.price,
          'imgUrl': model.imgUrl,
          'categoryName': categoryName,
          'id': model.id,
          'quantity': model.quantity,
        })
        .then((value) => print('Product Added'))
        .catchError((error) => print(error));
  }

  Stream<List<FoodCardModel>> getProductsForCategory(categoryName) {
    final _getForCategory =
        _products.doc(categoryName).collection(categoryName);
    return _getForCategory.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => FoodCardModel.fromSnapshot(doc))
          .toList();
    });
  }
}
