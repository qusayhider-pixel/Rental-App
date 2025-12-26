import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import '../Screens/ApartmentDetailsScreen.dart';
import '../Screens/HomePage.dart';

class ApartmentCard extends StatelessWidget {
  final Apartment apartment;

  const ApartmentCard({super.key, required this.apartment});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      decoration: BoxDecoration(
        //dark mode
        gradient: Get.isDarkMode
            ? LinearGradient(
                colors: [Color(0xff41394f), Color(0xff261f32)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : //light  mode
              LinearGradient(
                colors: [
                  Color.fromARGB(245, 255, 255, 255),
                  const Color.fromARGB(218, 209, 192, 231),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(156, 133, 2, 255),
            spreadRadius: 0.5,
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
                child: SizedBox(
                  height: 200,
                  child: Obx(()=>Image.network(
                    apartment.imageUrls.isNotEmpty
                        ? apartment.imageUrls[0]
                        : '' ,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ), )
                ),
              ),
              Positioned(
                top: 15,
                right: 15,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  decoration: BoxDecoration(
                    color: Get.isDarkMode
                        ? const Color.fromARGB(226, 54, 53, 53)
                        : Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.favorite_outline_sharp),
                    color: Get.isDarkMode
                        ? Color.fromARGB(255, 165, 148, 250)
                        : Colors.red,
                    iconSize: 20,
                    onPressed: () {},
                  ),
                ),
              ),
              Positioned(
                top: 60,
                right: 15,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Get.isDarkMode
                        ? const Color.fromARGB(226, 54, 53, 53)
                        : Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.open_in_new),
                    color: Get.isDarkMode
                        ? Color.fromARGB(255, 165, 148, 250)
                        : Colors.red,
                    iconSize: 20,
                    onPressed: () {
                      Get.to(ApartmentDetailsScreen(apartment: apartment));
                    },
                  ),
                ),
              ),
              Positioned(
                bottom: 15,
                left: 15,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Get.isDarkMode
                        ? const Color.fromARGB(226, 54, 53, 53)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "\$${apartment.price.toInt()}/mo",
                    style: TextStyle(
                      color: Get.isDarkMode
                          ? const Color.fromARGB(255, 165, 148, 250)
                          : const Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      apartment.location,
                      style: const TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  apartment.title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    // color: Get.isDarkMode ? Colors.white70 : Colors.black,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Text(
                  apartment.description,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                    height: 1.4,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 15),
                const Divider(height: 1),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildFeature(
                        Icons.bed_outlined,
                        "${apartment.beds} Beds",
                      ),
                      _buildFeature(
                        Icons.bathtub_outlined,
                        "${apartment.baths} Bath",
                      ),
                      _buildFeature(
                        Icons.square_foot_outlined,
                        "${apartment.area} m²",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeature(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 18),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            // color: Colors.grey[700],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
