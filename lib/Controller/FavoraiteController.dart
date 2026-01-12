import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_project/Model/FavoriteModel.dart';
import 'package:uni_project/Services/api_service.dart';
import '../Model/apartment_model.dart';
import 'FilterController.dart';

class FavoriteController extends GetxController {
  ApiService service = ApiService();
  var myFav = <MyFavoriteModel>[].obs;
  var isLoading = false.obs;
  var isFav = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchMyFav();
  }

  void fetchMyFav() async {
    try {
      isLoading(true);
      myFav.value = await service.fetchingMyFavorites();
      print("Is My favorites empty ? : ${myFav.isEmpty}");
    } catch (e) {
      Get.snackbar('Error', 'Failed to load my favorites');
    } finally {
      isLoading(false);
    }
  }

  void addOrDelete_Fav(Apartment apartment) async {
    if (apartment.isFav.value) {
      await Get.defaultDialog(
        title: "Warning!",
        middleText: "You're Removing this Apartment from Your Favourites",
        textConfirm: "Confirm",
        textCancel: "Cancel",
        onConfirm: () async {
          apartment.isFav.value = false;
          await service.removeFromFav(apartment.id);
          Get.back();
          Get.snackbar(
            "LUXESTAY",
            "Removing From Favorites Done \n Please Refresh The Page",
            backgroundColor: Color.fromARGB(166, 245, 1, 9),
            borderRadius: 30,
            maxWidth: 250,
            margin: const EdgeInsets.all(4),
            icon: Icon(Icons.heart_broken, size: 30),
          );
        },
        radius: 24,
      );
    } else {
      await service.addToFav(apartment.id);
      apartment.isFav.value = true;
      Get.snackbar(
        "LUXESTAY",
        "Adding To Favorites Done",
        backgroundColor: Color.fromARGB(192, 245, 1, 103),
        borderRadius: 30,
        maxWidth: 250,
        margin: const EdgeInsets.all(4),
        icon: Icon(Icons.favorite, size: 30),
      );
    }
  }

  bool isFavorite(int id) {
    int aptId = myFav.firstWhere((apt) => apt.id == id).id;

    return aptId != 0 ? true : false;
  }
}
