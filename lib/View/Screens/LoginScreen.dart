import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../Controller/LoginController.dart';
import '../Components/CustomTextFeild.dart';
import 'SignIUpScreen.dart';
import 'WelcomeScreen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final controller = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formState = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.offAll(() => WelcomeScreen());
          },
          icon: Icon(Icons.arrow_back_ios_new_outlined),
        ),
      ),
      body: Form(
        key: formState,
        child: SizedBox(
          child: Stack(
            fit: StackFit.expand,
            children: [
              //Background
              Image.asset(
                'assets/Welcome.jpg',
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: EdgeInsetsGeometry.only(top: 40),
                child: SingleChildScrollView(
                  child: Column(
                    spacing: 10,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //Text
                      Text(
                        'Welcome Back!',
                        style: TextStyle(
                          fontFamily: 'Multicolore',
                          fontWeight: FontWeight.w500,
                          fontSize: 30,
                        ),
                      ),
                      Text(
                        "Let's Go Again",
                        style: TextStyle(fontFamily: 'louis', fontSize: 20),
                      ),

                      //picture
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: SvgPicture.asset('assets/login.svg'),
                      ),

                      //number
                      CreateTextField(
                        "Your Phone Number",
                        Icons.phone,
                        Color(0x3ae8b6ff),
                        controller.phoneController,
                      ),

                      //password
                      CreateTextField(
                        "Your password",
                        Icons.lock,
                        Color(0x3ae8b6ff),
                        controller.passwordController,
                      ),

                      // Login Button
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: SizedBox(
                          width: 350,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: controller.isLoading.value
                                ? null
                                : () {
                                    if (formState.currentState!.validate()) {
                                      controller.login();
                                    }
                                  },
                            child: Obx(() {
                              return controller.isLoading.value
                                  ? const CircularProgressIndicator(
                                      strokeWidth: 3,
                                    )
                                  : Text(
                                      "Login",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'Multicolore',
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 2,
                                      ),
                                    );
                            }),
                          ),
                        ),
                      ),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't Have An Account ? ",
                            style: TextStyle(fontSize: 16, fontFamily: 'louis'),
                          ),

                          TextButton(
                            onPressed: () {
                              Get.off(() => SignUpScreen());
                            },
                            child: Text(
                              'Create Account',
                              style: TextStyle(
                                fontFamily: 'Louis',
                                fontSize: 15,
                                color: Colors.white54,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
