import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:uni_project/View/Screens/LoginScreen.dart';
import 'package:uni_project/View/Screens/SignIUpScreen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/Welcome.jpg',
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
            ),

            SafeArea(
              child: Column(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Text
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 50,
                      horizontal: 30,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "LUXESTAY",
                          style: TextStyle(
                            fontFamily: 'Virust',
                            letterSpacing: 5,
                            fontWeight: FontWeight.bold,
                            fontSize: 50,
                            foreground: Paint()
                              ..shader =
                                  LinearGradient(
                                    colors: <Color>[
                                      Color(0xff5a00ff),
                                      Color(0xffBF9BFF),
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ).createShader(
                                    Rect.fromLTWH(0.0, 0.0, 300.0, 70.0),
                                  ),
                          ),
                        ),
                        Text(
                          'The Best App To Choose Your Luxury Home ',
                          style: TextStyle(
                            fontFamily: 'Louis',
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Positioned(top: 1, right: 30, child:Icon(Icons.home_filled)),

                  //Picture
                  SvgPicture.asset('assets/chat.svg'),

                  //Button
                  // Login Button
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: SizedBox(
                      width: 300,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.off(() => LoginScreen());
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Multicolore',
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  //
                  //Sign In Button
                  SizedBox(
                    width: 300,
                    height: 50,
                    child: OutlinedButton(
                      onPressed: () {
                        Get.off(() => SignUpScreen());
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.white, width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Multicolore',
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
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
