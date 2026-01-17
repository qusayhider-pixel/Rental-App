import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:uni_project/Controller/ApartmentDetailsController.dart';

import '../Model/booking_model.dart';
import '../Services/api_service.dart';

class BookingController extends GetxController {
  final service = ApiService();
  //-----------booking variables------------------

  var requestId = 0.obs;
  var requestStatus = ''.obs;
  var isLoading = false.obs;
  final RxSet<DateTime> disabledDays = <DateTime>{}.obs;
  final Rxn<DateTimeRange> selectedRange = Rxn<DateTimeRange>();
  var focusedDay = DateTime
      .now()
      .obs;

  //------------booking method-------------------

  void getBookingId(int apartmentId) async {
    if (selectedRange.value == null) return;

    isLoading.value = true;

    try {
      Booking booking = await service.booking(
        DateFormat(
          'yyyy-MM-dd',
        ).format(selectedRange.value!.start),
        DateFormat(
          'yyyy-MM-dd',
        ).format(selectedRange.value!.end),
        apartmentId,
      );

      requestId.value = booking.id;
      requestStatus.value = booking.status;

      print("Booking ID: ${booking.id}");
      print("Status: ${booking.status}");
    } catch (e) {
      if (e is DioException) {
        if (e.response?.data != null && e.response?.data['message'] != null) {
        } else {
          Get.snackbar("Message", '${e.response?.data}');
          print("❌ Server Response: ${e.response?.data}");
        }
      }
      // Get.snackbar("Error", " booking is already bending ", backgroundColor: Colors.red,);
    } finally {
      isLoading.value = false;
    }
  }

  //-------------------available booking ranges------------------------

  void setBookedRanges(List<BookingRange> ranges) {
    final Set<DateTime> days = {};

    for (final range in ranges) {
      for (int i = 0; i <= range.end.difference(range.start).inDays; i++) {
        days.add(
          DateTime(range.start.year, range.start.month, range.start.day + i),
        );
      }
    }
    disabledDays.assignAll(days);
    print(disabledDays);
  }

  bool isDisabled(DateTime day) {
    return disabledDays.any((d) => isSameDay(d, day));
  }

  void updateRange(DateTimeRange range) {
    selectedRange.value = range;
  }

  int nights() {
    return selectedRange.value?.duration.inDays ?? 0;
  }
}
