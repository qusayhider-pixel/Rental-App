import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_project/Model/Reservation_model.dart';
import 'package:uni_project/View/Components/ApartmentBookingCalender.dart';

import '../../Controller/MyReservationsController.dart';

class MyReservationsScreen extends StatelessWidget {
  MyReservationsScreen({super.key});

  final MyReservationsController controller = Get.find();
  RxBool isOpen = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.isDarkMode ? Color(0xFF151515) : Colors.white,
        centerTitle: true,
        title: const Text("My Reservations"),
        titleTextStyle: TextStyle(
          fontFamily: 'Multicolore',
          color: Get.isDarkMode ? Colors.white : Colors.black,
          fontSize: 20,
        ),
        actions: [
          IconButton(
            onPressed: () {
              isOpen.value = !isOpen.value;
            }
            ,
            icon: Icon(Icons.filter_list),
            // icon: Icon(Icons.youtube_searched_for_outlined),
          ),
        ],
      ),
      body: Obx(() {
        return controller.isLoading.value
            ? Center(child: const CircularProgressIndicator(strokeWidth: 3))
            : controller.myReservation.isEmpty
            ? Center(child: Text("No Reservations !"))
            : Stack(
                children: [

                  Padding(
                    padding: EdgeInsets.only(top: 0),
                    child: Obx(() =>
                        ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: controller.myReservationFiltered.length,
                          itemBuilder: (context, index) {
                            final booking = controller
                                .myReservationFiltered[index];

                            return Card(
                              margin: const EdgeInsets.only(bottom: 20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                              shadowColor: const Color(0xff7852ff),
                              elevation: 5,
                              clipBehavior: Clip.antiAlias,
                              child: Column(
                                children: [
                                  ///////////////// => Top Section
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xfff6c9c5).withOpacity(0.8),
                                          Color(0xffdc85b4).withOpacity(0.8),
                                          Color(0xffae4fdc).withOpacity(0.8),
                                          Color(0xff6918e8).withOpacity(0.8),
                                        ],
                                      ),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color(0xff60519b),
                                          // spreadRadius: 2,
                                          blurRadius: 30,
                                          offset: Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Wrap(
                                        alignment: WrapAlignment.spaceAround,
                                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: 250,
                                            child: Text(
                                              booking.propertyTitle,
                                              style: const TextStyle(
                                                fontFamily: "Louis",
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 4,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.teal,
                                              borderRadius: BorderRadius
                                                  .circular(
                                                  28),
                                            ),
                                            child: Text(
                                              "\$${(booking.bookingPrice)}",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  ///////////////// => Middle Section
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      children: [
                                        //////////////// => Duration
                                        Row(
                                          children: [
                                            Expanded(
                                              child: _buildDateBox(
                                                "Check-in",
                                                booking.startDate,
                                              ),
                                            ),
                                            const Icon(
                                              Icons.arrow_forward,
                                              color: Colors.grey,
                                            ),
                                            Expanded(
                                              child: _buildDateBox(
                                                "Check-out",
                                                booking.endDate,
                                              ),
                                            ),
                                          ],
                                        ),

                                        const Divider(
                                          height: 30,
                                          indent: 30,
                                          endIndent: 30,
                                        ),

                                        //////////////// => Owner Info
                                        Row(
                                          mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                          // crossAxisAlignment: WrapCrossAlignment.center,
                                          spacing: 20,
                                          children: [
                                            CircleAvatar(
                                              radius: 25,
                                              backgroundColor: Colors.teal,
                                              backgroundImage: NetworkImage(
                                                "http://10.0.2.2:8000/${booking
                                                    .ownerPhoto}",
                                              ),
                                              onBackgroundImageError: (_, _) =>
                                            const Icon(Icons.person),
                                            ),

                                            Column(
                                              spacing: 5,
                                              crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Owner: ${booking.ownerName}",
                                                  style: const TextStyle(
                                                    fontFamily: "Louis",
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.phone,
                                                      size: 15,
                                                      color: Colors.grey,
                                                    ),
                                                    Text(
                                                      ": ${booking.ownerPhone}",
                                                      style: const TextStyle(
                                                        fontFamily: "Louis",

                                                        color: Colors.grey,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),

                                            _buildStatusBadge(
                                                booking.bookingStatusCheck),
                                          ],
                                        ),
                                        // const Divider(height: 30, indent: 30, endIndent: 30),
                                        // const SizedBox(height: 20),

                                        //////////////// => Rating Stars
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .center,
                                          children: List.generate(
                                              5, (starIndex) {
                                            return IconButton(
                                                icon: Icon(
                                                  starIndex <
                                                      booking.rating.toInt()
                                                      ? Icons.star
                                                      : Icons.star_border,
                                                  color: Colors.amber,
                                                  size: 30,
                                                ),
                                                onPressed: () {
                                                  controller.rateBooking(
                                                      booking, starIndex + 1);
                                                }
                                            );
                                          }),
                                        ),

                                        const Text(
                                          "Rate this stay",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                          ),
                                        ),

                                        const SizedBox(height: 20),

                                        //////////////// => Edit & Delete
                                        if (booking.bookingStatusCheck ==
                                            'pending')
                                          if (booking.isCanceled.value == false)
                                            Row(
                                              mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                              children: [
                                                TextButton.icon(
                                                  onPressed: () =>
                                                  {
                                                    showBookingCalendar(
                                                      controller,
                                                      booking,
                                                    ),
                                                  },
                                                  icon: const Icon(
                                                    Icons.edit_calendar,
                                                    size: 18,
                                                  ),
                                                  label: const Text(
                                                      "Edit Dates"),
                                                ),

                                                OutlinedButton.icon(
                                                  onPressed: () =>
                                                      controller
                                                          .updateStatus(
                                                          booking),
                                                  style: OutlinedButton
                                                      .styleFrom(
                                                    foregroundColor: Colors.red,
                                                    side: const BorderSide(
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                  icon: const Icon(
                                                    Icons.cancel_outlined,
                                                    size: 18,
                                                  ),
                                                  label: const Text(
                                                      "Cancel Booking"),
                                                ),
                                              ],
                                            ),
                                        // else                                               //Note: you need to store the [isCanceled] in api
                                        //   Container(
                                        //     width: double.infinity,
                                        //     padding: const EdgeInsets.all(10),
                                        //     decoration: BoxDecoration(
                                        //       color: Colors.red,
                                        //       borderRadius: BorderRadius.circular(24),
                                        //     ),
                                        //     child: Text("You Have Canceled this Booking!",
                                        //       textAlign: TextAlign.center,
                                        //       style: TextStyle(
                                        //         color: Colors.white,
                                        //         fontWeight: FontWeight.bold,
                                        //       ),
                                        //     ),
                                        //   ),
                                        // if(booking.bookingStatusCheck == 'canceled')
                                        //   if(booking.isCanceled.value == true)
                                        //     Container(
                                        //       width: double.infinity,
                                        //       padding: const EdgeInsets.all(10),
                                        //       decoration: BoxDecoration(
                                        //         color: Colors.red,
                                        //         borderRadius: BorderRadius.circular(24),
                                        //       ),
                                        //       child: Text("You Have Canceled this Booking!",
                                        //         textAlign: TextAlign.center,
                                        //         style: TextStyle(
                                        //           color: Colors.white,
                                        //           fontWeight: FontWeight.bold,
                                        //         ),
                                        //       ),
                                        //     )
                                        //   else
                                        //     Container(
                                        //       width: double.infinity,
                                        //       padding: const EdgeInsets.all(10),
                                        //       decoration: BoxDecoration(
                                        //         color: Colors.red,
                                        //         borderRadius: BorderRadius.circular(24),
                                        //       ),
                                        //       child: Text(
                                        //         "The Owner Rejected this Booking!",
                                        //         textAlign: TextAlign.center,
                                        //         style: TextStyle(
                                        //           color: Colors.white,
                                        //           fontWeight: FontWeight.bold,
                                        //         ),
                                        //       ),
                                        //     ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                    ),
                  ),
                  Obx(() {
                    return AnimatedPositioned(
                        duration: const Duration(seconds: 1),
                        curve: Curves.easeInOutExpo,
                        // top: isOpen.value ? -10 : -80,
                        bottom: isOpen.value ? 10 : -80,
                        left: 0,
                        right: 0,
                        // left: isOpen.value ? 10 : -500,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: ClipRRect(
                            borderRadius: BorderRadiusGeometry.circular(50),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xff6918e8).withOpacity(0.2),
                                      Color(0xffae4fdc).withOpacity(0.2),
                                      Color(0xffdc85b4).withOpacity(0.2),
                                    ],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xbbffffff).withOpacity(0.3),
                                      blurRadius: 30,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    spacing: 5,
                                    children: [
                                      _buildFilterBottom('All'),
                                      _buildFilterBottom('Pending'),
                                      _buildFilterBottom('Completed'),
                                      _buildFilterBottom('Canceled'),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ));
                  }
                  ),


                ],
              );
      }),
    );
  }

  void showBookingCalendar(MyReservationsController c, MyReservations booking) {
    Get.defaultDialog(
      title: "Notice!",
      middleText: "You're Changing the Duration of this Booking !",
      textConfirm: "CONFIRM",
      titleStyle: TextStyle(color: Colors.white, fontFamily: 'Multicolore'),
      titlePadding: EdgeInsets.symmetric(vertical: 20),
      cancelTextColor: Colors.white,
      buttonColor: Colors.white,
      textCancel: "Cancel",
      middleTextStyle: TextStyle(color: Colors.white, fontSize: 15),
      backgroundColor: Color.fromARGB(194, 171, 92, 255),
      confirmTextColor: Color.fromARGB(255, 99, 86, 153),
      onConfirm: () async {
        Get.back();
        await c.fetchOtherBookings(booking.apartmentId, booking.id);
        Get.dialog(
          Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: SizedBox(
              height: 500,
              child: Column(
                children: [

                  Expanded(
                    child: ApartmentBookingCalendar(controller: controller),
                  ),

                  Divider(),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            controller.selectedRange.value = null;
                            Get.back();
                          },
                          child: Text(
                            'Cancel',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),

                        SizedBox(width: 16),

                        ElevatedButton(
                          onPressed: () {
                            final selectedRange = controller.selectedRange
                                .value;
                            c.editDates(booking.id);

                            if (selectedRange != null) {
                              print('Selected Range: ${selectedRange
                                  .start} - ${selectedRange.end}');
                            }
                            Get.back();
                            controller.fetchingMyReservations();
                          },
                          child: Text('Submit'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      radius: 24,
    );
  }

  Widget _buildFilterBottom(String status) {
    Color color;
    switch (status) {
      case 'Completed':
        color = Colors.green;
        break;
      case 'Canceled':
        color = Colors.red;
        break;
      case 'Pending':
        color = Colors.orangeAccent;
        break;
      default:
        color = Colors.blueGrey;
    }

    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: color.withOpacity(0.8),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: color, width: 2),
      ),
      child:
      TextButton(
        onPressed: () {
          controller.filter.value = status.toLowerCase();
          if (status == 'All') {
            controller.resetFilters();
          } else {
            controller.applyFilters();
          }
          isOpen(false);
        },
        child: Text(
          status,
          style: TextStyle(
            fontFamily: 'Louis',
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color color;
    IconData icon;
    switch (status) {
      case 'completed':
        color = Colors.green;
        icon = Icons.done_outline_rounded;

        break;
      case 'canceled':
        color = Colors.red;
        icon = Icons.cancel;
        break;
      default:
        color = Colors.blueGrey;
        icon = Icons.timer;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: color.withOpacity(0.8)),
      ),
      child: Icon(icon, color: color, size: 30),
    );
  }

  Widget _buildDateBox(String label, String date) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
            fontFamily: "Louis",
          ),
        ),
        Text(
          date,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
      ],
    );
  }


}






