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
      required this.dishChefImage,
      this.dishChefId});

  factory DishModel.fromSnapshot(DocumentSnapshot snapshot) {
    return DishModel(
      dishId: snapshot.id,
      dishName:
          (snapshot.data() as Map<String, dynamic>?)?['title']?.toString() ??
              '',
      dishImagePath: (() {
        final cover =
            (snapshot.data() as Map<String, dynamic>?)?['cover_image'];
        if (cover is List && cover.isNotEmpty) {
          return cover.first.toString();
        }
        return cover?.toString() ?? '';
      })(),
      dishPreparationTime:
          (snapshot.data() as Map<String, dynamic>?)?['prep_time']
                  ?.toString() ??
              '',
      dishChefImage:
          ((snapshot.data() as Map<String, dynamic>?)?['cover_image'])
                  ?.toString() ??
              '',
    );
  }
}
