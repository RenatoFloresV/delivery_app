import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/index.dart';

class CartProductsRepository {

  Stream<List<FoodCardModel>> getCartProducts(uid) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('cart_list').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => FoodCardModel.fromSnapshot(doc))
          .toList();
    });
  }

  Future<void> addProduct(uid, FoodCardModel model) async {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('cart_list')
        .add({
          'name': model.name,
          'imgUrl': model.imgUrl,
          'categoryName': model.category,
          'price': model.price,
          'id': model.id,
          'quantity': model.quantity,
        })
        .then((value) => print('${model.name} Añadido'))
        .catchError((error) => print(error));
  }

  Future<void> deleteProduct(uid, id) async {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('cart_list').doc(id).delete();
  }

  Future<void> deleteAllProducts(uid) async {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('cart_list').get().then((snapshot) {
      for (var doc in snapshot.docs) {
        doc.reference.delete();
      }
    });
  }
}
