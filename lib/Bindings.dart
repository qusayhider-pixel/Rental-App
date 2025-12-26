
import 'package:get/get.dart';

import 'Controller/LoginController.dart';

class MyBinding extends Bindings{


  @override
  void dependencies() {
    Get.lazyPut(()=>LoginController() , fenix: true);  }
}