import 'dart:ui';

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
                                  Color(0xe28443fd),
                                  Color(0xff9d05e8).withOpacity(0.9),
                                  Color(0xfff9c37f).withOpacity(0.7),
                                  Color(0xfffd6f80).withOpacity(0.5),
                                  // Color(0xffdc85b4),
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

                  //Picture
                  Flexible(child: SvgPicture.asset('assets/chat.svg')),

                  Padding(
                    padding: const EdgeInsets.all(22.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.04),
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                                color: Colors.white.withOpacity(0.1)),
                          ),
                          child: Column(
                            spacing: 10,
                            children: [
                              _buildGoldButton(
                                label: 'LOGIN',
                                onTap: () {
                                  Get.off(() => LoginScreen());
                                },
                              ),
                              _buildGlassButton(
                                label: 'SIGN UP',
                                onTap: () {
                                  Get.off(() => SignUpScreen());
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  // //Button
                  // // Login Button
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 30),
                  //   child: SizedBox(
                  //     width: 300,
                  //     height: 50,
                  //     child: ElevatedButton(
                  //       onPressed: () {
                  //         Get.off(() => LoginScreen());
                  //       },
                  //       child: Text(
                  //         'Login',
                  //         style: TextStyle(
                  //           fontSize: 20,
                  //           fontFamily: 'Multicolore',
                  //           fontWeight: FontWeight.bold,
                  //           letterSpacing: 2,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // //
                  // //Sign In Button
                  // SizedBox(
                  //   width: 300,
                  //   height: 50,
                  //   child: OutlinedButton(
                  //     onPressed: () {
                  //       Get.off(() => SignUpScreen());
                  //     },
                  //     style: OutlinedButton.styleFrom(
                  //       side: const BorderSide(color: Colors.white, width: 2),
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(50),
                  //       ),
                  //     ),
                  //     child: Text(
                  //       'Sign Up',
                  //       style: TextStyle(
                  //         color: Colors.white,
                  //         fontSize: 20,
                  //         fontFamily: 'Multicolore',
                  //         fontWeight: FontWeight.bold,
                  //         letterSpacing: 2,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:uni_project/View/Screens/LoginScreen.dart';
// import 'package:uni_project/View/Screens/SignIUpScreen.dart';
//
// class WelcomeScreen extends StatefulWidget {
//   const WelcomeScreen({super.key});
//
//   @override
//   State<WelcomeScreen> createState() => _WelcomeScreenState();
// }
// class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _fadeAnimation;
//   late Animation<Offset> _slideAnimation;
//
//   final Color _primaryGold = const Color(0xFFA151E3);
//   final Color _darkOverlay = const Color(0xFF8B5AC5);
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1500),
//     );
//
//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeIn),
//     );
//
//     _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
//     );
//
//     _controller.forward();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         fit: StackFit.expand,
//         children: [
//           Image.asset(
//             'assets/Welcome.jpg',
//             height: double.infinity,
//             width: double.infinity,
//             fit: BoxFit.cover,
//           ),
//
//           Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [
//                   _darkOverlay.withOpacity(0.3),
//                   _darkOverlay.withOpacity(0.8),
//                   _darkOverlay,
//                 ],
//               ),
//             ),
//           ),
//
//           SafeArea(
//             child: FadeTransition(
//               opacity: _fadeAnimation,
//               child: SlideTransition(
//                 position: _slideAnimation,
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 24.0),
//                   child: Column(
//                     children: [
//                       const Spacer(flex: 2),
//
//                       Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Container(
//                             padding: const EdgeInsets.all(20),
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: Colors.white.withOpacity(0.05),
//                               border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.white.withOpacity(0.2),
//                                   blurRadius: 20,
//                                   spreadRadius: 5,
//                                 ),
//                               ],
//                             ),
//                             child: ShaderMask(
//                               shaderCallback: (bounds) =>
//                                   LinearGradient(
//                                     colors: [
//                                       Color(0xff4805b0),
//                                       Color(0xff9d05e8),
//                                       Color(0xffc450e0),
//                                       Color(0xffeed5a0),
//                                       Color(0xffeed5a0),
//                                     ],
//                                     begin: Alignment.centerLeft,
//                                     end: Alignment.centerRight,
//                                   ).createShader(bounds),
//                               child: const Icon(
//                                   Icons.real_estate_agent_rounded, size: 120,
//                                   color: Color(
//                                       0xFFA516E4)),
//                             ),
//                           ),
//                           const SizedBox(height: 25),
//
//                           ShaderMask(
//                             shaderCallback: (bounds) => LinearGradient(
//                               colors: [
//                                 Color(0xff4805b0),
//                                 Color(0xff9d05e8),
//                                 Color(0xffc450e0),
//                               ],
//                               begin: Alignment.topLeft,
//                               end: Alignment.bottomRight,
//                             ).createShader(bounds),
//                             child: const Text(
//                               "LUXESTAY",
//                               style: TextStyle(
//                                 fontFamily: 'Virust',
//                                 letterSpacing: 6,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 42,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//
//
//                           const SizedBox(height: 12),
//
//                           Text(
//                             'Your Key to Luxury Living',
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               fontFamily: 'Louis',
//                               color: Colors.white.withOpacity(0.8),
//                               fontSize: 18,
//                               letterSpacing: 1.2,
//                             ),
//                           ),
//                         ],
//                       ),
//
//                       const Spacer(flex: 3),
//
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(24),
//                         child: BackdropFilter(
//                           filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//                           child: Container(
//                             width: double.infinity,
//                             padding: const EdgeInsets.all(30),
//                             decoration: BoxDecoration(
//                               color: Colors.white.withOpacity(0.05), // نفس شفافية Login
//                               borderRadius: BorderRadius.circular(24),
//                               border: Border.all(color: Colors.white.withOpacity(0.1)),
//                             ),
//                             child: Column(
//                               children: [
//                                 _buildGoldButton(
//                                   label: 'LOGIN',
//                                   onTap: () {
//                                     Get.off(() => LoginScreen());
//                                   },
//                                 ),
//
//                                 const SizedBox(height: 20),
//
//                                 _buildGlassButton(
//                                   label: 'SIGN UP',
//                                   onTap: () {
//                                     Get.off(() => SignUpScreen());
//                                   },
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 30),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
// }
  Widget _buildGoldButton({required String label, required VoidCallback onTap}) {
    return Container(
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
            color: Color(0xFFA151E3).withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: 'Multicolore',
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
      ),
    );
  }

  Widget _buildGlassButton({required String label, required VoidCallback onTap}) {
    return Container(
      width: double.infinity,
      height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.white.withOpacity(0.1),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'Multicolore',
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
        ),
      ),
    );
  }
