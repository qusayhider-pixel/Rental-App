import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../View/Screens/ReservationManageScreen.dart';

class ReservationManagementController extends GetxController {

  var requests = <BookingRequest>[
    BookingRequest(
      id: '1',
      renterName: 'Ahmed Ali',
      renterImage: 'https://i.pravatar.cc/150?img=11',
      phoneNumber: '+966 50 123 4567',
      apartmentName: 'Sunny Beach View Apt',
      duration: '3 Nights (10 - 13 Oct)',
      totalPrice: 450.0,
    ),
    BookingRequest(
      id: '2',
      renterName: 'Sara Smith',
      renterImage: 'https://i.pravatar.cc/150?img=5',
      phoneNumber: '+1 202 555 0199',
      apartmentName: 'Downtown Luxury Loft',
      duration: '7 Nights (15 - 22 Oct)',
      totalPrice: 1200.0,
    ),
  ].obs;

  void updateStatus(String id, String newStatus) {
    final index = requests.indexWhere((element) => element.id == id);
    if (index != -1) {
      requests[index].status = newStatus;
      requests.refresh();
    }

    String snackText = newStatus == 'Approved' ? 'Reservation Approved' : 'Reservation Rejected';

    Color snackColor = newStatus == 'Approved' ?
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
      icon:  Icon( newStatus == 'Approved' ?
      Icons.check :
      Icons.not_interested

        ,size: 30,
      ),


    );
  }
}
