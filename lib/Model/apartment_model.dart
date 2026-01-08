import 'package:get/get.dart';

const String baseImageUrl = 'http://10.0.2.2:8000/';

class Apartment {
  final int id;
  final String title;
  final String description;
  final List<String> imageUrls; // Changed from single URL to a List of URLs
  final double price;
  final String province;
  final String city;
  final int beds;
  final int baths;
  final double area;
  final double rate;
  final String ownerName;
  final String ownerPhone;
  final String ownerImageUrl;
  final RxBool isFav;

  Apartment({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrls,
    required this.price,
    required this.province,
    required this.city,
    required this.beds,
    required this.baths,
    required this.area,
    required this.rate,
    required this.ownerName, // New
    required this.ownerPhone, // New
    required this.ownerImageUrl,
    required bool isFav,
  }) : isFav = (isFav).obs;

  // static List<Apartment> listFromJson(Map<String, dynamic> json) {
  //   return (json['properties'] as List).map((item) => Apartment.fromJson(item)).toList();
  // }

  //adding apartment

  // getting the apartmetns
  factory Apartment.fromJson(Map<String, dynamic> json) {
    return Apartment(
      id: json['id'],
      isFav: json['is_favorite'],
      title: json['title'],
      description: json['description'],
      imageUrls: (json['images'] as List)
          .map((img) => '$baseImageUrl$img')
          .toList(),
      price: _toDouble(json['price per night']),
      province: json['governorate'],
      city: json['city'],
      beds: json['rooms'],
      baths: json['bath rooms'],
      area: _toDouble(json['area']),
      rate: _toDouble(json['rating']),
      ownerName: json['owner information']['name'],
      ownerPhone: json['owner information']['phone number'],
      ownerImageUrl: json['owner information']['avatar'],
    );
  }

  static double _toDouble(dynamic value) {
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }
}

class AddNewApartment {
  final int id;

  AddNewApartment({required this.id});

  factory AddNewApartment.fromJson(Map<String, dynamic> json) {
    return AddNewApartment(id: json['id']);
  }
}

//the response of adding a new apartment
// {
// "property": {
// "price_per_night": "1000",
// "description": "it has a view on the sea and it's convenient",
// "area": "100",
// "rooms": "2",
// "bath_rooms": "1",
// "governorate_id": 3,
// "city_id": 15,
// "owner_id": 3,
// "updated_at": "2026-01-02T19:22:02.000000Z",
// "created_at": "2026-01-02T19:22:02.000000Z",
// "id": 5
// },
// "images": [
//   "storage/property_images/UpNQN3oXk5OThkkWNEHVkKGRVNfvk9LSj7W2euuZ.jpg"
// ]
// }
