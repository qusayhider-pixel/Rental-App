import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:uni_project/Controller/AuthController.dart';
import 'package:uni_project/View/Screens/ConversationScreen.dart';
import 'package:uni_project/View/Screens/FavouriteScreen.dart';
import 'package:uni_project/View/Screens/MyReservation.dart';
import 'package:uni_project/View/Screens/NotificationScreen.dart';
import 'package:uni_project/View/Screens/ProfileScreen.dart';
import 'package:uni_project/View/Screens/ReservationManageScreen.dart';
import '../../Controller/LoginController.dart';
import '../Screens/AddApartment.dart';
import '../Screens/ChatScreen.dart';

class CustomDrawer extends StatelessWidget {
  final auth = Get.find<AuthController>();

  CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final user = auth.user.value;
    if (user == null) {
      print("No user logged in");
    }

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
      child: Drawer(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 60, left: 20, bottom: 20),
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: Get.isDarkMode
                    ? LinearGradient(
                        colors: [
                          Color(0xff7f3aa1),
                          Color(0xff5416b5),
                          Color(0xff150b52),
                          Color(0xff0c0516),
                          Color(0xff190019),
                          // Color(0xff41394f),
                          // Color(0xff261f32)
                        ],
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                      )
                    : //light  mode
                      LinearGradient(
                        colors: [
                          Color(0xffdfb6b2),
                          Color(0xffc475a0),
                          Color(0xffa44cd0),
                          Color(0xff6a1fe0),

                          // Color(0xff846be7),
                          // const Color.fromARGB(171, 155, 101, 213),
                        ],
                        begin: Alignment.bottomRight,
                        end: Alignment.topLeft,
                      ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                      // color: Colors.white,
                      shape: BoxShape.rectangle,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(500),
                      ),
                      child: CircleAvatar(
                        radius: 70,
                        backgroundImage: user?.avatar != null
                            ? NetworkImage(
                                "http://10.0.2.2:8000/storage/${user!.avatar}",
                              )
                            : null,
                        child: user?.avatar == null
                            ? const Icon(Icons.person)
                            : null,
                      ),
                    ),
                  ),

                  Text(
                    "${user?.firstname} ${user?.lastname} ",
                    style: const TextStyle(
                      fontFamily: "Louis",
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                  Text(
                    "+${user?.phone}",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 17,
                      fontFamily: "Louis",
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),
            _buildDrawerItem(Icons.person_outline, "My Profile", () {
              Get.to(() => Profilescreen());
            }),
            _buildDrawerItem(Icons.send_rounded, "Chats", () {
              Get.to(() => ChatsScreen());
            }),
            _buildDrawerItem(
                Icons.notifications_active_outlined, "Notifications", () {
              Get.to(() => NotificationScreen());
            }),
            const Divider(thickness: 1, indent: 30, endIndent: 30),
            _buildDrawerItem(Icons.add_home_outlined, "Add Apartment", () {
              Get.to(() => AddApartmentScreen());
            }),
            _buildDrawerItem(Icons.favorite_border, "My Favorites", () {
              Get.to(() => FavouriteScreen());
            }),
            _buildDrawerItem(
                Icons.bookmark_outline_rounded, "My Reservations", () {
              Get.to(() => MyReservationsScreen());
            }),
            _buildDrawerItem(
                Icons.manage_accounts_outlined, "Reservation Management", () {
              Get.to(() => ReservationManagementScreen());
            }),
            const Divider(thickness: 1, indent: 30, endIndent: 30),
            _buildDrawerItem(Icons.logout, "Logout", () {
              auth.logout();
              Get.snackbar(
                "LUXESTAY",
                "Logout Successfully",
                backgroundColor: Color.fromARGB(197, 165, 148, 250),
                borderRadius: 25,
              );
              Get.changeTheme(ThemeData.light());
            }, isDestructive: true),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(
    IconData icon,
      String title, VoidCallback onTap, {
    bool isDestructive = false,

      }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isDestructive
            ? Colors.red
            : Get.isDarkMode
            ? Colors.white
            : Colors.grey[700],
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isDestructive
              ? Colors.red
              : Get.isDarkMode
              ? Colors.white
              : Colors.grey[700],
          fontWeight: FontWeight.w500,
        ),
      ),
        onTap: onTap
    );
  }
}
