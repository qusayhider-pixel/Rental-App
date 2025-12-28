import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../Services/api_service.dart';
import '../View/Screens/LoginScreen.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class SignUpController extends GetxController {
  final ApiService apiService = ApiService();
  var isLoading = false.obs;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final dobController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  Rx<File?> avatarImage = Rx<File?>(null);

  final ImagePicker _picker = ImagePicker();

  Future<void> pickAvatarImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      avatarImage.value = File(pickedFile.path);
    }
  }

  Future<void> signUp() async {
    try {
      isLoading.value = true;
      final response = await apiService.signUp(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        dateOfBirth: dobController.text,
        phone: phoneController.text,
        password: passwordController.text,
        avatar: avatarImage.value,
      );

      print("📥 Response: ${response.data}");
      Get.snackbar("LUXESTAY", "Account created successfully");
      Get.offAll(() => LoginScreen());
    } catch (e) {
      String errorMessage = "Sign up failed";

      if (e is DioException) {
        // هنا السيرفر يخبرك بالضبط ما هي المشكلة (مثلاً: الهاتف مستخدم مسبقاً)
        if (e.response?.data != null && e.response?.data['message'] != null) {
          errorMessage = e.response?.data['message'];
        } else {
          errorMessage = "Server Error: ${e.response?.statusCode}";
        }
        print("❌ Server Response: ${e.response?.data}");
      }

      Get.snackbar("Error", errorMessage, snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }
}

// import 'dart:io';
// import 'package:flutter/cupertino.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_navigation/src/extension_navigation.dart';
// import 'package:get/get_rx/src/rx_types/rx_types.dart';
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';
// import '../Services/api_service.dart';
// import '../View/Screens/LoginScreen.dart';
// import 'package:dio/dio.dart';

// class SignUpController extends GetxController {
//   final ApiService apiService = ApiService();
//   var isLoading = false.obs;

//   final firstNameController = TextEditingController();
//   final lastNameController = TextEditingController();
//   final dobController = TextEditingController();
//   final phoneController = TextEditingController();
//   final passwordController = TextEditingController();

//   File? avatarImage;

//   Future<void> signUp() async {
//     try {
//       isLoading.value = true;

//       final response = await apiService.signUp(
//         firstName: firstNameController.text,
//         lastName: lastNameController.text,
//         dateOfBirth: dobController.text,
//         phone: phoneController.text,
//         password: passwordController.text,
//         avatar: avatarImage,
//       );
//       print("📥 Response: ${response.data}");
//       Get.snackbar("LUXESTAY", "Account created successfully");

//       Get.offAll(() => LoginScreen());
//     } catch (e) {
//       if (e is DioException) {
//         print("❌ STATUS: ${e.response?.statusCode}");
//         print("❌ DATA: ${e.response?.data}");
//       } else {
//         print("❌ ERROR: $e");
//       }

//       Get.snackbar("Error", "Sign up failed");
//     }
//     // catch (e) {
//     //   print(e.toString());
//     //   Get.snackbar("LUXESTAY", "Sign up failed");
//     // }
//     finally {
//       isLoading.value = false;
//     }
//   }
// }
