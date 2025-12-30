import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../Model/apartment_model.dart';


class ApartmentDetailsController extends GetxController {

  var favApartments = <Apartment>[].obs;
  // Selected date range
  var selectedDateRange = Rxn<DateTimeRange>();

  // Update date range
  void updateDateRange(DateTimeRange range) {
    selectedDateRange.value = range;
  }

  // Calculate nights
  int nights() {
    return selectedDateRange.value?.duration.inDays ?? 0;
  }

  // Calculate total price
  double totalPrice(double pricePerNight) {
    return nights() * pricePerNight;
  }

  void addToFav(Apartment apartment) async{

    if(apartment.isFav.value == true)
      {
        await Get.defaultDialog(
            title: "Warning!" ,
            middleText: "You're Removing this Apartment from Your Favourites",
            textConfirm: "Confirm",
            textCancel: "Cancel",
            onConfirm:(){
              apartment.isFav.value = false; // ✅ remove fav
              Get.back();
            },
            radius: 24,
        );
      }
    else {
      apartment.isFav.value = true;
      favApartments.add(apartment);
    }
  }

  }


