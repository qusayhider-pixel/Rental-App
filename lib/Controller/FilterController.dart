import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Model/apartment_model.dart';
import '../Model/city_model.dart';
import '../Model/province_model.dart';
import '../Services/api_service.dart';

class FilterController extends GetxController {
  final service = ApiService();

  // Apartments Data---------------------------------------------------------------------------

  var allApartments = <Apartment>[].obs;
  var filteredApartments = <Apartment>[].obs;

  // Location Filters---------------------------------------------------------------------------

  var selectedProvince = Rxn<Province>();
  var selectedCity = Rxn<City>();

  // UI State (was inside StatefulWidget)
  // ---------------------------------------------------------------------------

  var priceRange = const RangeValues(100, 5000).obs;

  var selectedRooms = 2.obs;

  var isFilterExpanded = false.obs;

  var isLoading = false.obs;

  // Lifecycle---------------------------------------------------------------------------
  @override
  void onInit() {
    super.onInit();
    fetchApartments();
  }

  // UI Updates---------------------------------------------------------------------------
  void updatePriceRange(RangeValues values) {
    /// حماية من assertion
    final double start = values.start.clamp(100, 5000);
    final double end = values.end.clamp(100, 5000);

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

  // Fetching Apartments---------------------------------------------------------------------------
  void fetchApartments() async {
    try {
      isLoading(true);
      allApartments.value = await service.getApartments();
      filteredApartments.value = await service.getApartments();

      print(allApartments.isEmpty);
      // allApartments.assignAll(sampleApartments);
      // filteredApartments.assignAll(sampleApartments);

      for (var a in allApartments) {
        print(a.isFav);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load');
    } finally {
      isLoading(false);
    }
  }

  Apartment getApartmentById(int id) {
    return allApartments.firstWhere((apt) => apt.id == id);
  }

  // Location Selection---------------------------------------------------------------------------
  void updateProvince(Province? province) {
    selectedProvince.value = province;
    selectedCity.value = null; // Reset city selection
  }

  void updateCity(City? city) {
    selectedCity.value = city;
  }

  // Apply Filters--------------------------------------------------------------------------
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

      return matchesProvince && matchesCity && matchesRooms && matchesPrice;
    }).toList();

    filteredApartments.assignAll(result);
    update(); // for GetBuilder
  }

  // Reset Filters---------------------------------------------------------------------------
  void resetFilters() {
    print('🔄 Reset filters');
    // Location
    selectedProvince.value = null;
    selectedCity.value = null;

    // Filters
    priceRange.value = const RangeValues(100, 5000);
    selectedRooms.value = 2;
    isFilterExpanded.value = true;

    // Apartments
    filteredApartments.assignAll(allApartments);
    update();
  }
}
