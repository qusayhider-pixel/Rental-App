import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_project/Controller/ReservationController.dart';
import 'package:uni_project/Services/api_service.dart';

class ReservationManagementScreen extends StatelessWidget {
  ReservationManagementScreen({super.key});

  final ReservationController controller = Get.find();
  RxBool isOpen = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(" Reservation Management"),
        actions: [
          IconButton(
            onPressed: () {
              isOpen.value = !isOpen.value;
            },
            icon: Icon(Icons.filter_list),
          ),
        ],
      ),
      body: Obx(() {
        return controller.isLoading.value
            ? Center(child: const CircularProgressIndicator(strokeWidth: 3))
            : controller.reservationRequest.isEmpty
            ? Center(child: Text("No Reservations Requests"))
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: controller.reservationRequest.length,
                itemBuilder: (context, index) {
                  final req = controller.reservationRequest[index];
                  Color shadowColor = req.bookingStatusCheck == 'completed'
                      ? Colors.green
                      : req.bookingStatusCheck == 'canceled'
                      ? Colors.red
                      : Colors.blueGrey;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 40),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      gradient: Get.isDarkMode
                          ? LinearGradient(
                              colors: [
                                Color(0xff7f3aa1).withOpacity(0.5),
                                Color(0xff5416b5).withOpacity(0.4),
                                Color(0xff150b52).withOpacity(0.4),
                                Color(0xff0c0516).withOpacity(0.4),
                                Color(0xff190019).withOpacity(0.3),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            )
                          : LinearGradient(
                              colors: [
                                Color(0xfff6c9c5).withOpacity(0.1),
                                Color(0xfff6c9c5).withOpacity(0.4),
                                Color(0xffae4fdc).withOpacity(0.4),
                                Color(0xff6918e8).withOpacity(0.4),
                              ],
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                            ),
                      boxShadow: [
                        BoxShadow(
                          color: shadowColor.withOpacity(0.6),
                          spreadRadius: 0.3,
                          blurRadius: 19,
                          offset: const Offset(0, 7),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /////////////=>Top Sections
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(),
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                    "$baseUrl/storage/${req.tenantAvatar}",
                                  ),
                                  backgroundColor: Colors.grey[200],
                                  onBackgroundImageError: (_, _) =>
                                      Icon(Icons.person, color: Colors.grey),
                                ),
                              ),
                              const SizedBox(width: 15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    req.tenantName,
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Multicolore',
                                      color: Colors.white,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.phone,
                                        size: 16,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        "+${req.tenantPhone}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const Spacer(),
                              _buildStatusBadge(req.bookingStatusCheck),
                            ],
                          ),

                          const Divider(height: 30, color: Colors.white),

                          /////////////=> Body Section
                          _buildInfoRow(
                            icon: Icons.home,
                            label: "Apartment",
                            value: req.propertyDescription,
                          ),
                          const SizedBox(height: 8),
                          _buildInfoRow(
                            icon: Icons.date_range,
                            label: "Duration",
                            value:
                                "( ${req.startDate} -> ${req.endDate} ) ${req.numberOfDays + 1} Days",
                          ),
                          const SizedBox(height: 8),
                          _buildInfoRow(
                            icon: Icons.attach_money,
                            label: "Total Price",
                            value: " ${req.bookingPrice}\$",
                          ),

                          const SizedBox(height: 20),

                          // Accept & Reject
                          if (req.bookingStatusCheck == 'pending')
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () => controller.updateStatus(
                                      req.id,
                                      'canceled',
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 12,
                                      ),
                                    ),
                                    child: const Text("Reject"),
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () => controller.updateStatus(
                                      req.id,
                                      'completed',
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 12,
                                      ),
                                    ),
                                    child: const Text("Approve"),
                                  ),
                                ),
                              ],
                            )
                          //After Accept/Reject
                          else
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: req.bookingStatusCheck == 'completed'
                                    ? Colors.green[50]
                                    : Colors.red[50],
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Text(
                                req.bookingStatusCheck == 'completed'
                                    ? "You approved this request."
                                    : "You rejected this request.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Louis',
                                  color: req.bookingStatusCheck == 'completed'
                                      ? Colors.green
                                      : Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              );
      }),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.white),
        const SizedBox(width: 10),
        Text(
          "$label: ",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'Louis',
          ),
        ),
        Expanded(
          child: Text(
            value,
            maxLines: 1,
            style: TextStyle(
              fontFamily: 'Louis',
              overflow: TextOverflow.ellipsis,
              fontSize: label == "Total Price" ? 22 : 13,
              fontWeight: FontWeight.bold,
              color: label == "Total Price"
                  ? Color.fromARGB(255, 45, 224, 51)
                  : Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusBadge(String status) {
    Color color;
    switch (status) {
      case 'completed':
        color = Colors.green;
        break;
      case 'canceled':
        color = Colors.red;
        break;
      default:
        color = Colors.blueGrey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: color.withOpacity(0.5), width: 2),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontFamily: 'Louis',
          color: color,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
