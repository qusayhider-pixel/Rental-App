import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:uni_project/Controller/FavoraiteController.dart';
import 'package:uni_project/Model/FavoriteModel.dart';

import '../Components/FavoriteApartmentCard.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    FavoriteController controller = Get.find();

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text("My Favorites", style: TextStyle(
              color: Colors.white,
              letterSpacing: 3
          )),
          backgroundColor: Colors.transparent,
          titleTextStyle: TextStyle(fontFamily: 'Multicolore', fontSize: 20),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.white,),
          ),
        ),
        body: Stack(
            children: [
              Positioned.fill(child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors:
                    Get.isDarkMode ?
                    [
                      Color(0xff7f3aa1),
                      Color(0xff5416b5),
                      Color(0xff150b52),
                      Color(0xff0c0516),
                      Color(0xff190019),
                    ]
                        :
                    [
                      Color(0xffdfb6b2),
                      Color(0xff9d5e80),
                      Color(0xff7f3aa1),
                      Color(0xff5416b5),
                      // Color.fromARGB(255, 89, 25, 255).withOpacity(0.5),
                      // Color.fromARGB(255, 124, 75, 253).withOpacity(0.5),
                      // Color(0xffffffff).withOpacity(0.9),
                    ]
                    ,
                  ),
                ),
              ),),
              SafeArea(
                child: SafeArea(
                  child: Obx(() =>
                  controller.isLoading.value
                      ? const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 3, color: Colors.white60,),
                  )
                      : MasonryGridView.count(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 10),
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    itemCount: controller.myFav.length,
                    itemBuilder: (context, index) {
                      final MyFavoriteModel apt = controller.myFav[index];
                      return FavoriteApartmentCard(apt: apt);
                    },
                  ),
                  ),
                ),

              ),
            ]
        )
    );
  }
}




