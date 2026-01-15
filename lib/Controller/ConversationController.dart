import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_project/Model/Chat_Model.dart';
import 'package:uni_project/Model/FavoriteModel.dart';
import 'package:uni_project/Services/api_service.dart';
import '../Model/apartment_model.dart';

class ConversationController extends GetxController {
  ApiService service = ApiService();
  var myChats = <Chat>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchMyChats();
  }

  void fetchMyChats() async {
    try {
      isLoading(true);
      myChats.value = await service.fetchingMyChats();
      // print("Is My chats empty ? : ${myChats.isEmpty}");
    } catch (e) {
      Get.snackbar('Error', 'Failed to load my chats');
    } finally {
      isLoading(false);
    }
  }
}
