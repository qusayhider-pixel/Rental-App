import 'package:uni_project/Services/api_service.dart';

class MyFavoriteModel {
  final int id;
  final String governorate;
  final String city;
  final String title;
  final String price;
  final String description;
  final String area;
  final int rooms;
  final int baths;
  final String rating;
  final String ownerName;
  final String ownerPhone;
  final String ownerAvatar;
  final List<String> imageUrls;

  MyFavoriteModel({
    required this.id,
    required this.governorate,
    required this.city,
    required this.title,
    required this.price,
    required this.description,
    required this.area,
    required this.rooms,
    required this.baths,
    required this.rating,
    required this.ownerName,
    required this.ownerPhone,
    required this.ownerAvatar,
    required this.imageUrls,
  });

  factory MyFavoriteModel.fromJson(Map<String, dynamic> json) {
    return MyFavoriteModel(
      id: json['property']['id'],
      governorate: json['property']['governorate'],
      city: json['property']['city'],
      title: json['property']['title'],
      price: json['property']['price per night'],
      description: json['property']['description'],
      area: json['property']['area'],
      rooms: json['property']['rooms'],
      baths: json['property']['bath rooms'],
      rating: json['property']['rating'],
      ownerName: json['property']['owner information']['name'],
      ownerPhone: json['property']['owner information']['phone number'],
      ownerAvatar: json['property']['owner information']['avatar'],
      imageUrls: (json['property']['images'] as List)
          .map((img) => '$baseUrl/$img')
          .toList(),
    );
  }
}

// {
// ['property']
// "count": 1,
// "favorites": [
// {
// "id": 14,
// "property": {
// "id": 4,
// "governorate": "Damascus",
// "city": "Dummar",
// "title": "it has a...",
// "price per night": "1500.00",
// "description": "it has a view on the sea and it's convenient",
// "area": "350.00",
// "rooms": 5,
// "bath rooms": 6,
// "rating": "4.00",
// "date": "2026-01-02",
// "images": [
// "storage/property_images/qe34lVArRVVyuCvXBfHZRq1R44Rsaky7IKmvWO0U.jpg",
// "storage/property_images/oCkpDBndaUPRTCizWmB8BuuZd1rMIQuRryDdvGQV.jpg",
// "storage/property_images/qUHTEQDRG89whzrNDo3bxaAplbANbMgKb0V7cCqI.jpg"
// ],
// "owner information": {
// "name": "qq qqq",
// "phone number": "7",
// "avatar": "avatars/UZHUXFGi1QYxQEExtuByQZKT4SX1wi1TG6RmDl2j.jpg"
// }
// }
// }
// ]
// }
