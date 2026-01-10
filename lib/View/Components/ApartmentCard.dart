import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controller/FilterController.dart';
import '../../Model/apartment_model.dart';
import '../Screens/ApartmentDetailsScreen.dart';

class ApartmentCard extends StatelessWidget {
  final Apartment apartment;

  const ApartmentCard({super.key, required this.apartment});

  @override
  Widget build(BuildContext context) {
    final FilterController filterController = Get.find();
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      decoration: BoxDecoration(
        //dark mode
        gradient: Get.isDarkMode
            ? LinearGradient(
                colors: [
                  Color(0xff7f3aa1).withOpacity(0.5),
                  Color(0xff5416b5).withOpacity(0.5),
                  Color(0xff150b52).withOpacity(0.5),
                  Color(0xff0c0516).withOpacity(0.5),
                  Color(0xff190019).withOpacity(0.5),
                  // Color(0xff41394f), Color(0xff261f32)
                ],
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
              )
            : //light  mode
              LinearGradient(
                colors: [
                  Color(0xfff6c9c5).withOpacity(0.5),
                  Color(0xffdc85b4).withOpacity(0.5),
                  Color(0xffae4fdc).withOpacity(0.5),
                  Color(0xff6918e8).withOpacity(0.5),
                  // Color.fromARGB(245, 255, 255, 255),
                  // const Color(0xffc2b6f6),
                ],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
              ),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(50),
          topLeft: Radius.circular(120),
          bottomRight: Radius.circular(40),
          bottomLeft: Radius.circular(40),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xbe7255e5),
            spreadRadius: 0.2,
            blurRadius: 22,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Padding(
                padding: EdgeInsets.all(0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(40),
                    topLeft: Radius.circular(120),
                    bottomRight: Radius.circular(0),
                    bottomLeft: Radius.circular(0),
                  ),
                  child: SizedBox(
                    height: 200,
                    child: Obx(
                      () => filterController.isLoading.value
                          ? CircularProgressIndicator(
                              strokeWidth: 3,
                              color: Colors.deepPurpleAccent,
                            )
                          : apartment.imageUrls.isEmpty
                          ? Image.asset('assets/house icon.png')
                          : Image.network(
                              apartment.imageUrls[0],
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
              ),

              Positioned(
                top: -14,
                right: 14,
                child: Container(
                  width: 35,
                  padding: const EdgeInsets.symmetric(vertical: 22),
                  decoration: BoxDecoration(
                    gradient: Get.isDarkMode
                        ? LinearGradient(
                            colors: [
                              Color(0xff7f3aa1),
                              Color(0xff5416b5),
                              Color(0xff150b52),
                              // Color(0xff41394f), Color(0xff261f32)
                            ],
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                          )
                        : //light  mode
                          LinearGradient(
                            colors: [
                              Color(0xfff6c9c5),
                              Color(0xffdc85b4),
                              Color(0xffae4fdc),
                              Color(0xff6918e8),
                              // Color.fromARGB(245, 255, 255, 255),
                              // const Color(0xffc2b6f6),
                            ],
                            begin: Alignment.bottomRight,
                            end: Alignment.topLeft,
                          ),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.open_in_new),
                    color: Colors.white,
                    iconSize: 20,
                    onPressed: () {
                      Get.to(
                        () => ApartmentDetailsScreen(apartment: apartment),
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                left: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Get.isDarkMode
                        ? Color(0xff0c0516).withOpacity(0.7)
                        : Color(0xffaa70db),
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: Text(
                    "\$${apartment.price.toInt()}/day",
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),

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
                    Icon(
                      Icons.location_on,
                      size: 16,
                      color: Colors.grey.shade300,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "${apartment.province}, ${apartment.city}",
                      style: TextStyle(
                        color: Colors.grey.shade200,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  apartment.title,
                  style: TextStyle(
                    color: Colors.white,
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
                    color: Get.isDarkMode ? Colors.grey : Colors.white,
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
                        "${apartment.beds} Rooms",
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
        Icon(icon, size: 18, color: Colors.white),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
