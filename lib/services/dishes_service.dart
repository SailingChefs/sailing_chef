import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sailing_chefs/model/dish_model.dart';

class DishesService {
   List<DishModel> dishes=[];
  Future<List<DishModel>> fetchDishes() async {
    EasyLoading();
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('recipes').get();
      dishes = querySnapshot.docs.map((doc) => DishModel.fromSnapshot(doc)).toList();
      return dishes;
    } catch (e) {
      log('Error fetching dishes: $e');
      return [];
    }
  }
}


