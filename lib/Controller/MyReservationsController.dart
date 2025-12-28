import 'package:get/get.dart';
import '../View/Screens/MyReservation.dart';

class MyReservationsController extends GetxController {
  // Observable list
  var myBookings = <UserBooking>[
    UserBooking(
      id: '101',
      aptName: 'Cozy Mountain Cabin',
      ownerName: 'John Doe',
      ownerPhone: '+1 555 0123',
      startDate: '2023-11-01',
      endDate: '2023-11-05',
      totalPrice: 600.0,
      rating: 4,
    ),
    UserBooking(
      id: '102',
      aptName: 'Seaside Villa',
      ownerName: 'Maria Garcia',
      ownerPhone: '+1 555 9876',
      startDate: '2023-12-20',
      endDate: '2023-12-25',
      totalPrice: 1500.0,
      rating: 0,
    ),
  ].obs;

  void deleteBooking(String id) {
    myBookings.removeWhere((element) => element.id == id);
    Get.snackbar('Success', 'Reservation Cancelled Successfully');
  }

  void rateBooking(String id, int stars) {
    final index = myBookings.indexWhere((element) => element.id == id);
    if (index != -1) {
      myBookings[index].rating = stars;
      myBookings.refresh(); // important for Obx
    }
  }
}
