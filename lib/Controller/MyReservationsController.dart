import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:uni_project/Model/Reservation_model.dart';
import 'package:uni_project/Model/booking_model.dart';
import 'package:uni_project/Services/api_service.dart';

class MyReservationsController extends GetxController {
  ApiService service = ApiService();
  var myReservation = <MyReservations>[].obs;
  var myReservationFiltered = <MyReservations>[].obs;
  final otherBookings = <BookingRange>[].obs;
  var isLoading = false.obs;
  RxString filter = ''.obs;

  //-----------------------------------------
  var selectedRange = Rxn<DateTimeRange>();
  final disabledDays = <DateTime>{}.obs;
  var focusedDay = DateTime
      .now()
      .obs;

  //-----------------------------------------
  void applyFilters() {
    final result = myReservation.where((booking) {
      final matchesStatus = booking.bookingStatusCheck == filter.value;

      return matchesStatus;
    }).toList();

    myReservationFiltered.assignAll(result);
    update(); // for GetBuilder
  }

  // Reset Filters---------------------------------------------------------------------------
  void resetFilters() {
    print('🔄 Reset filters');
    fetchingMyReservations();
    update();
  }


  //-----------------------------------------
  @override
  void onInit() {
    super.onInit();
    fetchingMyReservations();
  }

  void fetchingMyReservations() async {
    try {
      isLoading(true);
      myReservation.value = await service.fetchingMyReservations();
      myReservationFiltered.assignAll(myReservation);
      print(myReservation.isEmpty);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load');
    } finally {
      isLoading(false);
    }
  }

  void rateBooking(MyReservations booking, int stars) {
    final index = myReservation.indexWhere((element) =>
    element.id == booking.id);
    if (index != -1 && myReservation[index].rating == 0) {
      myReservation[index].rating = stars.toDouble();
      myReservation.refresh();
      service.ratingApartment(booking.apartmentId, stars);
      Get.snackbar(
        "LUXESTAY",
        "Thank you for your Feedback",
        backgroundColor: const Color.fromARGB(215, 178, 145, 239),
        borderRadius: 30,
        maxWidth: 250,
        margin: const EdgeInsets.all(10),
        icon: Icon(Icons.thumb_up_alt_sharp, size: 30),
      );
    }
  }

  void editDates(int bookingId) async {
    isLoading(true);
    try {
      await service.editingBookingDates(
        DateFormat('yyyy-MM-dd').format(selectedRange.value!.start),
        DateFormat('yyyy-MM-dd').format(selectedRange.value!.end),
        bookingId,
      );

      Get.snackbar(
        "Booking Updated !",
        "Please Refresh the Page ",
        backgroundColor: const Color.fromARGB(132, 9, 245, 1),
        borderRadius: 30,
        maxWidth: 250,
        margin: const EdgeInsets.all(10),
        icon: Icon(Icons.done_outline_sharp, size: 30),
      );
      focusedDay = DateTime
          .now()
          .obs;
    } catch (e) {
      if (e is DioException) {
        if (e.response?.data != null && e.response?.data['message'] != null) {
        } else {
          //  Get.snackbar("Message", '${e.response?.data}');
          print("❌ Server Response: ${e.response?.data}");
        }
      }
      // Get.snackbar("Error", " booking is already bending ", backgroundColor: Colors.red,);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchOtherBookings(int apartmentId, int bookingId) async {
    try {
      final response = await service.fetchingForEditingRanges(
        apartmentId,
        bookingId,
      );
      otherBookings.value = response;
      final Set<DateTime> days = {};
      for (final range in otherBookings) {
        for (int i = 0; i <= range.end.difference(range.start).inDays; i++) {
          days.add(
            DateTime(range.start.year, range.start.month, range.start.day + i),
          );
        }
      }
      disabledDays.assignAll(days);
      print("The disabled days with out this booknig : ");
      print(disabledDays);
    } catch (e) {
      e.toString();
    }
  } //for editing the dates + showing all the available ranges

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

  Future<void> updateStatus(MyReservations booking) async {
    final index = myReservation.indexWhere(
      (element) => element.id == booking.id,
    );
    if (index != -1) {
      if (booking.isCanceled.value == false) {
        await Get.defaultDialog(
          title: "Warning!",
          middleText: "You're Canceling this Booking !",
          textConfirm: "CONFIRM",
          titleStyle: TextStyle(color: Colors.white, fontFamily: 'Multicolore'),
          titlePadding: EdgeInsets.symmetric(vertical: 20),
          cancelTextColor: Colors.white,
          buttonColor: Colors.white,
          textCancel: "Cancel",
          middleTextStyle: TextStyle(color: Colors.white, fontSize: 17),
          backgroundColor: Color.fromARGB(132, 255, 0, 0),
          confirmTextColor: Color.fromARGB(255, 124, 0, 0),
          onConfirm: () {
            booking.isCanceled.value = true;
            Get.back();
          },
          radius: 24,
        );
      }
      if (booking.isCanceled.value) {
        myReservation[index].isCanceled(true);
        await service.cancelingABooking(booking.id);
        myReservation.refresh();

        Get.snackbar(
          ' LUXESTAY : ',
          ' Booking Canceled Successfully',
          backgroundColor: Color.fromARGB(171, 76, 174, 80),
          duration: const Duration(milliseconds: 1500),
          borderRadius: 36,
          maxWidth: 300,
          margin: const EdgeInsets.all(10),
          icon: Icon(Icons.delete_sweep, size: 30),
        );
      }
    }
  }
}
