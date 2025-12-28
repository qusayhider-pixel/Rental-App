class Apartment {
  final String id;
  final String title;
  final String description;
  final List<String> imageUrls; // Changed from single URL to a List of URLs
  final double price;
  final String location;
  final int beds;
  final int baths;
  final int area;
  final String ownerName;
  final String ownerPhone;
  final String ownerImageUrl;

  Apartment({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrls,
    required this.price,
    required this.location,
    required this.beds,
    required this.baths,
    required this.area,
    required this.ownerName, // New
    required this.ownerPhone, // New
    required this.ownerImageUrl, // New
  });
}



