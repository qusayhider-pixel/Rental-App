import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Model/apartment_model.dart';
import '../Model/city_model.dart';
import '../Model/province_model.dart';

class FilterController extends GetxController {
  // var allApartments = <Apartment>[].obs;
  // var filteredApartments = <Apartment>[].obs;
  var allApartments = sampleApartments;
  var filteredApartments = sampleApartments;

  var selectedProvince = Rxn<Province>();
  var selectedCity = Rxn<City>();

  RxInt selectedRooms = 0.obs;
  Rx<RangeValues> priceRange = const RangeValues(0, 5000).obs;

  // Your data list
  final List<Province> provinces = [
    Province(
      id: 1,
      name: 'Damascus',
      cities: [
        City(id: 101, name: 'Dummar'),
        City(id: 102, name: 'Al-Shagour'),
        City(id: 103, name: 'Mazzeh'),
        City(id: 104, name: 'Qanawat')
      ],
    ),Province(
      id: 2,
      name: 'Aleppo',
      cities: [
        City(id: 101, name: 'Azaz'),
        City(id: 102, name: 'Al-Bab'),
        City(id: 103, name: 'Manbij'),
        City(id: 104, name: 'Jarabulus'),
      ],
    ),
    Province(
      id: 2,
      name: 'Homs',
      cities: [
        City(id: 201, name: 'Tadmur'),
        City(id: 202, name: 'Al-Qusayr'),
        City(id: 202, name: 'Al-Rastan'),
        City(id: 202, name: 'Talbiseh'),
      ],
    ),
  ];

  void updateProvince(Province? province) {
    selectedProvince.value = province;
    selectedCity.value = null; // Reset city selection
  }

  void updateCity(City? city) {
    selectedCity.value = city;
  }


  void applyFilters() {
    // if (selectedProvince.value == null) {
    //   Get.snackbar(
    //     'Error',
    //     'يرجى اختيار المحافظة أولاً',
    //     snackPosition: SnackPosition.TOP,
    //   );
    //   return;
    // }

    final result = sampleApartments.where((apartment) {
      final matchesProvince = apartment.province == selectedProvince.value!.name;

      final matchesCity = selectedCity.value == null
          ? true
          : apartment.city == selectedCity.value!.name;

      final matchesRooms = selectedRooms.value == 0
          ? true
          : apartment.beds == selectedRooms.value;

      final matchesPrice =
          apartment.price >= priceRange.value.start &&
          apartment.price <= priceRange.value.end;

      return
        matchesProvince &&
          matchesCity &&
          matchesRooms &&
          matchesPrice;
    }).toList();

    filteredApartments.assignAll(result);
    update();
  }


  void resetFilters() {
    print('🔄 Reset filters');

    // Location
    selectedProvince.value = null;
    selectedCity.value = null;
    // cities.clear();
    // isCityEnabled.value = false;
    // Filters
    priceRange.value = const RangeValues(200, 2000);
    selectedRooms.value = 2;

    // Apartments
    filteredApartments.assignAll(allApartments);
    update();
  }


// final ApiService apiService = ApiService();
  //
  // /// Data from backend
  // var provinces = <Province>[].obs;
  // var cities = <City>[].obs;
  //
  // /// Selected values
  // var selectedProvince = Rxn<Province>();
  // var selectedCity = Rxn<City>();
  //
  // /// UI State
  // var isCityEnabled = false.obs;
  //
  // @override
  // void onInit() {
  //   super.onInit();
  //   fetchProvinces();
  // }
  //
  // Future<void> fetchProvinces() async {
  //   provinces.value = await apiService.getProvinces();
  // }
  //
  // /// 🔹 المستخدم يختار محافظة
  // void onProvinceSelected(Province? province) {
  //   selectedProvince.value = province;
  //
  //   if (province != null) {
  //     cities.value = province.cities; // تحميل المدن التابعة
  //     selectedCity.value = null;       // إعادة تعيين المدينة
  //     isCityEnabled.value = true;      // تفعيل Dropdown المدينة
  //   } else {
  //     resetCity();
  //   }
  // }
  //
  // /// 🔹 المستخدم يختار مدينة (فقط بعد المحافظة)
  // void onCitySelected(City? city) {
  //   if (!isCityEnabled.value) return;
  //   selectedCity.value = city;
  // }
  //
  // /// 🔹 إعادة ضبط المدينة
  // void resetCity() {
  //   cities.clear();
  //   selectedCity.value = null;
  //   isCityEnabled.value = false;
  // }
}



// ---------------------------------------------------------------------------
// 2. Data Model
// ---------------------------------------------------------------------------
final List<Apartment> sampleApartments = [
  Apartment(
    id: '1',
    title: 'Luxury Nile View Apartment',
    description:
    'A stunning modern apartment with a direct view of the Nile. Fully furnished with high-end amenities. Located in the heart of Zamalek, close to top restaurants and cafes.',
    imageUrls: [
      'https://images.pexels.com/photos/1571460/pexels-photo-1571460.jpeg?auto=compress&cs=tinysrgb&w=800',
      'https://images.pexels.com/photos/271624/pexels-photo-271624.jpeg?auto=compress&cs=tinysrgb&w=800',
      'https://images.pexels.com/photos/1918291/pexels-photo-1918291.jpeg?auto=compress&cs=tinysrgb&w=800',
    ],
    price: 1200.0,
    province: 'Damascus',
    city: 'Mazzeh',
    beds: 3,
    baths: 2,
    area: 180,
    ownerName: 'Karim Essam',
    ownerPhone: '+20 100 234 5678',
    ownerImageUrl:
    'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=200',
  ),
  Apartment(
    id: '2',
    title: 'Modern Studio in Downtown',
    description:
    'Perfect for professionals. Close to all business hubs and metro stations. Minimalist design with smart home features.',
    imageUrls: [
      'https://images.pexels.com/photos/276724/pexels-photo-276724.jpeg?auto=compress&cs=tinysrgb&w=800',
      'https://images.pexels.com/photos/276583/pexels-photo-276583.jpeg?auto=compress&cs=tinysrgb&w=800',
      'https://images.pexels.com/photos/1571459/pexels-photo-1571459.jpeg?auto=compress&cs=tinysrgb&w=800',
    ],
    price: 450.0,
    province: 'Aleppo',
    city: 'Azaz',
    beds: 1,
    baths: 1,
    area: 75,
    ownerName: 'Mona Ahmed',
    ownerPhone: '+20 122 987 6543',
    ownerImageUrl:
    'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=200',
  ),
  Apartment(
    id: '3',
    title: 'Cozy Family House',
    description:
    'Spacious garden, quiet neighborhood, and close to international schools. Ideal for families looking for tranquility.',
    imageUrls: [
      'https://images.pexels.com/photos/1643383/pexels-photo-1643383.jpeg?auto=compress&cs=tinysrgb&w=800',
      'https://images.pexels.com/photos/1643389/pexels-photo-1643389.jpeg?auto=compress&cs=tinysrgb&w=800',
      'https://images.pexels.com/photos/259588/pexels-photo-259588.jpeg?auto=compress&cs=tinysrgb&w=800',
    ],
    price: 850.0,
    province: 'Homs',
    city: 'Talbiseh',
    beds: 4,
    baths: 3,
    area: 250,
    ownerName: 'Mosab Abu Draaaa',
    ownerPhone: '0938362405',
    ownerImageUrl:
    'https://images.pexels.com/photos/91227/pexels-photo-91227.jpeg?auto=compress&cs=tinysrgb&w=200',
  ),
];