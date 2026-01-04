import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uni_project/Controller/BookingController.dart';
import 'package:uni_project/Services/api_service.dart';
import 'package:uni_project/View/Screens/HomeScreen.dart';
import '../Model/apartment_model.dart';
import '../Model/booking_model.dart';
import '../Model/city_model.dart';
import '../Model/province_model.dart';

class ApartmentDetailsController extends GetxController {
  final service = ApiService();

  int? requestId;
  //----------- getting apartments's variables-----------
  var favApartments = <Apartment>[].obs;
  var selectedDateRange = Rxn<DateTimeRange>();
  final bookings = <BookingRange>[].obs;

  //--------------adding apartments's variables----------
  final price = TextEditingController();
  final area = TextEditingController();
  final rooms = TextEditingController();
  final bathrooms = TextEditingController();
  final description = TextEditingController();
  var selectedProvince = Rxn<Province>();
  var selectedCity = Rxn<City>();
  var selectedImages = RxList<File?>(List.generate(5, (_) => null));

  //-----------------------functions---------------------
  int nights() {
    return selectedDateRange.value?.duration.inDays ?? 0;
  }

  void updateDateRange(DateTimeRange range) {
    selectedDateRange.value = range;
  }

  void addToFav(Apartment apartment) async {
    if (apartment.isFav.value == true) {
      await Get.defaultDialog(
        title: "Warning!",
        middleText: "You're Removing this Apartment from Your Favourites",
        textConfirm: "Confirm",
        textCancel: "Cancel",
        onConfirm: () {
          apartment.isFav.value = false; // ✅ remove fav
          Get.back();
        },
        radius: 24,
      );
    } else {
      apartment.isFav.value = true;
      favApartments.add(apartment);
    }
  }

  void updateProvince(Province? province) {
    selectedProvince.value = province;
    selectedCity.value = null;
  }

  void updateCity(City? city) {
    selectedCity.value = city;
  }

  void pickImage(int index) async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      selectedImages[index] = File(pickedFile.path);
      print(selectedImages.toString());
      print(selectedImages.length);
    }
  }

  void removeImage(int index) {
    selectedImages[index] = null;
  }

  Future<void> fetchBookings(int apartmentId) async {
    try {
      final response = await service.fetchApartmentBookings(apartmentId);

      bookings.value = response;


      Get.find<BookingController>().setBookedRanges(bookings);
    } catch (e) {
      e.toString();
    }
  }

  void uploadApartment() async {
    print("desc: ${description.text}");

    Map<String, dynamic> body = {
      "governorate": selectedProvince.value!.name,
      "city": selectedCity.value!.name,
      "price_per_night": price.text,
      "description": description.text,
      "area": area.text,
      "rooms": rooms.text,
      "bath_rooms": bathrooms.text,
    };


    List<File> finalImages = selectedImages.whereType<File>().toList();

    print(body);
    print(finalImages.toString());

    requestId = await service.uploadApartment(
      data: body,
      images: finalImages,
    );

    print("Request id is : $requestId");

    if (requestId != null) {
      Get.snackbar("Success", "Apartment uploaded Successfully \n Id: $requestId");
      Get.off(HomeScreen());
    } else {
      Get.snackbar("Failed", "Error happened when uploading your apartment \n Please try again");
    }
  }
}
