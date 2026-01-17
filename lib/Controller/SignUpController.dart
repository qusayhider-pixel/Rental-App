import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Services/api_service.dart';
import '../View/Screens/LoginScreen.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class SignUpController extends GetxController {
  final ApiService apiService = ApiService();
  var isLoading = false.obs;
  RxBool isVisible = false.obs;


  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final dobController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  Rx<File?> avatarImage = Rx<File?>(null);
  Rx<File?> creditImage = Rx<File?>(null);

  Future<void> pickAvatarImage() async {
    final XFile? pickedFile = await  ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      avatarImage.value = File(pickedFile.path);
    }
  }

  Future<void> creditIdImage() async {
    final XFile? pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery);
    if (pickedFile != null) {
      creditImage.value = File(pickedFile.path);
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
          idPhoto: creditImage.value
      );

      print("📥 Response: ${response.data}");
      Get.snackbar(
        "LUXESTAY",
        "Account created successfully",
        backgroundColor: Color.fromARGB(166, 9, 245, 1),
        borderRadius: 30,
        maxWidth: 250,
        margin: const EdgeInsets.all(4),
        icon: Icon(Icons.check_circle, size: 30),
      );
      Get.offAll(() => LoginScreen());
    } catch (e) {
      String errorMessage = "Sign up failed";

      if (e is DioException) {
        if (e.response?.data != null && e.response?.data['message'] != null) {
          errorMessage = e.response?.data['message'];
        } else {
          errorMessage = "Server Error: ${e.response?.statusCode}";
        }
        print("❌ Server Response: ${e.response?.data}");
      }

      Get.snackbar(
        "Error",
        errorMessage,
        backgroundColor: Color.fromARGB(166, 245, 1, 9),
        borderRadius: 30,
        maxWidth: 250,
        margin: const EdgeInsets.all(4),
        icon: Icon(Icons.error, size: 30),
      );
    } finally {
      isLoading.value = false;
    }
  }
}
