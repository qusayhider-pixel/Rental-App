import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:uni_project/View/Components/BirthdayPicker.dart';
import 'package:uni_project/View/Screens/LoginScreen.dart';
import '../../Controller/SignUpController.dart';
import '../Components/CustomTextFeild.dart';
import '../Components/ProfileImagePicker.dart';
import 'WelcomeScreen.dart';


class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  final SignUpController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Welcome',
          style: TextStyle(fontFamily: 'Multicolore', fontSize: 25),
        ),
        leading: IconButton(
          onPressed: () {
            Get.offAll(() => WelcomeScreen());
          },
          icon: Icon(Icons.arrow_back_ios_new_outlined),
        ),
      ),

      body: Form(
        key: formState,
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

              //picture
              Positioned(
                top: -10,
                // left: 100,
                right: 40,
                child: SizedBox(
                  width: 170,
                  height: 170,
                  child: SvgPicture.asset('assets/signup.svg'),
                ),
              ),

              Positioned(
                top: 40,
                // left: 100,
                left: 40,
                child: SizedBox(
                  width: 200,
                  height: 150,
                  child: Text(
                    "Let's Create Your Acount",
                    style: TextStyle(fontFamily: 'louis',
                        fontSize: 25,
                        color: Colors.black),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsetsGeometry.only(top: 140, left: 20, right: 20),
                child: SingleChildScrollView(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.09),
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(
                                  color: Colors.white.withOpacity(
                                      0.1)),
                            ),
                            child: Column(
                              spacing: 12,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [


                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15, top: 12),
                                  child: Row(
                                    spacing: 15,
                                    children: [
                                      Flexible(
                                        child: Column(
                                          spacing: 8,
                                          children: [
                                            CreateTextField(
                                              title: "First Name",
                                              icon: Icons.person,
                                              color: Color(0xffa473ff),
                                              controller: controller
                                                  .firstNameController,
                                            ),
                                            CreateTextField(
                                              title: "Last Name",
                                              icon: Icons.person,
                                              color: Color(0xcba474fe),
                                              controller: controller
                                                  .lastNameController,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Flexible(
                                          child: ProfileImagePicker()
                                      ),
                                    ],
                                  ),
                                ),

                                //Birthday
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0),
                                  child: BirthdayPicker(),
                                ),

                                //Phone
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0),
                                  child: CreateTextField(
                                    title: "Your Phone Number",
                                    icon: Icons.phone,
                                    color: Color(0xffC9ACFE),
                                    controller: controller.phoneController,
                                  ),
                                ),

                                //password
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0), child: CreateTextField(
                                    title: "Your Password",
                                    icon: Icons.lock,
                                    color: Color(0xffD6C0FF),
                                    controller: controller.passwordController,
                                    isPassword: true

                                ),
                                ),

                                // id photo
                                // GestureDetector(
                                //   onTap: controller.creditIdImage,
                                //   child: Obx(() {
                                //     return Stack(
                                //       alignment: Alignment.bottomRight,
                                //       children: [
                                //         Container(
                                //           width: 345,
                                //           height: 130,
                                //           decoration: BoxDecoration(
                                //             color: Colors.white.withOpacity(0.2),
                                //             border: BoxBorder.all(color: Colors.white),
                                //             borderRadius: BorderRadius.circular(26),
                                //             image: controller.creditImage.value != null
                                //                 ? DecorationImage(
                                //               image: FileImage(
                                //                   controller.creditImage.value!),
                                //               fit: BoxFit.cover,
                                //             )
                                //                 : null,
                                //           ),
                                //           child: controller.creditImage.value == null
                                //               ? const Center(
                                //             child: Icon(
                                //               Icons.credit_card,
                                //               size: 50,
                                //               color: Colors.white,
                                //             ),
                                //           )
                                //               : null,
                                //         ),
                                //
                                //         // add icon
                                //         Container(
                                //           margin: const EdgeInsets.all(8),
                                //           width: 36,
                                //           height: 36,
                                //           decoration: const BoxDecoration(
                                //             color: Color(0xcba474fe),
                                //             shape: BoxShape.circle,
                                //           ),
                                //           child: const Icon(
                                //             Icons.add_card,
                                //             size: 18,
                                //             color: Colors.white,
                                //           ),
                                //         ),
                                //       ],
                                //     );
                                //   }),
                                // ),

                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  child: GestureDetector(
                                    onTap: controller.creditIdImage,
                                    child: Obx(() {
                                      return Container(
                                        width: 345,
                                        height: 130,
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(
                                              26),
                                          border: Border.all(
                                              color: Colors.white.withOpacity(
                                                  0.2),
                                              style: BorderStyle.solid),
                                          image: controller.creditImage.value !=
                                              null
                                              ? DecorationImage(
                                            image: FileImage(
                                                controller.creditImage.value!),
                                            fit: BoxFit.cover,
                                          )
                                              : null,
                                        ),
                                        child: controller.creditImage.value ==
                                            null
                                            ? Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            const Icon(
                                                Icons.add_a_photo_outlined,
                                                color: Color(0xFF712BB7),
                                                size: 30),
                                            const SizedBox(height: 8),
                                            Text(
                                              "Upload ID Photo",
                                              style: TextStyle(
                                                  color: Color(0xFF712BB7)
                                                      .withOpacity(0.6),
                                                  fontSize: 12),
                                            ),
                                          ],
                                        )
                                            : Align(
                                          alignment: Alignment.bottomRight,
                                          child: Container(
                                            margin: const EdgeInsets.all(8),
                                            padding: const EdgeInsets.all(6),
                                            decoration: const BoxDecoration(
                                              color: Color(0xFF8A1AD5),
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(Icons.edit,
                                                size: 16, color: Colors.white),
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
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
                                    child: InkWell(
                                      onTap: controller.isLoading.value
                                          ? null
                                          : () {
                                        if (formState.currentState!
                                            .validate()) {
                                          controller.signUp();
                                        }
                                      },
                                      borderRadius: BorderRadius.circular(12),
                                      child: Center(
                                          child: Obx(() =>
                                          controller.isLoading.value
                                              ? const CircularProgressIndicator(
                                            color: Colors.white, strokeWidth: 3,
                                          )
                                              : Text(
                                            'SIGN UP',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontFamily: 'Multicolore',
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 2,
                                            ),
                                          ),
                                          )
                                      ),
                                    ),
                                  ),
                                ),
                                // SizedBox(
                                //   width: 350,
                                //   height: 50,
                                //   child: Obx(
                                //         () =>
                                //         ElevatedButton(
                                //             onPressed: controller.isLoading.value
                                //                 ? null
                                //                 : () {
                                //               if (formState.currentState!.validate()) {
                                //                 controller.signUp();
                                //               }
                                //             },
                                //             child: Obx(() =>
                                //             controller.isLoading.value
                                //                 ? const CircularProgressIndicator(
                                //               color: Colors.white, strokeWidth: 3,
                                //             )
                                //                 : const Text(
                                //               'SIGN UP',
                                //               style: TextStyle(
                                //                 fontSize: 20,
                                //                 fontFamily: 'Multicolore',
                                //                 fontWeight: FontWeight.w500,
                                //                 letterSpacing: 2,
                                //               ),
                                //             ),)
                                //         ),
                                //   ),
                                // ),


                                //Having account
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Already Have An Account ?',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'louis',
                                            color:

                                            Colors.grey.shade300),
                                      ),

                                      TextButton(
                                        onPressed: () {
                                          Get.off(() => LoginScreen());
                                        },
                                        child: Text(
                                          'Login',
                                          style: TextStyle(
                                            fontFamily: 'Louis',
                                            fontSize: 20,
                                            color: Color(0xFF712BB7),
                                            decoration: TextDecoration
                                                .underline,
                                            decorationColor: Color(0xFF712BB7),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                      )
                  ),
                ),
              )
            ]
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'dart:ui';
//
// import 'package:uni_project/View/Components/BirthdayPicker.dart';
// import 'package:uni_project/View/Screens/LoginScreen.dart';
// import '../../Controller/SignUpController.dart';
// import '../Components/ProfileImagePicker.dart';
// import 'WelcomeScreen.dart';
//
// class SignUpScreen extends StatelessWidget {
//   SignUpScreen({super.key});
//
//   final GlobalKey<FormState> formState = GlobalKey<FormState>();
//   final SignUpController controller = Get.find();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         title: const Text(
//           'Welcome',
//           style: TextStyle(
//               fontFamily: 'Multicolore', fontSize: 25, color: Colors.white),
//         ),
//         leading: IconButton(
//           onPressed: () {
//             Get.offAll(() => WelcomeScreen());
//           },
//           icon: const Icon(Icons.arrow_back_ios_new_outlined,
//               color: Colors.white),
//         ),
//       ),
//       body: Form(
//         key: formState,
//         child: LuxeBackground(
//           child: Center(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.all(24.0),
//               child: Column(
//                 children: [
//                   const SizedBox(height: 20),
//                   const Text(
//                     "Let's Create Your Account",
//                     style: TextStyle(
//                         fontSize: 25,
//                         fontFamily: 'louis',
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white),
//                   ),
//                   const SizedBox(height: 10),
//
//                   // Profile Image
//                   Container(
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       boxShadow: [
//                         BoxShadow(
//                           color: const Color(0xff9e14e4).withOpacity(0.2),
//                           blurRadius: 20,
//                           spreadRadius: 2,
//                         ),
//                       ],
//                     ),
//                     child: ProfileImagePicker(radius: 60),
//                   ),
//                   const SizedBox(height: 10),
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
//                             // First & Last Name
//                             Row(
//                               children: [
//                                 Expanded(
//                                   child: _buildTextFormField(
//                                     c: controller.firstNameController,
//                                     label: "First Name",
//                                     icon: Icons.person_outline,
//                                     validator: (v) =>
//                                     v!.isEmpty
//                                         ? "Required"
//                                         : null,
//                                   ),
//                                 ),
//                                 const SizedBox(width: 15),
//                                 Expanded(
//                                   child: _buildTextFormField(
//                                     c: controller.lastNameController,
//                                     label: "Last Name",
//                                     icon: Icons.person_outline,
//                                     validator: (v) =>
//                                     v!.isEmpty
//                                         ? "Required"
//                                         : null,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 20),
//
//                             // Birthday Picker
//                             BirthdayPicker(),
//                             const SizedBox(height: 20),
//
//                             // Phone
//                             _buildTextFormField(
//                               c: controller.phoneController,
//                               label: "Your Phone Number",
//                               icon: Icons.phone_outlined,
//                               inputType: TextInputType.number,
//                               validator: (v) => v!.isEmpty ? "Required" : null,
//                             ),
//                             const SizedBox(height: 20),
//
//                             // Password
//                             _buildTextFormField(
//                               c: controller.passwordController,
//                               label: "Your Password",
//                               icon: Icons.lock_outline,
//                               isPassword: true,
//                               validator: (v) => v!.isEmpty ? "Required" : null,
//                             ),
//                             const SizedBox(height: 20),
//
//                             const Align(
//                               alignment: Alignment.centerLeft,
//                               child: Padding(
//                                 padding: EdgeInsets.only(bottom: 8.0),
//                                 child: Text("ID Verification",
//                                     style: TextStyle(color: Colors.white70)),
//                               ),
//                             ),
//
//                             // ID Image
//                             GestureDetector(
//                               onTap: controller.creditIdImage,
//                               child: Obx(() {
//                                 return Container(
//                                   height: 130,
//                                   width: double.infinity,
//                                   decoration: BoxDecoration(
//                                     color: Colors.white.withOpacity(0.05),
//                                     borderRadius: BorderRadius.circular(12),
//                                     border: Border.all(
//                                         color: Colors.white.withOpacity(0.2),
//                                         style: BorderStyle.solid),
//                                     image: controller.creditImage.value != null
//                                         ? DecorationImage(
//                                       image: FileImage(
//                                           controller.creditImage.value!),
//                                       fit: BoxFit.cover,
//                                     )
//                                         : null,
//                                   ),
//                                   child: controller.creditImage.value == null
//                                       ? Column(
//                                     mainAxisAlignment:
//                                     MainAxisAlignment.center,
//                                     children: [
//                                       const Icon(
//                                           Icons.add_a_photo_outlined,
//                                           color: Color(0xFF8A1AD5),
//                                           size: 30),
//                                       const SizedBox(height: 8),
//                                       Text(
//                                         "Upload ID Photo",
//                                         style: TextStyle(
//                                             color: Colors.white
//                                                 .withOpacity(0.6),
//                                             fontSize: 12),
//                                       ),
//                                     ],
//                                   )
//                                       : Align(
//                                     alignment: Alignment.bottomRight,
//                                     child: Container(
//                                       margin: const EdgeInsets.all(8),
//                                       padding: const EdgeInsets.all(6),
//                                       decoration: const BoxDecoration(
//                                         color: Color(0xFF8A1AD5),
//                                         shape: BoxShape.circle,
//                                       ),
//                                       child: const Icon(Icons.edit,
//                                           size: 16, color: Colors.white),
//                                     ),
//                                   ),
//                                 );
//                               }),
//                             ),
//
//                             const SizedBox(height: 30),
//
//                             // Sign Up Button
//                             Obx(() => _buildGoldButton(
//                               label: "SIGN UP",
//                               isLoading: controller.isLoading.value,
//                               onTap: controller.isLoading.value
//                                   ? () {}
//                                   : () {
//                                 if (formState.currentState!
//                                     .validate()) {
//                                   controller.signUp();
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
//                   // Already have account?
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         "Already Have An Account? ",
//                         style: TextStyle(
//                             color: Colors.white.withOpacity(0.7),
//                             fontFamily: 'louis'),
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           Get.off(() => LoginScreen());
//                         },
//                         child: const Text(
//                           "Login",
//                           style: TextStyle(
//                               color: Color(0xFFD4AF37),
//                               fontWeight: FontWeight.bold,
//                               decoration: TextDecoration.underline,
//                               decorationColor: Color(0xFFD4AF37),
//                               fontFamily: 'Louis',
//                               fontSize: 16),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 20),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   // ---------------- TEXT FIELD BUILDER ----------------
//   Widget _buildTextFormField({
//     required TextEditingController c,
//     required String label,
//     required IconData icon,
//     bool isPassword = false,
//     TextInputType inputType = TextInputType.text,
//     String? Function(String?)? validator,
//   }) {
//     return
//       TextFormField(
//         controller: c,
//         obscureText: isPassword ? !controller.isVisible.value : true,
//         keyboardType: inputType,
//         textInputAction: TextInputAction.next,
//         validator: validator,
//         style: const TextStyle(color: Colors.white, fontSize: 13),
//         cursorColor: const Color(0xff9d05e8),
//         decoration: InputDecoration(
//           suffixIcon: isPassword
//               ? IconButton(
//             icon: Obx(() =>
//                 Icon(
//                   controller.isVisible.value
//                       ? Icons.visibility
//                       : Icons.visibility_off,
//                   color: Colors.white70,
//                   size: 20,
//                 ),
//             ),
//             onPressed: () {
//               controller.isVisible.value =
//               !controller.isVisible.value;
//             },
//           )
//               : null,
//           labelText: label,
//           labelStyle: const TextStyle(color: Colors.white70, fontSize: 13),
//           prefixIcon: Icon(icon, color: const Color(0xff9e14e4), size: 20),
//           filled: true,
//           fillColor: Colors.white.withOpacity(0.1),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: BorderSide.none,
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: BorderSide(color: Color(0xFFC293F3), width: 1.5),
//           ),
//           errorBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: Colors.red),
//             borderRadius: const BorderRadius.all(Radius.circular(12)),
//           ),
//           focusedErrorBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: Colors.red),
//             borderRadius: const BorderRadius.all(Radius.circular(12)),
//           ),
//           errorStyle: const TextStyle(color: Color(0xFFFF001E)),
//         ),
//       );
//   }
// }
//
// // ---------------- GOLD BUTTON ----------------
// Widget _buildGoldButton(
//     {required String label, required VoidCallback onTap, bool isLoading = false}) {
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
//         shape:
//         RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
