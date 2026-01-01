class Booking {
  final int id;
  final String status;

  Booking({required this.id, required this.status});

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(id: json['id'], status: json['bookings_status_check']);
  }
}

class BookingRange {
  final DateTime start;
  final DateTime end;

  BookingRange({required this.start, required this.end});

  factory BookingRange.fromJson(Map<String, dynamic> json) {
    return BookingRange(
      start: DateTime.parse(json['start_date']),
      end: DateTime.parse(json['end_date']),
    );
  }
}

// the reponse of booking an apartment
// {
// "booking": {
// "tenant_id": 3,
// "property_id": "1",
// "booking_price": 1500,
// "start_date": "2026-01-01",
// "end_date": "2026-01-04",
// "bookings_status_check": "pending",
// "updated_at": "2025-12-30T19:40:58.000000Z",
// "created_at": "2025-12-30T19:40:58.000000Z",
// "id": 1 ////////////////////////////////// store this value to get the booking request then edit it
// },
// "total_price": 1500
// }//

//=> for using in my bookings
// "data":
// [
// {
// "Owner Name": "qusay",
// "Owner Photo": "http://127.0.0.1:8000/storage/avatars/rIyhvZnkgOW2aPOtvvXVH9JsHbThJhvYC9BVrqso.jpg",
// "Owner Phone": "123456",
// "Property_Description": "it has a view on the sea and it's convenient",
// "Property_Rooms": 2,
// "Property_Area": "35.00",
// "Location": "Damascus/Mazzeh",
// "start_date": "2026-01-01",
// "end_date": "2026-01-04",
// "number_of_days": 3,
// "booking_price": "1500.00",
// "bookings_status_check": "pending"
// }
// ]
// }

//
// {
// "data": [
// {
// "booking_id": 12,
// "start_date": "2025-12-31",
// "end_date": "2026-01-14"
// }
// ]
// }
