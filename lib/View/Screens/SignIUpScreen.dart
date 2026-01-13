
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
                  "Let's Create Your Account",
                  style: TextStyle(fontFamily: 'louis',
                      fontSize: 25,
                      color: Colors.black),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsetsGeometry.only(top: 140),
              child: SingleChildScrollView(
                child: Column(
                  spacing: 12,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [


                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: ProfileImagePicker(radius: 60),
                        ),

                        Column(
                          spacing: 8,
                          children: [
                            SizedBox(
                              width: 240,
                              child: CreateTextField(
                                "First Name",
                                Icons.person,
                                Color(0xffa473ff),
                                controller.firstNameController,
                              ),
                            ),
                            SizedBox(
                              width: 240,
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

                    // id photo
                    GestureDetector(
                      onTap: controller.creditIdImage,
                      child: Obx(() {
                        return Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Container(
                              width: 345,
                              height: 130,
                              decoration: BoxDecoration(
                                color: const Color(0xffd4bffd),
                                border: BoxBorder.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(26),
                                image: controller.creditImage.value != null
                                    ? DecorationImage(
                                  image: FileImage(
                                      controller.creditImage.value!),
                                  fit: BoxFit.cover,
                                )
                                    : null,
                              ),
                              child: controller.creditImage.value == null
                                  ? const Center(
                                child: Icon(
                                  Icons.credit_card,
                                  size: 50,
                                  color: Colors.white,
                                ),
                              )
                                  : null,
                            ),

                            // add icon
                            Container(
                              margin: const EdgeInsets.all(8),
                              width: 36,
                              height: 36,
                              decoration: const BoxDecoration(
                                color: Color(0xcba474fe),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.add_card,
                                size: 18,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        );
                      }),
                    ),


                    SizedBox(
                      width: 350,
                      height: 50,
                      child: Obx(
                            () =>
                            ElevatedButton(
                              onPressed: controller.isLoading.value
                                  ? null
                                  : () {
                                if (formState.currentState!.validate()) {
                                  controller.signUp();
                                }
                              },
                                child: Obx(() =>
                                controller.isLoading.value
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
                                ),)
                            ),
                      ),
                    ),


                    //Having account
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already Have An Account ?',
                            style: TextStyle(
                                fontSize: 16, fontFamily: 'louis', color:

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
                                color: Colors.grey.shade100,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
