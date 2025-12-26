

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'WelcomeScreen.dart';

class SplashScreenWidget extends StatelessWidget {
  const SplashScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        splash: Lottie.asset('assets/WelcomeSplash.json'),
        nextScreen: WelcomeScreen(),
        splashIconSize: 300,
        duration: 3000,
        // backgroundColor: Colors.white,
    );
  }
}
