

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_project/Controller/ApartmentDetailsController.dart';
import 'package:uni_project/Controller/FilterController.dart';

import 'AddApartment.dart';

class Favouritescreen extends StatelessWidget {
  const Favouritescreen({super.key});

  @override
  Widget build(BuildContext context) {
    ApartmentDetailsController controller = Get.find();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("List Your Property", style: TextStyle(color: Get.isDarkMode ? Colors.white : Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Get.isDarkMode ? Colors.white : Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: FavBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: controller.favApartments.length,
              itemBuilder: (context, index) {
                return null;
              

              },
          ),
        ),
      ),
    );
  }
}


class FavBackground extends StatelessWidget {
  final Widget child;
  const FavBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/Apartments/purple5.jpg',
            fit: BoxFit.cover,
          ),
        ),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors:
                Get.isDarkMode ?
                [
                  Color(0xff41394f).withOpacity(0.6),
                  Color(0xff261f32).withOpacity(0.6)
                ]
                    :
                [
                  Color(0xffffffff).withOpacity(0.7),
                  Color.fromARGB(255, 124, 75, 253).withOpacity(0.5),
                ]
                ,
              ),
            ),
          ),
        ),
        SafeArea(child: child),
      ],
    );
  }
}
