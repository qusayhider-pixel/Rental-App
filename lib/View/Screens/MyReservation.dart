import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controller/MyReservationsController.dart';

class MyReservationsScreen extends StatelessWidget {
  MyReservationsScreen({super.key});

  final MyReservationsController controller = Get.put(MyReservationsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Reservations")),
      body: Obx(() {
        if (controller.myBookings.isEmpty) {
          return const Center(child: Text("You have no reservations."));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.myBookings.length,
          itemBuilder: (context, index) {
            final booking = controller.myBookings[index];

            return Card(
              margin: const EdgeInsets.only(bottom: 20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40)),
              // shadowColor: const Color(0xff60519b),
              elevation: 3,
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  ///////////////// => Top Section
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Color(0xff60519b),
                        Color(0xbb82838f)
                      ]),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xff60519b),
                          // spreadRadius: 2,
                          blurRadius: 30,
                          offset: Offset(0, 3),
                        )
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            booking.aptName,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white70,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.circular(28),
                            ),
                            child: Text(
                              "\$${booking.totalPrice}",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
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
                                    "Check-in", booking.startDate)),
                            const Icon(Icons.arrow_forward,
                                color: Colors.grey),
                            Expanded(
                                child: _buildDateBox(
                                    "Check-out", booking.endDate)),
                          ],
                        ),

                        const Divider(height: 30),

                        //////////////// => Owner Info
                        Row(
                          children: [
                            const CircleAvatar(
                              backgroundColor: Colors.teal,
                              child:
                              Icon(Icons.person, color: Colors.white),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text("Owner: ${booking.ownerName}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                                Text(
                                  booking.ownerPhone,
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 16),
                                ),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        //////////////// => Rating Stars
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          children: List.generate(5, (starIndex) {
                            return IconButton(
                              icon: Icon(
                                starIndex < booking.rating
                                    ? Icons.star
                                    : Icons.star_border,
                                color: Colors.amber,
                                size: 30,
                              ),
                              onPressed: () => controller.rateBooking(booking.id, starIndex + 1),
                            );
                          }),
                         ),


                        const Text("Rate this stay",
                            style: TextStyle(
                                fontSize: 14, color: Colors.grey)),

                        const SizedBox(height: 20),

                        //////////////// => Edit & Delete
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton.icon(

                              onPressed: () {},

                              icon: const Icon(Icons.edit_calendar, size: 18),
                              label: const Text("Edit Dates"),
                            ),

                            OutlinedButton.icon(
                              onPressed: () => controller.deleteBooking(booking.id),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.red,
                                side: const BorderSide(color: Colors.red),
                              ),
                              icon: const Icon(Icons.cancel_outlined,
                                  size: 18),
                              label: const Text("Cancel Booking"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }

  Widget _buildDateBox(String label, String date) {
    return Column(
      children: [
        Text(label,
            style: const TextStyle(color: Colors.grey, fontSize: 14)),
        Text(date,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 14)),
      ],
    );
  }
}
class UserBooking {
  final String id;
  final String aptName;
  final String ownerName;
  final String ownerPhone;
  final String startDate;
  final String endDate;
  final double totalPrice;
  int rating;

  UserBooking({
    required this.id,
    required this.aptName,
    required this.ownerName,
    required this.ownerPhone,
    required this.startDate,
    required this.endDate,
    required this.totalPrice,
    this.rating = 0,
  });
}






