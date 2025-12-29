import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../Controller/ApartmentDetailsController.dart';
import '../../Model/apartment_model.dart';

class ApartmentDetailsScreen extends StatelessWidget {
  final Apartment apartment;

  ApartmentDetailsScreen({super.key, required this.apartment});

  final ApartmentDetailsController controller =
  Get.put(ApartmentDetailsController());

  static Widget _buildFeatureIcon(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey[500]),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey[700],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // Date picker function
  Future<void> _selectDates(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: now,
      lastDate: DateTime(2030),
      initialDateRange: controller.selectedDateRange.value,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).primaryColor,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      controller.updateDateRange(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('MMM dd, yyyy');

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image Gallery
                SizedBox(
                  height: 360,
                  child: PageView.builder(
                    itemCount: apartment.imageUrls.length,
                    itemBuilder: (context, index) {
                      return Image.network(
                        apartment.imageUrls[index],
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Container(
                              color: Colors.grey[300],
                              child: const Icon(Icons.error),
                            ),
                      );
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title and Location
                      Text(
                        apartment.title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "${apartment.province}, ${apartment.city}",
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Specs Row
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          gradient: Get.isDarkMode
                              ? const LinearGradient(
                            colors: [Color(0xff41394f), Color(0xff261f32)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                              : const LinearGradient(
                            colors: [
                              Color.fromARGB(245, 255, 255, 255),
                              Color.fromARGB(171, 255, 255, 255),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(21),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xc7846be7),
                              spreadRadius: 0.5,
                              blurRadius: 15,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildFeatureIcon(
                              Icons.bed_outlined,
                              "${apartment.beds} Beds",
                            ),
                            _buildFeatureIcon(
                              Icons.bathtub_outlined,
                              "${apartment.baths} Baths",
                            ),
                            _buildFeatureIcon(
                              Icons.square_foot_outlined,
                              "${apartment.area} m²",
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Description
                      const Text(
                        "Description",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),


                      const SizedBox(height: 10),

                      Text(
                        apartment.description,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[700],
                          height: 1.5,
                        ),
                      ),

                      const SizedBox(height: 25),

                      // Owner Info
                      const Text(
                        "Owner Information",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),


                      const SizedBox(height: 15),
                      // Owner Card (same as before)
                      Container(
                        height: 80,
                        width: 400,
                        decoration: BoxDecoration(
                          //dark mode
                          gradient: Get.isDarkMode
                              ? LinearGradient(
                            colors: [Color(0xff41394f), Color(0xff261f32)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                              : //light  mode
                          LinearGradient(
                            colors: [
                              Color.fromARGB(245, 255, 255, 255),
                              const Color.fromARGB(171, 255, 255, 255),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x7c846be7),
                              blurRadius: 30,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 35,
                                  backgroundImage: NetworkImage(
                                    apartment.ownerImageUrl,
                                  ),
                                  onBackgroundImageError: (_, _) =>
                                  const Icon(Icons.person),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        apartment.ownerName,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.deepPurpleAccent,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.phone,
                                            size: 20,
                                            // color: Colors.grey,
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            apartment.ownerPhone,
                                            // style: const TextStyle(color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {}, // Mock call action
                                  icon: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      // color: Colors.green[50],
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      size: 30,
                                      Icons.phone,
                                      color: Colors.deepPurpleAccent,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ),

                      const SizedBox(height: 30),

                      Divider(color: Colors.grey[300]),

                      const SizedBox(height: 20),

                      // --- Date Picker Section ---
                      const Text(
                        "Select Dates",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),
                      InkWell(
                        onTap: () => _selectDates(context),
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 20,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.calendar_today_outlined),
                                  const SizedBox(width: 12),
                                  Obx(() {
                                    final range =
                                        controller.selectedDateRange.value;
                                    return Text(
                                      range == null
                                          ? "Check-in  →  Check-out"
                                          : "${formatter.format(range.start)}  →  ${formatter.format(range.end)}",
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    );
                                  }),
                                ],
                              ),
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Calculation Summary
                      Obx(() {
                        if (controller.selectedDateRange.value == null) {
                          return const SizedBox();
                        }
                        final nights = controller.nights();
                        final totalPrice =
                        controller.totalPrice(apartment.price);
                        return Column(
                          children: [
                            const SizedBox(height: 20),
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.05),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("$nights nights x \$${apartment.price.toInt()}"),
                                      Text(
                                        "\$${totalPrice.toInt()}",
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Divider(color: Colors.grey[300]),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Total (USD)",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "\$${totalPrice.toInt()}",
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // --- Custom Back Button ---
          Positioned(
            top: 50,
            left: 20,
            child: GestureDetector(
              onTap: Get.back,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Get.isDarkMode
                      ? const Color.fromARGB(226, 54, 53, 53)
                      : Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xff846be7),
                      spreadRadius: 0.5,
                      blurRadius: 10,
                    ),
                  ],
                ),
                child:
                const Icon(Icons.arrow_back_ios_new, size: 20),
              ),
            ),
          ),

          Positioned(
            top: 50,
            right: 20,
            child: GestureDetector(
              onTap: (){

              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Get.isDarkMode
                      ? const Color.fromARGB(226, 54, 53, 53)
                      : Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xff846be7),
                      spreadRadius: 0.5,
                      blurRadius: 10,
                    ),
                  ],
                ),
                child:Icon(Icons.favorite_outline_sharp, size: 20),
                ),
              ),
            ),


          // --- Bottom Booking Bar ---
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Obx(() {
              final nights = controller.nights();
              final totalPrice = controller.totalPrice(apartment.price);
              return Container(
                padding: const EdgeInsets.all(20),
                child: Container(
                  height: 70,
                  decoration: BoxDecoration(
                    gradient: Get.isDarkMode
                        ? const LinearGradient(
                      colors: [Color(0xff41394f), Color(0xff261f32)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                        : const LinearGradient(
                      colors: [
                        Color.fromARGB(245, 255, 255, 255),
                        Color.fromARGB(171, 255, 255, 255),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(42),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xff846be7),
                        blurRadius: 30,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        // Price display
                        Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Price ",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Get.isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "\$${apartment.price.toInt()}",
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color: Get.isDarkMode
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "/night",
                                      style: TextStyle(
                                        color: Get.isDarkMode
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 20),

                        // Booking Button
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: ElevatedButton(
                              onPressed:
                              controller.selectedDateRange.value == null
                                  ? null
                                  : () {
                                Get.snackbar(
                                  "Booking confirmed",
                                  " for $nights nights! Total: \$${totalPrice.toInt()}",
                                  backgroundColor: const Color.fromARGB(
                                      132, 9, 245, 1),
                                  borderRadius: 30,
                                  maxWidth: 250,
                                  margin: const EdgeInsets.all(10),
                                  icon: const Icon(
                                    Icons.done_outline_sharp,
                                    size: 30,
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                elevation: 0,
                                disabledBackgroundColor:
                                const Color.fromARGB(68, 126, 126, 126),
                              ),
                              child: const Text(
                                "Book Now",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}






// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'HomePage.dart';
//
// class ApartmentDetailsScreen extends StatefulWidget {
//   final Apartment apartment;
//
//    ApartmentDetailsScreen({super.key, required this.apartment});
//
//   // Helper method exposed for reuse in ApartmentCard
//   static Widget _buildFeatureIcon(IconData icon, String label) {
//     return Row(
//       children: [
//         Icon(icon, size: 18, color: Colors.grey[500]),
//         const SizedBox(width: 6),
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: 13,
//             color: Colors.grey[700],
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ],
//     );
//   }
//
//   @override
//   State<ApartmentDetailsScreen> createState() => _ApartmentDetailsScreenState();
// }
//
//
// class _ApartmentDetailsScreenState extends State<ApartmentDetailsScreen> {
//   DateTimeRange? _selectedDateRange;
//
//   // Function to show date picker and update state
//   Future<void> _selectDates(BuildContext context) async {
//     final DateTime now = DateTime.now();
//     final DateTimeRange? picked = await showDateRangePicker(
//       context: context,
//       firstDate: now,
//       lastDate: DateTime(2030), // Allow booking up to 1 year ahead
//       initialDateRange: _selectedDateRange,
//       builder: (context, child) {
//         return Theme(
//           data: Theme.of(context).copyWith(
//             // colorScheme: ColorScheme.light(
//             //   primary: Theme.of(
//             //     context,
//             //   ).primaryColor, // Header background color
//             //   onPrimary: Colors.white, // Header text color
//             //   onSurface: Colors.black, // Body text color
//             // ),
//             textButtonTheme: TextButtonThemeData(
//               style: TextButton.styleFrom(
//                 foregroundColor: Theme.of(
//                   context,
//                 ).primaryColor, // Button text color
//               ),
//             ),
//           ),
//           child: child!,
//         );
//       },
//     );
//
//     if (picked != null && picked != _selectedDateRange) {
//       setState(() {
//         _selectedDateRange = picked;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final apartment = widget.apartment;
//     final int nights = _selectedDateRange?.duration.inDays ?? 0;
//     final double totalPrice = nights * apartment.price;
//     // Using intl package for formatting would be better, but simple approach for now:
//     // Make sure to add 'intl: ^0.18.1' (or newer) to your pubspec.yaml dependencies.
//     final DateFormat formatter = DateFormat('MMM dd, yyyy');
//
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Main Content scrollable
//           SingleChildScrollView(
//             padding: const EdgeInsets.only(bottom: 100), // Space for bottom bar
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // --- Image Gallery (PageView) ---
//                 SizedBox(
//                   height: 360,
//                   child: PageView.builder(
//                     itemCount: apartment.imageUrls.length,
//                     itemBuilder: (context, index) {
//                       return Image.network(
//                         apartment.imageUrls[index],
//                         fit: BoxFit.cover,
//                         errorBuilder: (context, error, stackTrace) => Container(
//                           color: Colors.grey[300],
//                           child: const Icon(Icons.error),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//
//                 Padding(
//                   padding: const EdgeInsets.all(20.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Title and Location
//                       Text(
//                         apartment.title,
//                         style: const TextStyle(
//                           fontSize: 24,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Row(
//                         children: [
//                           Icon(
//                             Icons.location_on,
//                             size: 16,
//                           ),
//                           const SizedBox(width: 4),
//                           Text(
//                             apartment.location,
//                             style: const TextStyle(
//                               color: Colors.grey,
//                               fontSize: 15,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 20),
//
//                       // --- Specs Row ---
//                       Container(
//                         padding: const EdgeInsets.all(16),
//                         decoration: BoxDecoration(
//                           //dark mode
//                           gradient: Get.isDarkMode
//                               ? LinearGradient(
//                             colors: [Color(0xff41394f), Color(0xff261f32)],
//                             begin: Alignment.topLeft,
//                             end: Alignment.bottomRight,
//                           )
//                               : //light  mode
//                           LinearGradient(
//                             colors: [
//                               Color.fromARGB(245, 255, 255, 255),
//                               const Color.fromARGB(171, 255, 255, 255),
//                             ],
//                             begin: Alignment.topLeft,
//                             end: Alignment.bottomRight,
//                           ),
//                           borderRadius: BorderRadius.circular(21),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Color.fromARGB(102, 133, 2, 255),
//                               spreadRadius: 0.5,
//                               blurRadius: 15,
//                               offset: const Offset(0, 6),
//                             ),
//                           ],
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             ApartmentDetailsScreen._buildFeatureIcon(
//                               Icons.bed_outlined,
//                               "${apartment.beds} Beds",
//                             ),
//                             ApartmentDetailsScreen._buildFeatureIcon(
//                               Icons.bathtub_outlined,
//                               "${apartment.baths} Baths",
//                             ),
//                             ApartmentDetailsScreen._buildFeatureIcon(
//                               Icons.square_foot_outlined,
//                               "${apartment.area} m²",
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//
//                       // --- Description ---
//                       const Text(
//                         "Description",
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       Text(
//                         apartment.description,
//                         style: TextStyle(
//                           fontSize: 15,
//                           color: Colors.grey[700],
//                           height: 1.5,
//                         ),
//                       ),
//                       const SizedBox(height: 25),
//
//                       // --- Owner Info ---
//                       const Text(
//                         "Owner Information",
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//
//
//                       const SizedBox(height: 15),
//                       Container(
//                         height: 80,
//                         width: 400,
//                         decoration: BoxDecoration(
//                           //dark mode
//                           gradient: Get.isDarkMode
//                               ? LinearGradient(
//                             colors: [Color(0xff41394f), Color(0xff261f32)],
//                             begin: Alignment.topLeft,
//                             end: Alignment.bottomRight,
//                           )
//                               : //light  mode
//                           LinearGradient(
//                             colors: [
//                               Color.fromARGB(245, 255, 255, 255),
//                               const Color.fromARGB(171, 255, 255, 255),
//                             ],
//                             begin: Alignment.topLeft,
//                             end: Alignment.bottomRight,
//                           ),
//                           borderRadius: BorderRadius.circular(50),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Color.fromARGB(84, 133, 2, 255),
//                               blurRadius: 30,
//                               offset: const Offset(0, 6),
//                             ),
//                           ],
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               CircleAvatar(
//                                 radius: 35,
//                                 backgroundImage: NetworkImage(
//                                   apartment.ownerImageUrl,
//                                 ),
//                                 onBackgroundImageError: (_, __) =>
//                                 const Icon(Icons.person),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.symmetric(vertical: 10),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     Text(
//                                       apartment.ownerName,
//                                       style: const TextStyle(
//                                         fontSize: 20,
//                                         color: Colors.deepPurpleAccent,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     const SizedBox(height: 5),
//                                     Row(
//                                       children: [
//                                         const Icon(
//                                           Icons.phone,
//                                           size: 20,
//                                           // color: Colors.grey,
//                                         ),
//                                         const SizedBox(width: 5),
//                                         Text(
//                                           apartment.ownerPhone,
//                                           // style: const TextStyle(color: Colors.grey),
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               IconButton(
//                                 onPressed: () {}, // Mock call action
//                                 icon: Container(
//                                   padding: const EdgeInsets.all(8),
//                                   decoration: BoxDecoration(
//                                     // color: Colors.green[50],
//                                     shape: BoxShape.circle,
//                                   ),
//                                   child: const Icon(
//                                     size: 30,
//                                     Icons.phone,
//                                     color: Colors.deepPurpleAccent,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 30),
//                       Divider(color: Colors.grey[300]),
//                       const SizedBox(height: 20),
//
//                       // --- Date Picker Section ---
//                       const Text(
//                         "Select Dates",
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 15),
//                       InkWell(
//                         onTap: () => _selectDates(context),
//                         borderRadius: BorderRadius.circular(12),
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(
//                             vertical: 16,
//                             horizontal: 20,
//                           ),
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.grey.shade300),
//                             borderRadius: BorderRadius.circular(24),
//                           ),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Row(
//                                 children: [
//                                   Icon(
//                                     Icons.calendar_today_outlined,
//                                     // color: Theme.of(context).primaryColor,
//                                   ),
//                                   const SizedBox(width: 12),
//                                   Text(
//                                     _selectedDateRange == null
//                                         ? "Check-in  →  Check-out"
//                                         : "${formatter.format(_selectedDateRange!.start)}  →  ${formatter.format(_selectedDateRange!.end)}",
//                                     style: TextStyle(
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.w500,
//                                       // color: _selectedDateRange == null
//                                       //     ? Colors.grey
//                                       //     : Colors.black87,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const Icon(
//                                 Icons.arrow_forward_ios,
//                                 size: 16,
//                                 color: Colors.grey,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//
//                       // Calculation Summary
//                       if (_selectedDateRange != null) ...[
//                         const SizedBox(height: 20),
//                         Container(
//                           padding: const EdgeInsets.all(16),
//                           decoration: BoxDecoration(
//                             color: Theme.of(
//                               context,
//                             ).primaryColor.withOpacity(0.05),
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: Column(
//                             children: [
//                               Row(
//                                 mainAxisAlignment:
//                                 MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     "$nights nights x \$${apartment.price.toInt()}",
//                                     style: const TextStyle(fontSize: 15),
//                                   ),
//                                   Text(
//                                     "\$${totalPrice.toInt()}",
//                                     style: const TextStyle(
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: 10),
//                               Divider(color: Colors.grey[300]),
//                               const SizedBox(height: 10),
//                               Row(
//                                 mainAxisAlignment:
//                                 MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   const Text(
//                                     "Total (USD)",
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   Text(
//                                     "\$${totalPrice.toInt()}",
//                                     style: TextStyle(
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.bold,
//                                       // color: Theme.of(context).primaryColor,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//           // --- Custom Back Button (Top Left) ---
//           Positioned(
//             top: 50,
//             left: 20,
//             child: GestureDetector(
//               onTap: Get.back,
//               child: Container(
//                 padding: const EdgeInsets.all(10),
//                 decoration:BoxDecoration(
//                   color: Get.isDarkMode
//                       ? const Color.fromARGB(226, 54, 53, 53)
//                       : Colors.white,
//                   shape: BoxShape.circle,
//                   boxShadow: [
//                     BoxShadow(
//                       color: Color.fromARGB(156, 133, 2, 255),
//                       spreadRadius: 0.5,
//                       blurRadius: 10,
//                     ),
//                   ],
//                 ),
//
//                 child: const Icon(Icons.arrow_back_ios_new, size: 20),
//               ),
//             ),
//           ),
//
//           // --- Bottom Booking Bar ---
//           Positioned(
//             bottom: 0,
//             left: 0,
//             right: 0,
//             child: Container(
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 // color: Colors.white,
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.05),
//                     blurRadius: 10,
//                     offset: const Offset(0, -5),
//                   ),
//                 ],
//               ),
//               child: Container(
//                 height: 70,
//                 decoration: BoxDecoration(
//                   //dark mode
//                   gradient: Get.isDarkMode
//                       ? LinearGradient(
//                     colors: [Color(0xff41394f), Color(0xff261f32)],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   )
//                       : //light  mode
//                   LinearGradient(
//                     colors: [
//                       Color.fromARGB(245, 255, 255, 255),
//                       const Color.fromARGB(171, 255, 255, 255),
//                     ],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                   borderRadius: BorderRadius.circular(42),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Color.fromARGB(119, 133, 2, 255),
//                       blurRadius: 30,
//                       offset: const Offset(0, 6),
//                     ),
//                   ],
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: Row(
//                     children: [
//                       // Price display on the left
//                       Padding(
//                         padding: const EdgeInsets.only(left: 12),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                              Text(
//                               "Price ",
//                               style: TextStyle( fontSize: 15 ,
//                                 color: Get.isDarkMode ? Colors.white : Colors.black,
//                               ),
//                             ),
//                             RichText(
//                               text: TextSpan(
//                                 children: [
//                                   TextSpan(
//                                     text: "\$${apartment.price.toInt()}",
//                                     style: TextStyle(
//                                       fontSize: 25,
//                                       fontWeight: FontWeight.bold,
//                                       color: Get.isDarkMode ? Colors.white : Colors.black,
//                                     ),
//                                   ),
//                                   TextSpan(
//                                     text: "/night",
//                                     style: TextStyle(
//                                       color: Get.isDarkMode ? Colors.white : Colors.black,
//                                     )
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//
//
//                       const SizedBox(width: 20),
//
//
//                       // Booking Button
//                       Expanded(
//                         child: SizedBox(
//                           height: 50,
//                           child: ElevatedButton(
//                             onPressed: _selectedDateRange == null
//                                 ? null // Disable if no dates selected
//                                 : () {
//                               // Show confirmation message
//                               Get.snackbar("Booking confirmed",  " for $nights nights! Total: \$${totalPrice.toInt()}",
//
//                                 backgroundColor:Color.fromARGB(
//                                     132, 9, 245, 1),
//                                 borderRadius: 30,
//                                 maxWidth: 250,
//                                 margin: EdgeInsets.all(10),
//                                 icon: Icon(Icons.done_outline_sharp,size: 30,)
//                               );
//
//                             },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Theme.of(context).primaryColor,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(24),
//                               ),
//                               elevation: 0,
//                               disabledBackgroundColor: Color.fromARGB(
//                                   68, 126, 126, 126),
//                             ),
//                             child: const Text(
//                               "Book Now",
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
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
// }
//
