import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:ui';

import '../../Controller/LoginController.dart';
import 'SignIUpScreen.dart';
import 'WelcomeScreen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final controller = Get.find<LoginController>();
  final GlobalKey<FormState> formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.offAll(() => WelcomeScreen());
          },
          icon: const Icon(Icons.arrow_back_ios_new_outlined, color: Colors.white),
        ),
      ),
      body: Form(
        key: formState,
        child: LuxeBackground(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(Icons.real_estate_agent_rounded, size: 120, color: Color(0xFFD4AF37)),
                  const SizedBox(height: 10),
                  const Text(
                    "Welcome Back!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Multicolore', // الحفاظ على الخط القديم إذا رغبت، أو تغييره
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Let's Go Again",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'louis',
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),

                  const SizedBox(height: 50),

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
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Login Details", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                            ),
                            const SizedBox(height: 25),

                            _buildTextFormField(
                              controller: controller.phoneController,
                              label: "Phone Number",
                              icon: Icons.phone_outlined,
                              inputType: TextInputType.phone,
                              validator: (val) {
                                if (val == null || val.isEmpty) return "Phone number is required";
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),

                            _buildTextFormField(
                              controller: controller.passwordController,
                              label: "Password",
                              icon: Icons.lock_outline,
                              isPassword: true,
                              validator: (val) {
                                if (val == null || val.isEmpty) return "Password is required";
                                return null;
                              },
                            ),
                            const SizedBox(height: 30),

                            Obx(() => _buildGoldButton(
                              label: "Login",
                              isLoading: controller.isLoading.value,
                              onTap: controller.isLoading.value
                                  ? () {}
                                  : () {
                                if (formState.currentState!.validate()) {
                                  controller.login();
                                }
                              },
                            )),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't Have An Account? ", style: TextStyle(color: Colors.white.withOpacity(0.7), fontFamily: 'louis')),
                      GestureDetector(
                        onTap: () {
                          Get.off(() => SignUpScreen());
                        },
                        child: const Text(
                          "Create Account",
                          style: TextStyle(
                            color: Color(0xFFD4AF37),
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            decorationColor: Color(0xFFD4AF37),
                            fontFamily: 'Louis',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ==========================================
// Helper Widgets (To keep UI consistent without external imports)
// ==========================================

class LuxeBackground extends StatelessWidget {
  final Widget child;
  const LuxeBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/Welcome.jpg',
            fit: BoxFit.cover,
          ),
        ),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFF0F172A).withOpacity(0.6),
                  const Color(0xFF0F172A).withOpacity(0.9),
                ],
              ),
            ),
          ),
        ),
        SafeArea(child: child),
      ],
    );
  }
}

Widget _buildTextFormField({
  required TextEditingController controller,
  required String label,
  required IconData icon,
  bool isPassword = false,
  TextInputType inputType = TextInputType.text,
  String? Function(String?)? validator,
}) {
  return TextFormField(
    controller: controller,
    obscureText: isPassword,
    keyboardType: inputType,
    validator: validator,
    style: const TextStyle(color: Colors.white),
    cursorColor: const Color(0xFFD4AF37),
    decoration: InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white70),
      prefixIcon: Icon(icon, color: const Color(0xFFD4AF37), size: 20),
      filled: true,
      fillColor: Colors.white.withOpacity(0.1),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFD4AF37), width: 1.5),
      ),
      errorStyle: const TextStyle(color: Colors.redAccent),
    ),
  );
}

Widget _buildGoldButton({required String label, required VoidCallback onTap, bool isLoading = false}) {
  return Container(
    width: double.infinity,
    height: 55,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      gradient: const LinearGradient(
        colors: [Color(0xFFD4AF37), Color(0xFFC5A028)],
      ),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFFD4AF37).withOpacity(0.3),
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: isLoading
          ? const CircularProgressIndicator(color: Colors.black, strokeWidth: 3)
          : Text(
        label,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontFamily: 'Multicolore',
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
        ),
      ),
    ),
  );
}