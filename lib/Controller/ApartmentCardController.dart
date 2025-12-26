

import 'package:get/get.dart';

class Apartmentcardcontroller  extends GetxController{
  final isLoading = false.obs ;

  Future<void> login() async {
    try {
      isLoading.value = true;
    } catch (e) {
      e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}