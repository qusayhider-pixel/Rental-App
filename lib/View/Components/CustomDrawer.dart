import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_project/View/Screens/MyReservation.dart';
import 'package:uni_project/View/Screens/ReservationManageScreen.dart';
import '../../Controller/LoginController.dart';

class CustomDrawer extends StatelessWidget {

  final controller = Get.find<LoginController>();
  CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
  final user = controller.currentUser.value;
    return Drawer(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 60, left: 20, bottom: 20),
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: Get.isDarkMode
                  ? LinearGradient(
                      colors: [Color(0xff41394f), Color(0xff261f32)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : //light  mode
                    LinearGradient(
                      colors: [
                        Color(0xff846be7),
                        const Color.fromARGB(171, 155, 101, 213),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
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
                  child: CircleAvatar(
                    radius: 60,
                    // backgroundImage: user?.avatar != null
                    //     ? NetworkImage(user!.avatar!)
                    //     : AssetImage('assets/Green.jpg')
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  "${user?.firstname } ${user?.lastname} ",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Phone: ${user?.phone }",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),
          _buildDrawerItem(Icons.person_outline, "My Profile"),
          _buildDrawerItem(Icons.add_home_outlined, "Add Apartment"),
          _buildDrawerItem(Icons.favorite_border, "My Favorites"),
          _buildDrawerItem(Icons.bookmark_border, "My Reservations"),
          _buildDrawerItem(
            Icons.manage_accounts_outlined,
            "Reservation Management",
          ),
          const Divider(thickness: 1, indent: 20, endIndent: 20),
          _buildDrawerItem(Icons.logout, "Logout", isDestructive: true),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    IconData icon,
    String title, {
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
      onTap: () {
        if(title == 'My Reservations')
          {
            Get.to(()=> MyReservationsScreen());
          }

        if(title == 'Reservation Management')
          {
            Get.to(()=> ReservationManagementScreen());
          }

        if (title == 'Logout') {
          controller.logout();

          Get.snackbar(
            "LUXESTAY",
            "Logout Successfully",
            backgroundColor: Color.fromARGB(197, 165, 148, 250),
            borderRadius: 25,
          );
          // sharedPreference!.clear();
          Get.changeTheme(ThemeData.light());
          // Get.offAll(WelcomeScreen());
        }
      },
    );
  }
}
