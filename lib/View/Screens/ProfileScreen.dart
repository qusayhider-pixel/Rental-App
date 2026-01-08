import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_project/Controller/SignUpController.dart';
import '../../Controller/AuthController.dart';

class Profilescreen extends StatelessWidget {
  const Profilescreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Get.find<AuthController>();

    final user = auth.user.value;
    if (user == null) {}
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          "My Profile",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'Multicolore',
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: Get.isDarkMode
                    ? [
                        Color(0xff7f3aa1).withOpacity(0.9),
                        Color(0xff5716b5).withOpacity(0.9),
                        Color(0xff150b52).withOpacity(0.9),
                        Color(0xff190019).withOpacity(0.9),
                      ]
                    : [
                        Color(0xffdfb6b2).withOpacity(0.9),
                        Color(0xff9d5e80).withOpacity(0.9),
                        Color(0xff7f3aa1).withOpacity(0.9),
                        Color(0xff5416b5).withOpacity(0.9),
                      ],
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 200,
                horizontal: 30,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0x3dffffff),
                  border: BoxBorder.all(color: Colors.white, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x7b8374c4),
                      spreadRadius: 2,
                      blurRadius: 30,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(44),
                ),
                width: 400,
                child: Column(
                  spacing: 15,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 28),
                      child: Align(
                        alignment: AlignmentGeometry.topLeft,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 18,
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 130,
                              backgroundImage: user?.avatar != null
                                  ? NetworkImage(
                                "http://10.0.2.2:8000/storage/${user!.avatar}",
                              )
                                  : null,
                              child: user?.avatar == null
                                  ? const Icon(Icons.person)
                                  : null,
                            ),

                            Positioned(
                                bottom: 20,
                                right: 20,
                                child: GestureDetector(
                                  onTap: () {
                                    print('to do ');
                                  },
                                  child: Icon(
                                      Icons.camera_alt_outlined, size: 33,
                                      color: Colors.white),
                                )),
                          ]),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 8, children: [
                        Icon(
                          Icons.person,
                          size: 30,
                          color: Colors.white,
                        ),
                        Text(
                          "${user?.firstname} ${user?.lastname} ",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 42,
                            fontFamily: 'Louis',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 8,
                      children: [
                        Icon(Icons.phone, size: 30, color: Colors.white),
                        Text(
                          "+${user?.phone}",
                          style: TextStyle(
                            color: Colors.white70,
                            fontFamily: 'Louis',
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
