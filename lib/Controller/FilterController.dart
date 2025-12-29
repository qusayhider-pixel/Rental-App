import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Model/apartment_model.dart';
import '../Model/city_model.dart';
import '../Model/province_model.dart';

class FilterController extends GetxController {

  // ---------------------------------------------------------------------------
  // Apartments Data
  // ---------------------------------------------------------------------------

  var allApartments = <Apartment>[].obs;
  var filteredApartments = <Apartment>[].obs;

  // ---------------------------------------------------------------------------
  // Location Filters
  // ---------------------------------------------------------------------------

  var selectedProvince = Rxn<Province>();
  var selectedCity = Rxn<City>();

  // ---------------------------------------------------------------------------
  // UI State (was inside StatefulWidget)
  // ---------------------------------------------------------------------------

  var priceRange = const RangeValues(100, 5000).obs;

  var selectedRooms = 2.obs;

  var isFilterExpanded = false.obs;

  // ---------------------------------------------------------------------------
  // Static Provinces Data
  // ---------------------------------------------------------------------------

  final List<Province> provinces = [
    Province(
      id: 1,
      name: 'Damascus',
      cities: [
        City(id: 101, name: 'Dummar'),
        City(id: 102, name: 'Al-Shagour'),
        City(id: 103, name: 'Mazzeh'),
        City(id: 104, name: 'Qanawat'),
      ],
    ),
    Province(
      id: 2,
      name: 'Aleppo',
      cities: [
        City(id: 201, name: 'Azaz'),
        City(id: 202, name: 'Al-Bab'),
        City(id: 203, name: 'Manbij'),
        City(id: 204, name: 'Jarabulus'),
      ],
    ),
    Province(
      id: 3,
      name: 'Homs',
      cities: [
        City(id: 301, name: 'Tadmur'),
        City(id: 302, name: 'Al-Qusayr'),
        City(id: 303, name: 'Al-Rastan'),
        City(id: 304, name: 'Talbiseh'),
      ],
    ),
  ];

  // ---------------------------------------------------------------------------
  // Lifecycle
  // ---------------------------------------------------------------------------

  @override
  void onInit() {
    super.onInit();
    allApartments.assignAll(sampleApartments);
    filteredApartments.assignAll(sampleApartments);
  }

  // ---------------------------------------------------------------------------
  // UI Updates
  // ---------------------------------------------------------------------------

  void updatePriceRange(RangeValues values) {
    /// حماية من assertion
    final double start = values.start.clamp(100, 5000);
    final double end   = values.end.clamp(100, 5000);

    if (start <= end) {
      priceRange.value = RangeValues(start, end);
    }
  }

  void updateSelectedRooms(int rooms) {
    selectedRooms.value = rooms;
  }

  void updateFilterExpanded(bool expanded) {
    isFilterExpanded.value = expanded;
  }

  // ---------------------------------------------------------------------------
  // Location Selection
  // ---------------------------------------------------------------------------

  void updateProvince(Province? province) {
    selectedProvince.value = province;
    selectedCity.value = null; // Reset city selection
  }

  void updateCity(City? city) {
    selectedCity.value = city;
  }

  // ---------------------------------------------------------------------------
  // Apply Filters
  // ---------------------------------------------------------------------------

  void applyFilters() {
    final result = allApartments.where((apartment) {

      /// Province
      final matchesProvince = selectedProvince.value == null
          ? true
          : apartment.province == selectedProvince.value!.name;

      /// City
      final matchesCity = selectedCity.value == null
          ? true
          : apartment.city == selectedCity.value!.name;

      /// Rooms
      final matchesRooms = selectedRooms.value == 0
          ? true
          : apartment.beds == selectedRooms.value;

      /// Price
      final matchesPrice =
          apartment.price >= priceRange.value.start &&
              apartment.price <= priceRange.value.end;

      return matchesProvince &&
          matchesCity &&
          matchesRooms &&
          matchesPrice;
    }).toList();

    filteredApartments.assignAll(result);
    update(); // for GetBuilder
  }

  // ---------------------------------------------------------------------------
  // Reset Filters
  // ---------------------------------------------------------------------------

  void resetFilters() {
    print('🔄 Reset filters');

    // Location
    selectedProvince.value = null;
    selectedCity.value = null;

    // Filters
    priceRange.value = const RangeValues(100, 5000);
    selectedRooms.value = 2;
    isFilterExpanded.value = false;

    // Apartments
    filteredApartments.assignAll(allApartments);
    update();
  }
}

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