import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:uni_project/main.dart';
import '../../Controller/LoginController.dart';
import '../Components/CustomTextFeild.dart';
import 'SignIUpScreen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'WelcomeScreen.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});


   final controller = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    // GlobalKey<FormState> formState = GlobalKey<FormState>();

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
        // key: formState,
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
                        padding: const EdgeInsets.only(top: 60),
                        child: SvgPicture.asset('assets/login.svg'),
                      ),

                      //number
                      CreateTextField(
                    
                        "Your Phone Number",
                        Icons.phone,
                        Color(0x3ae8b6ff),
                        controller.phoneController
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 30),
                      //   child: TextFormField(
                      //     validator: (value) {
                      //       if(value!.isEmpty)
                      //         {
                      //           return "Empty!";
                      //         }
                      //       return null;
                      //     },
                      //
                      //     keyboardType: TextInputType.number,
                      //     textInputAction: TextInputAction.next,
                      //     cursorColor: kPrimaryColor,
                      //     decoration: const InputDecoration(
                      //       filled: true,
                      //       fillColor: Color(0x3ae8b6ff),
                      //       enabledBorder: OutlineInputBorder(
                      //         borderSide: BorderSide(color: kPrimaryLightColor),
                      //         borderRadius: BorderRadius.all(Radius.circular(40)),
                      //       ),
                      //       focusedBorder: OutlineInputBorder(
                      //         borderSide: BorderSide(color: kPrimaryColor),
                      //         borderRadius: BorderRadius.all(Radius.circular(40))
                      //       ),
                      //
                      //       hintText: "Your Phone Number",
                      //       prefixIcon: Padding(
                      //         padding: EdgeInsets.all(defaultPadding),
                      //         child: Icon(Icons.person),
                      //       ),
                      //     ),
                      //   ),
                      // ),

                      //password
                      CreateTextField(
                      
                        "Your password",
                        Icons.lock,
                        Color(0x3ae8b6ff),
                        controller.passwordController
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      //   child: TextField(
                      //     textInputAction: TextInputAction.done,
                      //     obscureText: true,
                      //     cursorColor: kPrimaryColor,
                      //     decoration: const InputDecoration(
                      //       filled: true,
                      //       fillColor: Color(0x3ae8b6ff),
                      //       enabledBorder: OutlineInputBorder(
                      //         borderSide: BorderSide(color: kPrimaryLightColor),
                      //         borderRadius: BorderRadius.all(Radius.circular(40)),
                      //       ),
                      //       focusedBorder: OutlineInputBorder(
                      //           borderSide: BorderSide(color: kPrimaryColor),
                      //           borderRadius: BorderRadius.all(Radius.circular(40))
                      //       ),
                      //       hintText: "Your password",
                      //       prefixIcon: Padding(
                      //         padding: EdgeInsets.all(defaultPadding),
                      //         child: Icon(Icons.lock),
                      //       ),
                      //     ),
                      //   ),
                      // ),

                      // Login Button
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: SizedBox(
                          width: 390,
                          height: 50,
                          child: ElevatedButton(
                              onPressed: () {
                                controller.login();
                              },
                              child:Obx(() {
                                return controller.isLoading.value
                                    ? const CircularProgressIndicator(
                                  strokeWidth: 3,) : Text("Login" ,
                                style: TextStyle(
                                   fontSize: 20,
                                    fontFamily: 'Multicolore',
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2 ,
                                ),);
                              }
                              )
                            )



                          // Obx(()=>ElevatedButton(
                          //     onPressed: () {
                          //       if (formState.currentState!.validate()) {
                          //         print("login procceing");
                          //         Get.off(() => MainScreen());
                          //       }
                          //     },
                          //     child: Text(
                          //       'LOGIN',
                          //       style: TextStyle(
                          //         fontSize: 20,
                          //         fontFamily: 'Multicolore',
                          //         fontWeight: FontWeight.w500,
                          //         letterSpacing: 2,
                          //       ),
                          //     ),
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


