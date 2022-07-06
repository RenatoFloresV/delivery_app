// we need to create our data model for the name card

import 'package:cloud_firestore/cloud_firestore.dart';

class FoodCardModel {
  String? id;
  String? name;
  String? imgUrl;
  // String? restorant;
  String? category;
  // String? reference;
  int? quantity;
  // String? note;
  String? price;
  // String? description;

  FoodCardModel({
    this.id,
    this.name,
    this.imgUrl,
    // this.restorant,
    this.category,
    // this.reference,
    this.quantity,
    // this.note,
    this.price,
    // this.description,
  });

  List<Object> get props => [
        id!,
        name!,
        imgUrl!,
        // restorant!,
        category!,
        // reference!,
        quantity!,
        // note,
        price!,
        // description!,
      ];

  static FoodCardModel fromSnapshot(DocumentSnapshot snapshot) {
    FoodCardModel nameCardModel = FoodCardModel(
      id: snapshot.id,
      name: snapshot['name'] ?? '',
      imgUrl: snapshot['imgUrl'] ?? ' ',
      category: snapshot['categoryName'] ?? '',
      quantity: snapshot['quantity'] ?? 0,
      price: snapshot['price'] ?? '',
    );
    return nameCardModel;
  }
}