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
}
