import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:uni_project/View/Screens/HomeScreen.dart';
import '../Model/LoginResponse.dart';
import '../Services/api_service.dart';
import 'AuthController.dart';

class LoginController extends GetxController {
  final ApiService apiService = ApiService();


  var isLoading = false.obs;
  final AuthController authController = Get.find();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> login() async {
    try {
      isLoading.value = true;

      final response = await apiService.login(
        phoneController.text,
        passwordController.text,
      );

      // ignore: avoid_print
      print("Raw Data from Server: ${response.data}");

      final loginData = LoginResponse.fromJson(response.data);
      ///saving the token
      authController.setUser(loginData) ;

      Get.offAll(() => HomeScreen());

      Get.snackbar("LUXESTAY", "Login Success",
        backgroundColor: const Color.fromARGB(132, 9, 245, 1),
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
        // ignore: avoid_print
        Get.snackbar(
          "Error",
          '${e.response?.data}',
          backgroundColor: Color.fromARGB(166, 245, 1, 9),
          borderRadius: 30,
          maxWidth: 250,
          margin: const EdgeInsets.all(4),
          icon: Icon(Icons.error, size: 30),
        );
      }
    } finally {
      isLoading.value = false;
    }
  }


  void logout() {
    authController.logout();
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
