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
        backgroundColor: Colors.white,
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: CreateTextField(
                          title: "Your Phone Number",
                          icon: Icons.phone,
                          color: Color(0x3ae8b6ff),
                          controller: controller.phoneController,
                        ),
                      ),

                      //password
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: CreateTextField(
                            title: "Your password",
                            icon: Icons.lock,
                            color: Color(0x3ae8b6ff),
                            controller: controller.passwordController,
                            isPassword: true
                        ),
                      ),

                      // Login Button
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Container(
                          width: double.infinity,
                          height: 55,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            gradient: LinearGradient(
                                colors: [
                                  Color(0xffdc85b4).withOpacity(0.7),
                                  Color(0xff9d05e8).withOpacity(0.7),
                                  Color(0xff4805b0).withOpacity(0.7),
                                  Color(0xff4805b0),
                                ],
                                begin: AlignmentGeometry.topLeft,
                                end: AlignmentGeometry.bottomRight
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFFFDBB79).withOpacity(
                                    0.5),
                                blurRadius: 10,
                                spreadRadius: 1,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                              onPressed: controller.isLoading.value
                                  ? null
                                  : () {
                                if (formState.currentState!.validate()) {
                                  controller.login();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                              ),
                              child: Obx(() {
                                return controller.isLoading.value
                                    ? const CircularProgressIndicator(
                                  strokeWidth: 3, color: Colors.white,
                                )
                                    : Text(
                                  "Login",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'Multicolore',
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2,
                                  ),
                                );
                              }
                              )
                          ),
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(vertical: 10),
                      //   child: SizedBox(
                      //     width: 350,
                      //     height: 50,
                      //     child: ElevatedButton(
                      //       onPressed: controller.isLoading.value
                      //           ? null
                      //           : () {
                      //         if (formState.currentState!.validate()) {
                      //           controller.login();
                      //         }
                      //       },
                      //       child: Obx(() {
                      //         return controller.isLoading.value
                      //             ? const CircularProgressIndicator(
                      //           strokeWidth: 3,
                      //         )
                      //             : Text(
                      //           "Login",
                      //           style: TextStyle(
                      //             fontSize: 20,
                      //             fontFamily: 'Multicolore',
                      //             fontWeight: FontWeight.bold,
                      //             letterSpacing: 2,
                      //           ),
                      //         );
                      //       }),
                      //     ),
                      //   ),
                      // ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't Have An Account ?",
                            style: TextStyle(fontSize: 16,
                                fontFamily: 'louis',
                                color: Color(0xff6e35a4)),
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
                                color: Color(0xFFF9C37F),
                                decoration: TextDecoration.underline,
                                decorationColor: Color(0xFFF9C37F),
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


// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'dart:ui';
//
// import '../../Controller/LoginController.dart';
// import 'SignIUpScreen.dart';
// import 'WelcomeScreen.dart';
//
// class LoginScreen extends StatelessWidget {
//   LoginScreen({super.key});
//
//   final controller = Get.find<LoginController>();
//   final GlobalKey<FormState> formState = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           onPressed: () {
//             Get.offAll(() => WelcomeScreen());
//           },
//           icon: const Icon(Icons.arrow_back_ios_new_outlined, color: Colors.white),
//         ),
//       ),
//       body: Form(
//         key: formState,
//         child: LuxeBackground(
//           child: Center(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.all(24.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.all(20),
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: Colors.white.withOpacity(0.05),
//                       border: Border.all(
//                           color: Colors.white.withOpacity(0.1), width: 1),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.white.withOpacity(0.2),
//                           blurRadius: 20,
//                           spreadRadius: 5,
//                         ),
//                       ],
//                     ),
//                     child: ShaderMask(
//                       shaderCallback: (bounds) =>
//                           LinearGradient(
//                             colors: [
//                               Color(0xff4805b0),
//                               Color(0xff9d05e8),
//                               Color(0xffc450e0),
//                               Color(0xffeed5a0),
//                               Color(0xffeed5a0),
//                             ],
//                             begin: Alignment.centerLeft,
//                             end: Alignment.centerRight,
//                           ).createShader(bounds),
//                       child: const Icon(
//                           Icons.real_estate_agent_rounded, size: 120,
//                           color: Color(
//                               0xFFA516E4)),
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   const Text(
//                     "Welcome Back!",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontFamily: 'Multicolore',
//                       fontSize: 28,
//                       letterSpacing: 1.5,
//                       color: Colors.white,
//                     ),
//                   ),
//                   const SizedBox(height: 5),
//                   Text(
//                     "Let's Go Again",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontFamily: 'louis',
//                       fontSize: 16,
//                       color: Colors.white.withOpacity(0.7),
//                     ),
//                   ),
//
//                   const SizedBox(height: 50),
//
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(20),
//                     child: BackdropFilter(
//                       filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//                       child: Container(
//                         padding: const EdgeInsets.all(24),
//                         decoration: BoxDecoration(
//                           color: Colors.white.withOpacity(0.05),
//                           borderRadius: BorderRadius.circular(20),
//                           border: Border.all(color: Colors.white.withOpacity(0.1)),
//                         ),
//                         child: Column(
//                           children: [
//                             const Align(
//                               alignment: Alignment.centerLeft,
//                               child: Text("Login Details", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
//                             ),
//                             const SizedBox(height: 25),
//
//                             _buildTextFormField(
//                               controller: controller.phoneController,
//                               label: "Phone Number",
//                               icon: Icons.phone_outlined,
//                               inputType: TextInputType.phone,
//                               validator: (val) {
//                                 if (val == null || val.isEmpty) return "Phone number is required";
//                                 return null;
//                               },
//                             ),
//                             const SizedBox(height: 20),
//
//                             _buildTextFormField(
//                               controller: controller.passwordController,
//                               label: "Password",
//                               icon: Icons.lock_outline,
//                               isPassword: true,
//                               validator: (val) {
//                                 if (val == null || val.isEmpty) return "Password is required";
//                                 return null;
//                               },
//                             ),
//                             const SizedBox(height: 30),
//
//                             Obx(() => _buildGoldButton(
//                               label: "Login",
//                               isLoading: controller.isLoading.value,
//                               onTap: controller.isLoading.value
//                                   ? () {}
//                                   : () {
//                                 if (formState.currentState!.validate()) {
//                                   controller.login();
//                                 }
//                               },
//                             )),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//
//                   const SizedBox(height: 20),
//
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text("Don't Have An Account? ", style: TextStyle(color: Colors.white.withOpacity(0.7), fontFamily: 'louis')),
//                       GestureDetector(
//                         onTap: () {
//                           Get.off(() => SignUpScreen());
//                         },
//                         child: const Text(
//                           "Create Account",
//                           style: TextStyle(
//                             color: Color(0xFFD4AF37),
//                             fontWeight: FontWeight.bold,
//                             decoration: TextDecoration.underline,
//                             decorationColor: Color(0xFFD4AF37),
//                             fontFamily: 'Louis',
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
//
// class LuxeBackground extends StatelessWidget {
//   final Widget child;
//   const LuxeBackground({super.key, required this.child});
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Positioned.fill(
//           child: Image.asset(
//             'assets/Welcome.jpg',
//             fit: BoxFit.cover,
//           ),
//         ),
//         Positioned.fill(
//           child: Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [
//                   Color(0xB88B5AC5).withOpacity(0.3),
//                   Color(0xFF8B5AC5).withOpacity(0.8),
//                   Color(0xFF8B5AC5).withOpacity(0.95),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         SafeArea(child: child),
//       ],
//     );
//   }
// }
//
// Widget _buildTextFormField({
//   required TextEditingController controller,
//   required String label,
//   required IconData icon,
//   bool isPassword = false,
//   TextInputType inputType = TextInputType.text,
//   String? Function(String?)? validator,
// }) {
//   return TextFormField(
//     controller: controller,
//     obscureText: isPassword,
//     keyboardType: inputType,
//     textInputAction: TextInputAction.next,
//     validator: validator,
//     style: const TextStyle(color: Colors.white),
//     cursorColor: const Color(0xff9d05e8),
//
//     decoration: InputDecoration(
//       labelText: label,
//       labelStyle: const TextStyle(color: Colors.white70),
//       prefixIcon: Icon(icon, color: const Color(0xff9e14e4), size: 20),
//       filled: true,
//       fillColor: Colors.white.withOpacity(0.1),
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: BorderSide.none,
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: BorderSide(color: Color(0xFFC293F3), width: 1.5),
//       ),
//       errorBorder: OutlineInputBorder(
//           borderSide: BorderSide(color: Colors.red),
//           borderRadius: BorderRadius.all(Radius.circular(12))
//       ),
//
//       focusedErrorBorder: OutlineInputBorder(
//           borderSide: BorderSide(color: Colors.red),
//           borderRadius: BorderRadius.all(Radius.circular(12))
//       ),
//       errorStyle: TextStyle(color: Color(0xFFFF001E)),
//     ),
//   );
// }
//
// Widget _buildGoldButton({required String label, required VoidCallback onTap, bool isLoading = false}) {
//   return Container(
//     width: double.infinity,
//     height: 55,
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(12),
//       gradient: LinearGradient(
//         colors: [
//           Color(0xffdc85b4).withOpacity(0.7),
//           Color(0xff9d05e8).withOpacity(0.7),
//           Color(0xff4805b0).withOpacity(0.7),
//           Color(0xff4805b0),
//         ],
//       ),
//       boxShadow: [
//         BoxShadow(
//           color: const Color(0xFFB724F3).withOpacity(0.7),
//           blurRadius: 15,
//           offset: const Offset(0, 5),
//         ),
//       ],
//     ),
//     child: ElevatedButton(
//       onPressed: isLoading ? null : onTap,
//       style: ElevatedButton.styleFrom(
//         backgroundColor: Colors.transparent,
//         shadowColor: Colors.transparent,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       ),
//       child: isLoading
//           ? const CircularProgressIndicator(color: Colors.white, strokeWidth: 3)
//           : Text(
//         label,
//         style: const TextStyle(
//           color: Colors.white,
//           fontSize: 18,
//           fontFamily: 'Multicolore',
//           fontWeight: FontWeight.bold,
//           letterSpacing: 2,
//         ),
//       ),
//     ),
//   );
// }
