import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_project/Controller/ReservationController.dart';


class ReservationManagementScreen extends StatelessWidget {
  ReservationManagementScreen({super.key});

  final ReservationController controller = Get.find();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text(" Reservation Management"),),
      body: Obx(() {



        return controller.isLoading.value ? Center(child: const CircularProgressIndicator(strokeWidth: 3,)) :
        controller.reservationRequest.isEmpty ?
        Center(child: Text("No pending Reservations Requests")) :
        ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.reservationRequest.length,
          itemBuilder: (context, index) {
            final req = controller.reservationRequest[index];
            Color shadowColor = req.bookingStatusCheck =='completed' ? Colors.green :
                req.bookingStatusCheck=='canceled' ? Colors.red : 
                    Colors.blueGrey ;

            return Container(
              margin: const EdgeInsets.only(bottom: 40),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                gradient: Get.isDarkMode
                    ? const LinearGradient(
                  colors: [Color(0xff41394f), Color(0xff261f32)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
                    : LinearGradient(
                  colors: [
                    const Color(0xffffffff),
                    const Color(0xffd3d5e7),
                    const Color(0xffb2a2f1),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                boxShadow: [
                  BoxShadow(
                    color: shadowColor,
                    spreadRadius: 0.1,
                    blurRadius: 18,
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
                          decoration: BoxDecoration(

                          ),
                          child: CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage("http://10.0.2.2:8000/storage/${req.tenantAvatar}"),
                            backgroundColor: Colors.grey[200],
                            onBackgroundImageError: (_,_) {},
                            child:  Icon(Icons.person,
                                color: Colors.grey),
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
                                color: Get.isDarkMode ?  Colors.white : Colors.black54,
                              ),
                            ),
                            Row(
                              children: [
                                 Icon(Icons.phone,
                                    size: 16, color : Get.isDarkMode ?  Colors.white : Colors.black54),
                                const SizedBox(width: 5),
                                Text(
                                  "+${req.tenantPhone}",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Get.isDarkMode ?  Colors.white : Colors.black54,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        _buildStatusBadge(req.bookingStatusCheck),
                      ],
                    ),

                    const Divider(height: 30),

                    /////////////=> Body Section
                    _buildInfoRow( icon: Icons.home, label: "Apartment", value: req.propertyDescription),
                    const SizedBox(height: 8),
                    _buildInfoRow(icon: Icons.date_range, label: "Duration",value: "(${req.startDate} -> ${req.endDate}) ${req.numberOfDays+1} Days"),
                    const SizedBox(height: 8),
                    _buildInfoRow(  icon: Icons.attach_money,label:  "Total Price", value:  "\$${req.bookingPrice}"),

                    const SizedBox(height: 20),

                    // Accept & Reject
                    if (req.bookingStatusCheck == 'pending')
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => controller.updateStatus(req.id, 'canceled'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12),
                              ),
                              child: const Text("Reject"),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => controller.updateStatus(req.id, 'completed'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12),
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

  Widget _buildInfoRow({required IconData icon, required String label,required String value}) {
    return Row(
      children: [
        Icon(icon,
            size: 20,
            color:
            Get.isDarkMode ? Colors.white : Colors.black45),
        const SizedBox(width: 10),
        Text(
          "$label: ",
          style: TextStyle(
              color: Get.isDarkMode
                  ? Colors.white38
                  : Colors.black38,
              fontWeight: FontWeight.w500),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize:  label=="Total Price" ? 20 : 13 ,
              fontWeight: FontWeight.bold,
              color: label=="Total Price" ? Color(0xFF4CAE50) :
              Get.isDarkMode
                  ? Colors.white70
                  : Colors.black54,
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
      padding:
      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Text(
        status,
        style: TextStyle(
            color: color,
            fontSize: 14,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}


