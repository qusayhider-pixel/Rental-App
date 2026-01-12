import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_project/Model/Reservation_model.dart';
import 'package:uni_project/Services/api_service.dart';

class ReservationController extends GetxController{
  final service = ApiService();
  var reservationRequest = <Reservation>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchRerservationRequest();
  }

  void fetchRerservationRequest() async {
    try {
      isLoading(true);
      reservationRequest.value = await service.fetchReservationRequests();
      print(reservationRequest.isEmpty);
      print(reservationRequest[0].bookingStatusCheck);

    } catch (e) {
      e.toString();
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateStatus(int id, String newStatus) async {
    final index = reservationRequest.indexWhere((element) => element.id == id);
    if (index != -1) {
      reservationRequest[index].bookingStatusCheck = newStatus;
      await service.updateReservatoinRequestStatus(newStatus, id);
      reservationRequest.refresh();
    }
    // ReservationStatus message = await service.updateReservatoinRequestStatus(newStatus, id);
    // print(message.message);

    String snackText = newStatus == 'completed' ? 'Reservation Approved' : 'Reservation Rejected';
    Color snackColor = newStatus == 'completed' ?
    Color.fromARGB(132, 9, 245, 1) :
    Color.fromARGB(132, 255, 0, 0);

    Get.snackbar(
      ' Status : ',
      ' $snackText ',
      backgroundColor: snackColor,
      duration: const Duration(milliseconds: 1500),
      borderRadius: 36,
      maxWidth: 250,
      margin: const EdgeInsets.all(10),
      icon:  Icon( newStatus == 'completed' ?
      Icons.check :
      Icons.not_interested

        ,size: 30,
      ),
    );
  }
}




