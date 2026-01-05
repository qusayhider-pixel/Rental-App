import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uni_project/Controller/BookingController.dart';
import 'package:uni_project/Controller/FilterController.dart';

import '../../Controller/ApartmentDetailsController.dart';
import '../../Model/apartment_model.dart';
import '../Components/ApartmentBookingCalender.dart';

class ApartmentDetailsScreen extends StatelessWidget {
  final Apartment apartment;

  ApartmentDetailsScreen({super.key, required this.apartment});

  final ApartmentDetailsController apartmentController = Get.find();
  final FilterController filterController = Get.find();
  final BookingController bookingController = Get.find();

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
                      return filterController.isLoading.value
                          ? CircularProgressIndicator(
                              strokeWidth: 3,
                              color: Colors.deepPurpleAccent,
                            )
                          : Image.network(
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
                          const Icon(Icons.location_on, size: 16),
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
                                  colors: [
                                    Color(0xff41394f),
                                    Color(0xff261f32),
                                  ],
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
                                  colors: [
                                    Color(0xff41394f),
                                    Color(0xff261f32),
                                  ],
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
                                  "http://10.0.2.2:8000/storage/${apartment.ownerImageUrl}",
                                ),
                                onBackgroundImageError: (_, _) =>
                                    const Icon(Icons.person),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
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
                                          "+${apartment.ownerPhone}",
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
                                    Icons.message_outlined,
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
                        // onTap: () => _selectDates(context),
                        onTap: () => showBookingCalendar(),

                        //<==use the new calender here
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
                                    final range = apartmentController
                                        .selectedDateRange
                                        .value;
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
                        if (apartmentController.selectedDateRange.value ==
                            null) {
                          return const SizedBox();
                        }
                        final nights = apartmentController.nights() + 1;
                        final totalPrice = nights * apartment.price;
                        return Column(
                          children: [
                            const SizedBox(height: 20),
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Theme.of(
                                  context,
                                ).primaryColor.withOpacity(0.05),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "$nights nights x \$${apartment.price.toInt()}",
                                      ),
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
                child: const Icon(Icons.arrow_back_ios_new, size: 20),
              ),
            ),
          ),

          Positioned(
            top: 50,
            right: 20,
            child: Obx(
              () => GestureDetector(
                onTap: () {
                  apartmentController.addToFav(apartment);
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
                  child: Icon(
                    apartment.isFav.value
                        ? Icons.favorite
                        : Icons.favorite_outline_sharp,
                    size: 20,
                    color: apartment.isFav.value
                        ? Colors.red
                        : Color(0xff846be7),
                  ),
                ),
              ),
            ),
          ),

          // --- Bottom Booking Bar ---
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Obx(() {
              final nights = apartmentController.nights() + 1;
              final totalPrice = nights * apartment.price;
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
                              apartmentController.selectedDateRange.value ==
                                      null
                                  ? RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text:
                                                "\$${apartment.price.toInt()}",
                                            style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                              color: Get.isDarkMode
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          ),
                                          TextSpan(
                                            text: "/per night",
                                            style: TextStyle(
                                              color: Get.isDarkMode
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: "\$${totalPrice.toInt()}",
                                            style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                              color: Get.isDarkMode
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          ),
                                          TextSpan(
                                            text: "/per $nights night",
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
                            child: Obx(
                              () => ElevatedButton(
                                onPressed:
                                    bookingController.requestStatus ==
                                            'pending' ||
                                        apartmentController
                                                .selectedDateRange
                                                .value ==
                                            null ||
                                        bookingController.isLoading.value
                                    ? null
                                    : () {
                                        bookingController.getBookingId(
                                          apartment.id,
                                        );
                                        if (bookingController.requestId.value !=
                                            0) {
                                          Get.snackbar(
                                            "Your Booking : ",
                                            " Bending for Owner Approval \n for ${nights + 1} nights! Total: \$${totalPrice.toInt()}",
                                            backgroundColor:
                                                const Color.fromARGB(
                                                  132,
                                                  9,
                                                  245,
                                                  1,
                                                ),
                                            borderRadius: 30,
                                            maxWidth: 250,
                                            margin: const EdgeInsets.all(10),
                                            icon: const Icon(
                                              Icons.done_outline_sharp,
                                              size: 30,
                                            ),
                                          );
                                        }
                                      },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(
                                    context,
                                  ).primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  elevation: 0,
                                  disabledBackgroundColor: const Color.fromARGB(
                                    68,
                                    126,
                                    126,
                                    126,
                                  ),
                                ),
                                child: bookingController.requestId.value != 0
                                    ? Text(
                                        bookingController.requestStatus.value,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    : Text(
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

  // Date picker function
  void showBookingCalendar() async {
    await apartmentController.fetchBookings(apartment.id);
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: SizedBox(height: 420, child: ApartmentBookingCalendar()),
      ),
    );
  }

}
