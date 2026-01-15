
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:uni_project/Controller/FavoraiteController.dart';
import 'package:uni_project/Controller/NotificationController.dart';
import 'package:uni_project/Model/FavoriteModel.dart';
import 'package:uni_project/Model/Notificaion_model.dart';
import 'package:uni_project/View/Components/ChatCard.dart';
import 'package:uni_project/View/Components/FavoriteApartmentCard.dart';
import '../Components/NotificationCard.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    FavoriteController controller = Get.find();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          "My Chats",
          style: TextStyle(color: Colors.white, letterSpacing: 2),
        ),
        backgroundColor: Colors.transparent,
        titleTextStyle: TextStyle(fontFamily: 'Multicolore', fontSize: 20),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.white),
        ),
      ),
      body: Stack(
        children: [

          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  end: Alignment.topLeft,
                  begin: Alignment.bottomRight,
                  colors: Get.isDarkMode
                      ? [
                    Color(0xff7f3aa1).withOpacity(0.6),
                    Color(0xff5516b5).withOpacity(0.6),
                    Color(0xff150b56).withOpacity(0.7),
                    Color(0xff0c0516).withOpacity(0.7),
                  ]
                      : [
                    // Color(0xffdfb6b2),
                    Color(0xff6a1fe0),
                    Color(0xffa44cd0),
                    Color(0xffc475a0),
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: SafeArea(
              child: Obx(
                    () => controller.isLoading.value
                    ? const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    color: Colors.white60,
                  ),
                )
                    : controller.myFav.isEmpty
                    ? Center(child: Text("There is No Notifications !"))
                    : MasonryGridView.count(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 10,
                  ),
                  crossAxisCount: 1,
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 9,
                  itemCount: controller.myFav.length,
                  itemBuilder: (context, index) {
                    final MyFavoriteModel notify =
                    controller.myFav[index];
                    return ChatCard(apt: notify);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
