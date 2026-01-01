import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_project/Controller/BookingController.dart';
import 'package:uni_project/Services/api_service.dart';

import '../Model/apartment_model.dart';
import '../Model/booking_model.dart';

class ApartmentDetailsController extends GetxController {
  final service = ApiService();

  //-----------apartments-------------------------
  var favApartments = <Apartment>[].obs;
  var selectedDateRange = Rxn<DateTimeRange>();
  final bookings = <BookingRange>[].obs;

  // --------------------Update date range----------
  void updateDateRange(DateTimeRange range) {
    selectedDateRange.value = range;
  }

  //--------------------- Calculate nights--------------
  int nights() {
    return selectedDateRange.value?.duration.inDays ?? 0;
  }

  //----------------adding apartment to favorites---------
  void addToFav(Apartment apartment) async {
    if (apartment.isFav.value == true) {
      await Get.defaultDialog(
        title: "Warning!",
        middleText: "You're Removing this Apartment from Your Favourites",
        textConfirm: "Confirm",
        textCancel: "Cancel",
        onConfirm: () {
          apartment.isFav.value = false; // ✅ remove fav
          Get.back();
        },
        radius: 24,
      );
    } else {
      apartment.isFav.value = true;
      favApartments.add(apartment);
    }
  }

  //----------------fetching the available booking ranges----
  Future<void> fetchBookings(int apartmentId) async {
    try {
      final response = await service.fetchApartmentBookings(apartmentId);

      bookings.value = response;

      Get.find<BookingController>().setBookedRanges(bookings);
    } catch (e) {
      e.toString();
    }
  }
}
