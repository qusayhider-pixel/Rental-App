import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_project/Controller/ProfileController.dart';

class Profilescreen extends StatelessWidget {
  Profilescreen({super.key});

  final controller = Get.find<ProfileController>();
  RxBool isOpen = false.obs;

  @override
  build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          "My Profile",
          style: TextStyle(
            letterSpacing: 2,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'Multicolore',
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: Get.isDarkMode
                    ? [
                  const Color(0xff7f3aa1),
                  const Color(0xff5716b5),
                  const Color(0xff150b52),
                  const Color(0xff190019),
                ]
                    : [
                  const Color(0xffdfb6b2),
                  const Color(0xff9d5e80),
                  const Color(0xff7f3aa1),
                  const Color(0xff5416b5),
                ],
              ),
            ),
          ),

          Center(
            child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24, vertical: 80),
                child: Obx(() =>
                controller.isLoading.value ? CircularProgressIndicator(
                  color: Color(0xffdc9efc),) : Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 30),
                decoration: BoxDecoration(
                  color: const Color(0x25ffffff),
                  border: Border.all(
                      color: Colors.white.withOpacity(0.4), width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 30,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: CircleAvatar(
                            radius: 70,
                            backgroundImage: controller.profile.value?.avatar !=
                                null
                                ? NetworkImage(
                              "http://10.0.2.2:8000/storage/${controller.profile
                                  .value!.avatar}",
                            )
                                : null,
                            child: controller.profile.value?.avatar == null
                                ? const Icon(Icons.person)
                                : null,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            print('show');
                            _showAvatar();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.camera_alt_outlined,
                              size: 20,
                              color: Color(0xff5716b5),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // --- 2. Name Section ---
                    Text(
                      controller.profile.value!.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontFamily: 'Louis',
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),

                    const SizedBox(height: 24),


                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildStatItem(
                              label: "Owned Apartments",
                              value: "${controller.profile.value!
                                  .numberOfProperties}",
                            ),

                            VerticalDivider(
                              color: Colors.white.withOpacity(0.3),
                              thickness: 1,
                              width: 30,
                            ),

                            _buildStatItem(
                              label: "Rented Apartments",
                              value: "${controller.profile.value!
                                  .numberOfReservations}",
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),
                    const Divider(color: Colors.white24),
                    const SizedBox(height: 16),

                    // --- 4. Personal Info List ---
                    _buildInfoRow(
                      icon: Icons.calendar_month_rounded,
                      label: "Date of Birth",
                      value: controller.profile.value!
                          .dateOfBirth,
                    ),

                    const SizedBox(height: 12),

                    _buildInfoRow(
                        icon: Icons.phone_android_rounded,
                        label: "Phone Number",
                        value: controller.profile.value!.phone != null
                            ? "+${controller.profile.value!.phone}"
                            : ""
                    ),
                  ],
                ),
                ),)
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({required String label, required String value}) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            fontFamily: 'Louis',
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(
      {required IconData icon, required String label, required String value}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Louis',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<dynamic> _showAvatar() {
    return Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(500),
        ),
        child: Container(
          height: 300,
          width: 300,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(500),
              boxShadow: [
                BoxShadow(color: Colors.white.withOpacity(0.2),
                    spreadRadius: 20,
                    blurRadius: 30)
              ]

          ),
          child: Expanded(
            child: BackdropFilter(
                filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5)
                , child: CircleAvatar(
              radius: 70,
              backgroundImage: controller.profile.value
                  ?.avatar !=
                  null
                  ? NetworkImage(
                "http://10.0.2.2:8000/storage/${controller
                    .profile
                    .value!.avatar}",
              )
                  : null,
              child: controller.profile.value?.avatar == null
                  ? const Icon(Icons.person)
                  : null,
            )),
          ),
        ),

      ),
    );
  }
// return BackdropFilter(
//     filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5)
//     , child: CircleAvatar(
//   radius: 70,
//   backgroundImage: controller.profile.value
//       ?.avatar !=
//       null
//       ? NetworkImage(
//     "http://10.0.2.2:8000/storage/${controller
//         .profile
//         .value!.avatar}",
//   )
//       : null,
//   child: controller.profile.value?.avatar == null
//       ? const Icon(Icons.person)
//       : null,
// ));
}


// import '../../Controller/AuthController.dart';
//
// class Profilescreen extends StatelessWidget {
//   const Profilescreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final auth = Get.find<AuthController>();
//
//     final user = auth.user.value;
//     if (user == null) {}
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         title: Text(
//           "My Profile",
//           style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//             fontFamily: 'Multicolore',
//             fontSize: 18,
//           ),
//         ),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         centerTitle: true,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
//           onPressed: () {
//             Get.back();
//           },
//         ),
//       ),
//       body: Stack(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.bottomLeft,
//                 end: Alignment.topRight,
//                 colors: Get.isDarkMode
//                     ? [
//                         Color(0xff7f3aa1),
//                         Color(0xff5716b5),
//                         Color(0xff150b52),
//                         Color(0xff190019),
//                       ]
//                     : [
//                         Color(0xffdfb6b2),
//                         Color(0xff9d5e80),
//                         Color(0xff7f3aa1),
//                         Color(0xff5416b5),
//                       ],
//               ),
//             ),
//           ),
//           Center(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(
//                 vertical: 200,
//                 horizontal: 30,
//               ),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Color(0x3dffffff),
//                   border: BoxBorder.all(color: Colors.white, width: 2),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Color(0x7b8374c4),
//                       spreadRadius: 2,
//                       blurRadius: 30,
//                     ),
//                   ],
//                   borderRadius: BorderRadius.circular(44),
//                 ),
//                 width: 400,
//                 child: Column(
//                   spacing: 15,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     // Padding(
//                     //   padding: const EdgeInsets.only(left: 26),
//                     //   child: Align(
//                     //     alignment: AlignmentGeometry.topLeft,
//                     //     child: CircleAvatar(
//                     //       backgroundColor: Color(0xC0FFFFFF),
//                     //       radius: 18,
//                     //     ),
//                     //   ),
//                     // ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Stack(
//                         children: [
//                           Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(500),
//                               border: Border.all(color: Colors.white, width: 2),
//                             ),
//                             child: CircleAvatar(
//                               radius: 130,
//                               backgroundImage: user?.avatar != null
//                                   ? NetworkImage(
//                                       "http://10.0.2.2:8000/storage/${user!.avatar}",
//                                     )
//                                   : null,
//                               child: user?.avatar == null
//                                   ? const Icon(Icons.person)
//                                   : null,
//                             ),
//                           ),
//
//                           Positioned(
//                             bottom: 9,
//                             left: 9,
//                             right: 9,
//                             child: GestureDetector(
//                               onTap: () {
//                                 print('to do ');
//                               },
//                               child: Icon(
//                                 Icons.camera_alt_outlined,
//                                 size: 30,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Wrap(
//                         alignment: WrapAlignment.center,
//                         crossAxisAlignment: WrapCrossAlignment.center,
//                         spacing: 8,
//                         children: [
//                           // Icon(Icons.person, size: 30, color: Colors.white),
//                           Text(
//                             "${user?.firstname} ${user?.lastname} ",
//                             style: const TextStyle(
//                               color: Colors.white,
//                               fontSize: 41,
//                               fontFamily: 'Louis',
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       spacing: 8,
//                       children: [
//                         Icon(Icons.phone, size: 30, color: Colors.white),
//                         Text(
//                           "+${user?.phone}",
//                           style: TextStyle(
//                             color: Colors.white70,
//                             fontFamily: 'Louis',
//                             fontSize: 22,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
