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
  RxBool isFav = false.obs;




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
    required this.ownerImageUrl, // New
  });

  static List<Apartment> listFromJson(Map<String, dynamic> json) {
    return (json['properties'] as List).map((item) => Apartment.fromJson(item)).toList();
  }

  factory Apartment.fromJson(Map<String, dynamic> json) {
    return Apartment(
        id: json['id'],
        title: json['title'],
        description: json['description'],
      imageUrls: (json['images'] as List).map((img) => '$baseImageUrl$img').toList(),
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



