import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_project/Controller/FilterController.dart';
import '../../Model/FavoriteModel.dart';
import '../Screens/ApartmentDetailsScreen.dart';

class FavoriteApartmentCard extends StatelessWidget {
  final MyFavoriteModel apt;

  const FavoriteApartmentCard({super.key, required this.apt});

  @override
  Widget build(BuildContext context) {
    final FilterController controller = Get.find();
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff6918e8).withOpacity(0.2),
              Color(0xffae4fdc).withOpacity(0.2),
              Color(0xffdc85b4).withOpacity(0.4),
              Color(0xfff6c9c5).withOpacity(0.5),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Color(0x52dad2fa),
              spreadRadius: 0.1,
              blurRadius: 30,
              offset: const Offset(-10, -10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //apt image
            Stack(
              children: [
                SizedBox(
                  height: 160,
                  width: double.infinity,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(apt.imageUrls.first, fit: BoxFit.cover),
                    ],
                  ),
                ),

                //rating
                Positioned(
                  top: 16,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 14),
                        const SizedBox(width: 4),
                        Text(
                          apt.rating,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //owner
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    decoration: BoxDecoration(
                      border: BoxBorder.all(color: Color(0xff44ef16), width: 2),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                        "http://10.0.2.2:8000/storage/${apt.ownerAvatar}",
                      ),
                      onBackgroundImageError: (_, _) =>
                          const Icon(Icons.person),
                    ),
                  ),
                ),
              ],
            ),

            ///apt info
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          apt.description,
                          maxLines: 8,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          "${apt.city} - ${apt.governorate}",
                          style: TextStyle(
                            color: Colors.grey.shade300,
                            fontSize: 12,
                          ),
                        ),

                        const SizedBox(height: 6),

                        Text(
                          "${apt.price} \$",
                          style: const TextStyle(
                            color: Color(0xb544ef16),
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 8),
                      ],
                    ),
                  ),

                  Positioned(
                    right: -20,
                    child: IconButton(
                      onPressed: () {
                        Get.to(
                          () => ApartmentDetailsScreen(
                            apartment: controller.getApartmentById(apt.id),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
