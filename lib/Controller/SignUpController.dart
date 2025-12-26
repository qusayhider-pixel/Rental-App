
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../Services/api_service.dart';
import '../View/Screens/LoginScreen.dart';
import 'package:dio/dio.dart';


class SignUpController extends GetxController {
  final ApiService apiService = ApiService();
  var isLoading = false.obs;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final dobController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  File? avatarImage;

  Future<void> signUp() async {
    try {
      isLoading.value = true;

      final response = await apiService.signUp(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        dateOfBirth: dobController.text,
        phone: phoneController.text,
        password: passwordController.text,
        avatar: avatarImage,
      );
      print("📥 Response: ${response.data}");
      Get.snackbar("LUXESTAY", "Account created successfully");

      Get.offAll(() => LoginScreen());
    } catch (e) {
      if (e is DioException) {
        print("❌ STATUS: ${e.response?.statusCode}");
        print("❌ DATA: ${e.response?.data}");
      } else {
        print("❌ ERROR: $e");
      }

      Get.snackbar("Error", "Sign up failed");
    }

    // catch (e) {
    //   print(e.toString());
    //   Get.snackbar("LUXESTAY", "Sign up failed");
    // }
    finally {
      isLoading.value = false;
    }
  }
}





// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../Bindings/SignUpBinding.dart';
// import '../Model/SignUpResponse.dart';
// import '../Services/api_service.dart';
// import '../View/Screens/HomePage.dart';
//
//
// class Signupcontroller extends GetxController {
//   final ApiService apiService = ApiService();
//   var currentUser = Rxn<SignUpResponse>();
//   var isLoading = false.obs;
//
//   TextEditingController firstNameController = TextEditingController();
//   TextEditingController lastNameController = TextEditingController();
//   TextEditingController phoneController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//
//
//   Future<void> Signup() async {
//     try {
//       print("📤 Sending request...");
//       isLoading.value = true;
//
//       final response = await apiService.Signup(
//         firstNameController.text,
//         lastNameController.text,
//         phoneController.text,
//         passwordController.text,
//       );
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
//       final SignUpData = SignUpResponse.fromJson(response.data);
//
//       final avatarUrl = buildAvatarUrl(SignUpData.avatar);
//
//       currentUser.value = SignUpResponse(
//         token: SignUpData.token,
//         firstname: SignUpData.firstname,
//         lastname: SignUpData.lastname,
//         phone: SignUpData.phone,
//         avatar: avatarUrl.isEmpty ? null : avatarUrl,
//         birth: SignUpData.birth,
//       );
//       // print("📥 Response: ${response.data}");
//
//       Get.offAll(()=>RealEstateApp() , binding: Signupbinding());
//       // print("✅ TOKEN: ${SignupData.token}");
//       Get.snackbar("LUXESTAY", "Sign Up Success");
//     } catch (e) {
//       Get.snackbar("LUXESTAY", "Sign Up Failed");
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }



// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../Services/api_service.dart';
// import '../Model/SignUpResponse.dart';
// import '../View/Screens/LoginScreen.dart';
//
// class SignUpController extends GetxController {
//   final ApiService apiService = ApiService();
//   var isLoading = false.obs;
//
//   final firstNameController = TextEditingController();
//   final lastNameController = TextEditingController();
//   final dobController = TextEditingController();
//   final phoneController = TextEditingController();
//   final passwordController = TextEditingController();
//
//   File? avatarImage;
//
//   Future<void> signUp() async {
//     try {
//       isLoading.value = true;
//
//       final response = await apiService.signUp(
//         firstName: firstNameController.text,
//         lastName: lastNameController.text,
//         dateOfBirth: dobController.text,
//         phone: phoneController.text,
//         password: passwordController.text,
//         avatar: avatarImage,
//       );
//
//       final data = SignUpResponse.fromJson(response.data);
//
//       Get.snackbar("LUXESTAY", "Account created successfully");
//       Get.offAll(() => LoginScreen());
//     } catch (e) {
//       Get.snackbar("LUXESTAY", "Sign up failed");
//       print(e);
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }


