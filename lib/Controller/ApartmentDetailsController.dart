import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ApartmentDetailsController extends GetxController {
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
}
