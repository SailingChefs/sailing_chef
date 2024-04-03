import 'package:sailing_chefs/core/global_uservariable.dart';

class DishModel {
  String dishId;
  String dishName;
  String dishImagePath;
  String dishPreparationTime;
  String? dishChefId= userDetails!.uid;
  String dishChefImage= userDetails!.displayPicture!;

  DishModel(
      {required this.dishId,
      required this.dishName,
      required this.dishImagePath,
      required this.dishPreparationTime,
      this.dishChefId,
      required this.dishChefImage});
}
