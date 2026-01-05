
import 'package:get/get.dart';
import 'package:uni_project/Controller/ApartmentDetailsController.dart';
import 'package:uni_project/Controller/BookingController.dart';
import 'package:uni_project/Controller/MyReservationsController.dart';
import 'package:uni_project/Controller/SignUpController.dart';

import 'Controller/LoginController.dart';
import 'Controller/ReservationController.dart';

class MyBinding extends Bindings{


  @override
  void dependencies() {
    Get.lazyPut(()=>LoginController() , fenix: true);
    Get.lazyPut(()=>SignUpController() ,fenix:  true);
    Get.lazyPut(()=>ApartmentDetailsController() , fenix: true);
    Get.lazyPut(()=>BookingController() , fenix: true);
    Get.lazyPut(()=>ReservationController() , fenix: true);
    Get.lazyPut(()=>MyReservationsController() , fenix: true);
  }
}