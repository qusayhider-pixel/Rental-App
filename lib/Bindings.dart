
import 'package:get/get.dart';
import 'package:uni_project/Controller/ApartmentDetailsController.dart';
import 'package:uni_project/Controller/AuthController.dart';
import 'package:uni_project/Controller/BookingController.dart';
import 'package:uni_project/Controller/ConversationController.dart';
import 'package:uni_project/Controller/FavoraiteController.dart';
import 'package:uni_project/Controller/MyReservationsController.dart';
import 'package:uni_project/Controller/NotificationController.dart';
import 'package:uni_project/Controller/ProfileController.dart';
import 'package:uni_project/Controller/SignUpController.dart';
import 'Controller/ChatController.dart';
import 'Controller/LoginController.dart';
import 'Controller/ReservationController.dart';

class MyBinding extends Bindings{


  @override
  void dependencies() {
    Get.lazyPut(() => AuthController(), fenix: true);
    Get.lazyPut(()=>LoginController() , fenix: true);
    Get.lazyPut(()=>SignUpController() ,fenix:  true);
    Get.lazyPut(() => ChatsController(), fenix: true);
    Get.lazyPut(()=>BookingController() , fenix: true);
    Get.lazyPut(() => ProfileController(), fenix: true);
    Get.lazyPut(() => FavoriteController(), fenix: true);
    Get.lazyPut(()=>ReservationController() , fenix: true);
    Get.lazyPut(() => NotificationController(), fenix: true);
    Get.lazyPut(() => ConversationController(), fenix: true);
    Get.lazyPut(()=>MyReservationsController() , fenix: true);
    Get.lazyPut(() => ApartmentDetailsController(), fenix: true);
  }
}