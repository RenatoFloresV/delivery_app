import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String? id;
  String? categoryName;
  // DocumentReference? reference;

  CategoryModel({
    this.id,
    this.categoryName,
    // this.reference,
  });

  List<Object> get props => [categoryName!];

  static CategoryModel fromSnapshot(DocumentSnapshot snapshot) {
    CategoryModel categorysModel = CategoryModel(
      id: snapshot.id,

      categoryName: snapshot['categoryName'],
      // reference: snapshot.reference,
    );
    return categorysModel;
  }
  // CategoryModel.fromJson(Map<String, dynamic> json) {
  //   name = json['name'];
  // }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'categoryName': name,
  //   };
  // }
}
