
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
                padding: EdgeInsetsGeometry.only(top: 60),
                child: SingleChildScrollView(
                  child: Column(
                    spacing: 12,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //Text
                      Text(
                        'Welcome !',
                        style: TextStyle(
                          fontFamily: 'Multicolore',
                          fontWeight: FontWeight.w500,
                          fontSize: 30,
                        ),
                      ),
                      Text(
                        "Let's Create Your Acount",
                        style: TextStyle(fontFamily: 'louis', fontSize: 20),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child:  ProfileImagePicker(),
                          ),

                          Column(
                            spacing: 8,
                            children: [
                              SizedBox(
                                width: 270,
                                child: CreateTextField(
                                  "First Name",
                                  Icons.person,
                                  Color(0xffa473ff),
                                  controller.firstNameController,
                                ),
                              ),
                              SizedBox(
                                width: 270,
                                child: CreateTextField(
                                  "Last Name",
                                  Icons.person,
                                  Color(0xcba474fe),
                                  controller.lastNameController,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      //Birthday
                      BirthdayPicker(),

                      //Phone
                      CreateTextField(
                        "Your Phone Number",
                        Icons.phone,
                        Color(0xffC9ACFE),
                        controller.phoneController,
                      ),

                      //password
                      CreateTextField(
                        "Your Password",
                        Icons.lock,
                        Color(0xffD6C0FF),
                        controller.passwordController,
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: SizedBox(
                          width: 390,
                          height: 50,
                          child: Obx(
                                () => ElevatedButton(
                              onPressed: controller.isLoading.value
                                  ? null
                                  : () {
                                if (formState.currentState!.validate()) {
                                  controller.signUp();
                                }
                              },
                              child: controller.isLoading.value
                                  ? const CircularProgressIndicator(
                                color: Colors.white, strokeWidth: 3,
                              )
                                  : const Text(
                                'SIGN UP',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Multicolore',
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 2,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      // //coniform password
                      // CreateTextField(

                      //   "Coniform Your Password",
                      //   Icons.security,
                      //   Color(0xffE5D6FF),
                      //   controller.passwordController
                      // ),

                      // Sign up Button
                      // Padding(
                      //   padding: const EdgeInsets.only(top: 10),
                      //   child: SizedBox(
                      //     width: 390,
                      //     height: 50,
                      //     child:Obx(()=> ElevatedButton(
                      //       onPressed: () {
                      //
                      //         // sharedPreference!.setString("state", "signup");
                      //         // Access the selected image from ProfileImagePicker
                      //         // File? selectedImage =
                      //         //     _imagePickerKey.currentState?.selectedImage;
                      //
                      //         // // Validate image
                      //         // if (selectedImage == null) {
                      //         //   Get.snackbar(
                      //         //     "Error",
                      //         //     "Please select a profile image",
                      //         //     snackPosition: SnackPosition.TOP,
                      //         //   );
                      //         // }
                      //         // bool isFormValid = formState.currentState!.validate();
                      //         // if (isFormValid) {
                      //         //   Get.snackbar(
                      //         //     "LUXESTAY",
                      //         //     "Login Successfully",
                      //         //
                      //         //     snackPosition: SnackPosition.TOP,
                      //         //   );
                      //         //   // Get.off(() => MainScreen());
                      //         // }
                      //         // if(formState.currentState!.validate())
                      //         //   {
                      //         //    Get.to(RealEstateApp());
                      //         //   }
                      //       },
                      //       child: Text(
                      //         'SIGN UP',
                      //         style: TextStyle(
                      //           fontSize: 20,
                      //           fontFamily: 'Multicolore',
                      //           fontWeight: FontWeight.w500,
                      //           letterSpacing: 2,
                      //         ),
                      //       ),
                      //     ),)
                      //   ),
                      // ),

                      //picture
                      SizedBox(
                        width: 200,
                        height: 150,
                        child: SvgPicture.asset('assets/signup.svg'),
                      ),
                      //Having account
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already Having An Account ?',
                            style: TextStyle(fontSize: 16, fontFamily: 'louis'),
                          ),

                          TextButton(
                            onPressed: () {
                              Get.off(() => LoginScreen());
                            },
                            child: Text(
                              '-> Login',
                              style: TextStyle(
                                fontFamily: 'Louis',
                                fontSize: 20,
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
