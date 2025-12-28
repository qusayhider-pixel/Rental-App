
// ==========================================
//  (Reservation Management)
// ==========================================

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingRequest {
  final String id;
  final String renterName;
  final String renterImage;
  final String phoneNumber;
  final String apartmentName;
  final String duration;
  final double totalPrice;
  String status; // Pending, Approved, Rejected

  BookingRequest({
    required this.id,
    required this.renterName,
    required this.renterImage,
    required this.phoneNumber,
    required this.apartmentName,
    required this.duration,
    required this.totalPrice,
    this.status = 'Pending',
  });
}

class ReservationManagementScreen extends StatefulWidget {
  const ReservationManagementScreen({super.key});

  @override
  State<ReservationManagementScreen> createState() => _ReservationManagementScreenState();
}

class _ReservationManagementScreenState extends State<ReservationManagementScreen> {


  List<BookingRequest> requests = [
    BookingRequest(
      id: '1',
      renterName: 'Ahmed Ali',
      renterImage: 'https://i.pravatar.cc/150?img=11',
      phoneNumber: '+966 50 123 4567',
      apartmentName: 'Sunny Beach View Apt',
      duration: '3 Nights (10 - 13 Oct)',
      totalPrice: 450.0,
    ),
    BookingRequest(
      id: '2',
      renterName: 'Sara Smith',
      renterImage: 'https://i.pravatar.cc/150?img=5',
      phoneNumber: '+1 202 555 0199',
      apartmentName: 'Downtown Luxury Loft',
      duration: '7 Nights (15 - 22 Oct)',
      totalPrice: 1200.0,
    ),
  ];

  void _updateStatus(String id, String newStatus) {
    setState(() {
      final index = requests.indexWhere((element) => element.id == id);
      if (index != -1) {
        requests[index].status = newStatus;
      }
    });
    String snackText = newStatus == 'Approved' ? 'Reservation Approved' : 'Reservation Rejected';
    Color snackColor = newStatus == 'Approved' ? Colors.green : Colors.red;

    Get.snackbar(
        ' Status : ',
        ' $snackText ',
        backgroundColor: snackColor,
        duration: const Duration(milliseconds: 700)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Reservation Management")),
      body: requests.isEmpty
          ? const Center(child: Text("No pending requests"))
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: requests.length,
        itemBuilder: (context, index) {
          final req = requests[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                gradient: Get.isDarkMode
                    ? LinearGradient(
                  colors: [Color(0xff41394f), Color(0xff261f32)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
                    : //light  mode
                LinearGradient(
                  colors: [
                    Color.fromARGB(134, 232, 201, 255),
                    const Color.fromARGB(255, 197, 154, 255),
                    const Color.fromARGB(228, 137, 78, 255),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),

            ),

            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(req.renterImage),
                        backgroundColor: Colors.grey[200],
                        // إضافة معالجة للأخطاء في حال عدم وجود إنترنت
                        onBackgroundImageError: (_,_) {},
                        child: const Icon(Icons.person, color: Colors.grey),
                      ),
                      const SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            req.renterName,
                            style:  TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Multicolore',
                                color: Colors.white
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(Icons.phone, size: 16, color: Colors.white),
                              const SizedBox(width: 5),
                              Text(req.phoneNumber , style: TextStyle(fontSize:14 ,color: Colors.white , fontWeight: FontWeight.w500),),
                            ],
                          ),
                        ],
                      ),
                      const Spacer(),
                      _buildStatusBadge(req.status),
                    ],
                  ),
                  const Divider(height: 30),

                  // تفاصيل الحجز
                  _buildInfoRow(Icons.home, "Apartment", req.apartmentName),
                  const SizedBox(height: 8),
                  _buildInfoRow(Icons.date_range, "Duration", req.duration),
                  const SizedBox(height: 8),
                  _buildInfoRow(Icons.attach_money, "Total Price", "\$${req.totalPrice}"),

                  const SizedBox(height: 20),

                  // أزرار التحكم
                  if (req.status == 'Pending')
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => _updateStatus(req.id, 'Rejected'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.red,
                              side: const BorderSide(color: Colors.red),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: const Text("Reject"),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => _updateStatus(req.id, 'Approved'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: const Text("Approve"),
                          ),
                        ),
                      ],
                    )
                  else
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: req.status == 'Approved' ? Colors.green[50] : Colors.red[50],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        req.status == 'Approved' ? "You approved this request." : "You rejected this request.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: req.status == 'Approved' ? Colors.green : Colors.red,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20,
            color: Get.isDarkMode ? Colors.white : Colors.black45
        ),
        const SizedBox(width: 10),
        Text("$label: ", style:  TextStyle(
            color: Get.isDarkMode ? Colors.white38 : Colors.black38,
            fontWeight: FontWeight.w500)
        ),
        Expanded(child: Text(value,
            style:  TextStyle(
                fontWeight: FontWeight.bold ,
                color: Get.isDarkMode ?  Colors.white70 : Colors.black54
            )
        )),
      ],
    );
  }

  Widget _buildStatusBadge(String status) {
    Color color;
    switch (status) {
      case 'Approved': color = Colors.green; break;
      case 'Rejected': color = Colors.red; break;
      default: color = Colors.white;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Text(
        status,
        style: TextStyle(color: color, fontSize: 14, fontWeight: FontWeight.bold),
      ),
    );
  }
}


