import 'package:cloud_firestore/cloud_firestore.dart';

class DishModel {
  String dishId;
  String dishName;
  String dishImagePath;
  String dishPreparationTime;
  String? dishChefId;
  String dishChefImage;

  DishModel(
      {required this.dishId,
      required this.dishName,
      required this.dishImagePath,
      required this.dishPreparationTime,
      this.dishChefId,
      required this.dishChefImage});

  factory DishModel.fromSnapshot(DocumentSnapshot snapshot) {
    return DishModel(
      dishId: snapshot.id,
      dishName: snapshot['title'],
      dishImagePath: snapshot['cover_image'] is List
          ? snapshot['cover_image'].first.toString()
          : snapshot['cover_image'],
      dishPreparationTime: snapshot['prep_time'],
      dishChefImage: snapshot['cover_image'],
    );
  }
}
