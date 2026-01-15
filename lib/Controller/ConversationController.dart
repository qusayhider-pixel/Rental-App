import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uni_project/Model/Chat_Model.dart';
import 'package:uni_project/Services/api_service.dart';
import 'package:uni_project/View/Screens/ConversationScreen.dart';

class ConversationController extends GetxController {
  ApiService service = ApiService();
  var isLoading = false.obs;
  var messages = <Messages>[].obs;
  int chatId = -1;

  final TextEditingController textController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  var myConversation = Rx<Conversation?>(null);

  void fetchConversationInfo(int id) async {
    try {
      isLoading(true);
      chatId = id;
      myConversation.value = await service.conversationInformation(id);
      messages.value = await service.fetchingMessages(id);
      print(myConversation.value!.receiverName);
      Get.to(() => ConversationScreen());
      print("done");
    } catch (e) {
      Get.snackbar('Error', 'Failed to load my Conversation info ');
    } finally {
      isLoading(false);
    }
  }

  void sendMessage(String msg) async {
    try {
      if (msg.isNotEmpty) {
        isLoading(true);
        String time =
            "${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}";
        textController.clear();
        scrollController.animateTo(
          scrollController.position.maxScrollExtent + 100,
          duration: Duration(milliseconds: 400),
          curve: Curves.bounceOut,
        );
        messages.add(Messages(content: msg, time: time, isMe: true));
        await service.sendMessage("$chatId", msg);
        // fetchConversationInfo(chatId);
        print("sending done ");
      }
    } catch (e) {
      print("Failed to send my message");
    } finally {
      isLoading(false);
    }
  }
}
