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