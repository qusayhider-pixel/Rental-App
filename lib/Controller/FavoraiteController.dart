import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_project/Services/api_service.dart';
import '../Model/apartment_model.dart';

class FavoriteController extends GetxController {
  ApiService service = ApiService();

  void addOrDelete_Fav(Apartment apartment) async {
    if (apartment.isFav.value == true) {
      await Get.defaultDialog(
        title: "Warning!",
        middleText: "You're Removing this Apartment from Your Favourites",
        textConfirm: "Confirm",
        textCancel: "Cancel",
        onConfirm: () async {
          apartment.isFav.value = false; // ✅ remove fav
          await service.removeFromFav(apartment.id);
          Get.back();
        },
        radius: 24,
      );
    } else {
      apartment.isFav.value = true;
      await service.addToFav(apartment.id);
      Get.snackbar(
        "LUXESTAY",
        "Adding To Favorites Success",
        backgroundColor: Color.fromARGB(192, 245, 1, 103),
        borderRadius: 30,
        maxWidth: 200,
        margin: const EdgeInsets.all(4),
        icon: Icon(Icons.favorite, size: 30),
      );
    }
  }
}