// // ==========================================
// // (My Reservations)
// // ==========================================
//
// import 'package:flutter/material.dart';
//
//
// class MyReservationsScreen extends StatefulWidget {
//   const MyReservationsScreen({super.key});
//
//   @override
//   State<MyReservationsScreen> createState() => _MyReservationsScreenState();
// }
//
// class _MyReservationsScreenState extends State<MyReservationsScreen> {
//   // بيانات وهمية
//   List<UserBooking> myBookings = [
//     UserBooking(
//       id: '101',
//       aptName: 'Cozy Mountain Cabin',
//       ownerName: 'John Doe',
//       ownerPhone: '+1 555 0123',
//       startDate: '2023-11-01',
//       endDate: '2023-11-05',
//       totalPrice: 600.0,
//       rating: 4,
//     ),
//     UserBooking(
//       id: '102',
//       aptName: 'Seaside Villa',
//       ownerName: 'Maria Garcia',
//       ownerPhone: '+1 555 9876',
//       startDate: '2023-12-20',
//       endDate: '2023-12-25',
//       totalPrice: 1500.0,
//       rating: 0,
//     ),
//   ];
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("My Reservations")),
//       body: myBookings.isEmpty
//           ? const Center(child: Text("You have no reservations."))
//           : ListView.builder(
//         padding: const EdgeInsets.all(16),
//         itemCount: myBookings.length,
//         itemBuilder: (context, index) {
//           final booking = myBookings[index];
//           return Card(
//             margin: const EdgeInsets.only(bottom: 20),
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
//             shadowColor:  Color(0xff60519b),
//             elevation: 3,
//             clipBehavior: Clip.antiAlias,
//             child: Column(
//               children: [
//                 ///////////////// => Top Section
//                 Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(colors: [
//                       Color(0xff60519b),
//                       Color(0xbb82838f)
//                     ]),
//                     boxShadow: [BoxShadow(
//                       color: Color(0xff60519b),
//                       spreadRadius: 1,
//                       blurRadius: 20,
//                       offset: const Offset(0, 6),
//                     )]
//                   ) ,
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           booking.aptName,
//                           style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white70
//                           ),
//                         ),
//                         Container(
//                           padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                           decoration: BoxDecoration(
//                               color:   Colors.teal,
//                               borderRadius: BorderRadius.circular(28)
//                           ),
//                           child: Text(
//                             "\$${booking.totalPrice}",
//                             style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//
//                 ///////////////// => Middle Section
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     children: [
//                       ////////////////  => Duration
//                       Row(
//                         children: [
//                           Expanded(child: _buildDateBox("Check-in", booking.startDate)),
//                           const Icon(Icons.arrow_forward, color: Colors.grey),
//                           Expanded(child: _buildDateBox("Check-out", booking.endDate)),
//                         ],
//                       ),
//
//                       const Divider(height: 30),
//
//                       ////////////////  => Owner Info
//                       Row(
//                         children: [
//                           const CircleAvatar(
//                             backgroundColor: Colors.teal,
//                             child: Icon(Icons.person, color: Colors.white),
//                           ),
//                           const SizedBox(width: 10),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text("Owner: ${booking.ownerName}", style: const TextStyle(fontWeight: FontWeight.bold)),
//                               Text(booking.ownerPhone, style: const TextStyle(color: Colors.grey, fontSize: 16)),
//                             ],
//                           ),
//                         ],
//                       ),
//
//                       const SizedBox(height: 20),
//
//                       ////////////////  => Rating Stars
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: List.generate(5, (starIndex) {
//                           return IconButton(
//                             icon: Icon(
//                               starIndex < booking.rating ? Icons.star : Icons.star_border,
//                               color: Colors.amber,
//                               size: 30,
//                             ),
//                             onPressed: () => _rateBooking(booking.id, starIndex + 1),
//                           );
//                         }),
//                       ),
//                       const Text("Rate this stay", style: TextStyle(fontSize: 14, color: Colors.grey)),
//
//                       ////////////////  => Edit & delete Booking
//                       const SizedBox(height: 20),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           TextButton.icon(
//                             onPressed: () {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 const SnackBar(content: Text('Edit Date functionality is just a demo.')),
//                               );
//                             },
//                             icon: const Icon(Icons.edit_calendar, size: 18),
//                             label: const Text("Edit Dates"),
//                           ),
//
//
//                           OutlinedButton.icon(
//                             onPressed: () => _deleteBooking(booking.id),
//                             style: OutlinedButton.styleFrom(
//                               foregroundColor: Colors.red,
//                               side: const BorderSide(color: Colors.red),
//                             ),
//                             icon: const Icon(Icons.cancel_outlined, size: 18),
//                             label: const Text("Cancel Booking"),
//                           ),
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//
//   //////////////////Methods
//   void _deleteBooking(String id) {
//     setState(() {
//       myBookings.removeWhere((element) => element.id == id);
//     });
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Reservation Cancelled Successfully')),
//     );
//   }
//
//   void _rateBooking(String id, int stars) {
//     setState(() {
//       final index = myBookings.indexWhere((element) => element.id == id);
//       if (index != -1) {
//         myBookings[index].rating = stars;
//       }
//     });
//   }
//
//   Widget _buildDateBox(String label, String date) {
//     return Column(
//       children: [
//         Text(label, style: const TextStyle(color: Colors.grey, fontSize: 14)),
//         Text(date, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
//       ],
//     );
//   }
// }