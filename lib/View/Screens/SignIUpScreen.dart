import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:ui';

import 'package:uni_project/View/Components/BirthdayPicker.dart';
import 'package:uni_project/View/Screens/LoginScreen.dart';
import '../../Controller/SignUpController.dart';
import '../Components/ProfileImagePicker.dart';
import 'WelcomeScreen.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  final SignUpController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Welcome',
          style: TextStyle(
              fontFamily: 'Multicolore', fontSize: 25, color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            Get.offAll(() => WelcomeScreen());
          },
          icon: const Icon(Icons.arrow_back_ios_new_outlined,
              color: Colors.white),
        ),
      ),
      body: Form(
        key: formState,
        child: LuxeBackground(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    "Let's Create Your Account",
                    style: TextStyle(
                        fontSize: 25,
                        fontFamily: 'louis',
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 10),

                  // Profile Image
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xff9e14e4).withOpacity(0.2),
                          blurRadius: 20,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: ProfileImagePicker(radius: 60),
                  ),
                  const SizedBox(height: 10),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white.withOpacity(0.1)),
                        ),
                        child: Column(
                          children: [
                            // First & Last Name
                            Row(
                              children: [
                                Expanded(
                                  child: _buildTextFormField(
                                    c: controller.firstNameController,
                                    label: "First Name",
                                    icon: Icons.person_outline,
                                    validator: (v) =>
                                    v!.isEmpty
                                        ? "Required"
                                        : null,
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Expanded(
                                  child: _buildTextFormField(
                                    c: controller.lastNameController,
                                    label: "Last Name",
                                    icon: Icons.person_outline,
                                    validator: (v) =>
                                    v!.isEmpty
                                        ? "Required"
                                        : null,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),

                            // Birthday Picker
                            BirthdayPicker(),
                            const SizedBox(height: 20),

                            // Phone
                            _buildTextFormField(
                              c: controller.phoneController,
                              label: "Your Phone Number",
                              icon: Icons.phone_outlined,
                              inputType: TextInputType.number,
                              validator: (v) => v!.isEmpty ? "Required" : null,
                            ),
                            const SizedBox(height: 20),

                            // Password
                            _buildTextFormField(
                              c: controller.passwordController,
                              label: "Your Password",
                              icon: Icons.lock_outline,
                              isPassword: true,
                              validator: (v) => v!.isEmpty ? "Required" : null,
                            ),
                            const SizedBox(height: 20),

                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 8.0),
                                child: Text("ID Verification",
                                    style: TextStyle(color: Colors.white70)),
                              ),
                            ),

                            // ID Image
                            GestureDetector(
                              onTap: controller.creditIdImage,
                              child: Obx(() {
                                return Container(
                                  height: 130,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.05),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                        color: Colors.white.withOpacity(0.2),
                                        style: BorderStyle.solid),
                                    image: controller.creditImage.value != null
                                        ? DecorationImage(
                                      image: FileImage(
                                          controller.creditImage.value!),
                                      fit: BoxFit.cover,
                                    )
                                        : null,
                                  ),
                                  child: controller.creditImage.value == null
                                      ? Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                          Icons.add_a_photo_outlined,
                                          color: Color(0xFF8A1AD5),
                                          size: 30),
                                      const SizedBox(height: 8),
                                      Text(
                                        "Upload ID Photo",
                                        style: TextStyle(
                                            color: Colors.white
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

                            const SizedBox(height: 30),

                            // Sign Up Button
                            Obx(() => _buildGoldButton(
                              label: "SIGN UP",
                              isLoading: controller.isLoading.value,
                              onTap: controller.isLoading.value
                                  ? () {}
                                  : () {
                                if (formState.currentState!
                                    .validate()) {
                                  controller.signUp();
                                }
                              },
                            )),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                  // Already have account?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already Have An Account? ",
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontFamily: 'louis'),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.off(() => LoginScreen());
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(
                              color: Color(0xFFD4AF37),
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              decorationColor: Color(0xFFD4AF37),
                              fontFamily: 'Louis',
                              fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ---------------- TEXT FIELD BUILDER ----------------
  Widget _buildTextFormField({
    required TextEditingController c,
    required String label,
    required IconData icon,
    bool isPassword = false,
    TextInputType inputType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return
      TextFormField(
        controller: c,
        obscureText: isPassword ? !controller.isVisible.value : true,
        keyboardType: inputType,
        textInputAction: TextInputAction.next,
        validator: validator,
        style: const TextStyle(color: Colors.white, fontSize: 13),
        cursorColor: const Color(0xff9d05e8),
        decoration: InputDecoration(
          suffixIcon: isPassword
              ? IconButton(
            icon: Obx(() =>
                Icon(
                  controller.isVisible.value
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: Colors.white70,
                  size: 20,
                ),
            ),
            onPressed: () {
              controller.isVisible.value =
              !controller.isVisible.value;
            },
          )
              : null,
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white70, fontSize: 13),
          prefixIcon: Icon(icon, color: const Color(0xff9e14e4), size: 20),
          filled: true,
          fillColor: Colors.white.withOpacity(0.1),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Color(0xFFC293F3), width: 1.5),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          errorStyle: const TextStyle(color: Color(0xFFFF001E)),
        ),
      );
  }
}

// ---------------- GOLD BUTTON ----------------
Widget _buildGoldButton(
    {required String label, required VoidCallback onTap, bool isLoading = false}) {
  return Container(
    width: double.infinity,
    height: 55,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      gradient: LinearGradient(
        colors: [
          Color(0xffdc85b4).withOpacity(0.7),
          Color(0xff9d05e8).withOpacity(0.7),
          Color(0xff4805b0).withOpacity(0.7),
          Color(0xff4805b0),
        ],
      ),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFFB724F3).withOpacity(0.7),
          blurRadius: 15,
          offset: const Offset(0, 5),
        ),
      ],
    ),
    child: ElevatedButton(
      onPressed: isLoading ? null : onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: isLoading
          ? const CircularProgressIndicator(color: Colors.white, strokeWidth: 3)
          : Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontFamily: 'Multicolore',
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
        ),
      ),
    ),
  );
}
