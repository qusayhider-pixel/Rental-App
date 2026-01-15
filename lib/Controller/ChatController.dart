import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:uni_project/Model/Chat_Model.dart';
import 'package:uni_project/Services/api_service.dart';

class ChatsController extends GetxController {
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

  void getOrCreateConv(int aptId) async {
    try {
      isLoading(true);
      await service.createOrGetConversation(aptId);
      print(" Now Go the Conversation ");
    } catch (e) {
      Get.snackbar('Error', 'Failed to get or create this chat ');
    } finally {
      isLoading(false);
    }
  }
}
