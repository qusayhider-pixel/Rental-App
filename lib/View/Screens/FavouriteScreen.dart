

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_project/Controller/ApartmentDetailsController.dart';
import 'package:uni_project/Controller/FavoraiteController.dart';
import 'package:uni_project/Controller/FilterController.dart';
import 'package:uni_project/View/Screens/HomeScreen.dart';

import 'AddApartment.dart';

class Favouritescreen extends StatelessWidget {
  const Favouritescreen({super.key});

  @override
  Widget build(BuildContext context) {
    // FavoriteController controller = Get.find();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("My Favorites", style: TextStyle(
            color: Get.isDarkMode ? Colors.white : Colors.black,
            fontWeight: FontWeight.w500)),
        backgroundColor: Colors.transparent,
        titleTextStyle: TextStyle(
            fontFamily: 'Multicolore',
            color: Get.isDarkMode ? Colors.white : Colors.black, fontSize: 20),
        centerTitle: true,

      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/Apartments/purple2.jpg',
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
        ],
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
