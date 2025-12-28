import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:uni_project/View/Screens/WelcomeScreen.dart';
import 'package:uni_project/main.dart';
import '../Model/LoginResponse.dart';
import '../Services/api_service.dart';
import '../View/Screens/HomePage.dart';

class LoginController extends GetxController {
  final ApiService apiService = ApiService();


  var isLoading = false.obs;
  var currentUser = Rxn<LoginResponse>();

  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> login() async {
    try {
      isLoading.value = true;

      final response = await apiService.login(
        phoneController.text,
        passwordController.text,
      );

      print("Raw Data from Server: ${response.data}");
      final loginData = LoginResponse.fromJson(response.data as Map<String, dynamic>);
      currentUser.value = loginData;

      Get.offAll(() => RentalApp());
      Get.snackbar("LUXESTAY", "Login Success" ,  backgroundColor: const Color.fromARGB(
          132, 9, 245, 1),
        borderRadius: 30,
        maxWidth: 250,
        margin: const EdgeInsets.all(10),
        icon:  Icon(Icons.done_outline_sharp, size: 30,),
      );
    }

    catch (e) {
      if (e is DioException) {
        if (e.response?.data != null && e.response?.data['message'] != null) {
        } else {
        }
        Get.snackbar("Message", '${e.response?.data}');print("❌ Server Response: ${e.response?.data}");
      }
    } finally {
      isLoading.value = false;
    }
  }


  void logout() {
    currentUser.value = null;
    sharedPreference?.clear();
    GetStorage().erase();
    Get.offAll(() => WelcomeScreen());
  }
}



// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:uni_project/Bindings/LogInBinding.dart';
// import 'package:uni_project/View/Screens/HomePage.dart';
// import '../Model/LoginResponse.dart';
// import '../Services/api_service.dart';
//
//
// class LoginController extends GetxController {
//   final ApiService apiService = ApiService();
//   var currentUser = Rxn<LoginResponse>();
//   var isLoading = false.obs;
//
//   TextEditingController phoneController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//
//   Future<void> login() async {
//     try {
//       print("📤 Sending request...");
//       isLoading.value = true;
//
//       final response = await apiService.login(
//         phoneController.text,
//         passwordController.text,
//       );
//
//       print("📥 Response: ${response.data}");
//
//       String buildAvatarUrl(String? avatarPath) {
//         if (avatarPath == null || avatarPath.isEmpty) {
//           return '';
//         }
//         if (avatarPath.startsWith('http')) {
//           return avatarPath;
//         }
//         return 'http://10.0.2.2:8000/storage/$avatarPath';
//       }
//
//       final loginData = LoginResponse.fromJson(response.data);
//
//       final avatarUrl = buildAvatarUrl(loginData.avatar);
//
//       currentUser.value = LoginResponse(
//         token: loginData.token,
//         firstname: loginData.firstname,
//         lastname: loginData.lastname,
//         phone: loginData.phone,
//         avatar: avatarUrl.isEmpty ? null : avatarUrl,
//       );
//
//       print("AVATAR FINAL URL => ${currentUser.value!.avatar}");
//       Get.offAll(() => RealEstateApp() , binding: Loginbinding());
//
//       Get.snackbar("LUXESTAY", "Login Success");
//
//       return;
//     } catch (e) {
//       print(e.toString());
//       Get.snackbar("LUXESTAY", "Login Failed");
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }
