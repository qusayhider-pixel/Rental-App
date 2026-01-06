import 'package:get/get.dart';

class Reservation {
  final int id ;
  String bookingStatusCheck;
  final String tenantName ;
  final String tenantPhone ;
  final String tenantAvatar;
  final String propertyDescription;
  final int numberOfDays;
  final String startDate;
  final String endDate;
  final String bookingPrice;

  Reservation({
    required this.id,
    required this.tenantName,
    required this.tenantPhone,
    required this.tenantAvatar,
    required this.propertyDescription,
    required this.numberOfDays,
    required this.startDate,
    required this.endDate,
    required this.bookingPrice,
    required this.bookingStatusCheck});

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
        id: json['booking_id'],
        tenantName: json['tenant_name'],
        tenantPhone:json['tenant_phone'],
        tenantAvatar:json['tenant_avatar'],
        propertyDescription:json['property_description'],
        numberOfDays:json['number_of_days'],
        startDate:json['start_date'],
        endDate:json['end_date'],
        bookingPrice:json['booking_price'],
        bookingStatusCheck:json['bookings_status_check']
    );
  }
}

class ReservationStatus{
  final String message ;

  ReservationStatus(this.message);

  factory ReservationStatus.fromJson(Map<String, dynamic> json) {
    return  json['message']  ;
  }
}

class MyReservations {
  final int id;
  final int apartmentId;
  final int numberOfDays;
  final String ownerName;
  final String ownerPhoto;
  final String ownerPhone;
  final String propertyTitle;
  final String location;
  final String bookingPrice;
  RxInt rating = 0.obs;
  String startDate;
  String endDate;
  String bookingStatusCheck;
  RxBool isCanceled = false.obs;

  MyReservations({
    required this.id,
    required this.apartmentId,
    required this.ownerName,
    required this.ownerPhoto,
    required this.ownerPhone,
    required this.propertyTitle,
    required this.location,
    required this.startDate,
    required this.endDate,
    required this.numberOfDays,
    required this.bookingPrice,
    required this.bookingStatusCheck
  });

  factory MyReservations.fromJson(Map<String, dynamic> json) {
    return MyReservations(
      id: json['Booking_ID'],
      apartmentId: json['Property Id'],
      ownerName: json['Owner Name'],
      ownerPhoto: json['Owner Photo'],
      ownerPhone: json['Owner Phone'],
      location: 'Location',
      bookingPrice: json['booking_price'],
      numberOfDays: json['number_of_days'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      propertyTitle: json['Property_Title'],
      bookingStatusCheck: json['bookings_status_check'],
    );
  }
}


// {
  // "data": [
  // {
  // "tenant_name": "omar",
  // "tenant_phone": "22",
  // "tenant_avatar": "avatars/rIyhvZnkgOW2aPOtvvXVH9JsHbThJhvYC9BVrqso.jpg",
  // "property_description": "it has a view on the sea and it's convenient",
  // "number_of_days": 4,
  // "start_date": "2026-01-02",
  // "end_date": "2026-01-06",
  // "booking_price": "7500.00",
  // "bookings_status_check": "pending"
  // },
  // {
  // "tenant_name": "omar",
  // "tenant_phone": "22",
  // "tenant_avatar": "avatars/rIyhvZnkgOW2aPOtvvXVH9JsHbThJhvYC9BVrqso.jpg",
  // "property_description": "it has a view on the sea and it's convenient",
  // "number_of_days": 7,
  // "start_date": "2026-01-21",
  // "end_date": "2026-01-28",
  // "booking_price": "12000.00",
  // "bookings_status_check": "pending"
  // },
  // {
  // "tenant_name": "omar",
  // "tenant_phone": "22",
  // "tenant_avatar": "avatars/rIyhvZnkgOW2aPOtvvXVH9JsHbThJhvYC9BVrqso.jpg",
  // "property_description": "it has a view on the sea and it's convenient",
  // "number_of_days": 4,
  // "start_date": "2026-01-12",
  // "end_date": "2026-01-16",
  // "booking_price": "7500.00",
  // "bookings_status_check": "completed"
  // }
  // ]
// }


// {
// "data": [
// {
// "Owner Name": "Ahmad",
// "Owner Photo": "storage/avatars/Nz7PgGplDq3c1N1KtwzflYhkSTmqBnAHHceBDBf7.jpg",
// "Owner Phone": "0950000181",
// "Property_Description": "it has a beautiful view with big swimming pool",
// "Property_Rooms": 4,
// "Property_Area": "150.00",
// "Location": "Rif Dimashq/Zabadani",
// "start_date": "2026-01-04",
// "end_date": "2026-01-10",
// "number_of_days": 6,
// "booking_price": "4900.00",
// "bookings_status_check": "completed"
// }
// ]
// }