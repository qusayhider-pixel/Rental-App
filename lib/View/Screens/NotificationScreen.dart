import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:uni_project/Controller/FavoraiteController.dart';
import 'package:uni_project/Controller/NotificationController.dart';
import 'package:uni_project/Model/FavoriteModel.dart';
import 'package:uni_project/Model/Notificaion_model.dart';
import '../Components/NotificationCard.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    NotificationController controller = Get.find();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          "Notifications",
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
          // Positioned.fill(
          //   child: Image.asset('assets/black abstract.jpg', fit: BoxFit.cover),
          // ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  end: Alignment.topCenter,
                  begin: Alignment.bottomCenter,
                  colors: Get.isDarkMode
                      ? [
                          Color(0xff7f3aa1).withOpacity(0.6),
                          Color(0xff5516b5).withOpacity(0.6),
                          Color(0xff150b56).withOpacity(0.7),
                          Color(0xff0c0516).withOpacity(0.7),
                        ]
                      : [
                          Color(0xffdfb6b2).withOpacity(0.9),
                          Color(0xffc475a0).withOpacity(0.9),
                          Color(0xffa44cd0).withOpacity(0.9),
                          Color(0xff6a1fe0).withOpacity(0.9),
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
                    : controller.notifications.isEmpty
                    ? Center(child: Text("There is No Notifications !"))
                    : MasonryGridView.count(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 10,
                        ),
                        crossAxisCount: 1,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 15,
                        itemCount: controller.notifications.length,
                        itemBuilder: (context, index) {
                          final NotificationModel notify =
                              controller.notifications[index];
                          return NotificatoinCard(notification: notify);
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
