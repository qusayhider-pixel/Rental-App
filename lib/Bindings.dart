
import 'package:get/get.dart';
import 'package:uni_project/Controller/ApartmentDetailsController.dart';
import 'package:uni_project/Controller/SignUpController.dart';

import 'Controller/LoginController.dart';

class MyBinding extends Bindings{


  @override
  void dependencies() {
    Get.lazyPut(()=>LoginController() , fenix: true);
    Get.lazyPut(()=>SignUpController() ,fenix:  true);
    Get.lazyPut(()=>ApartmentDetailsController() , fenix: true);
  }
}