import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controller/FilterController.dart';
import '../../Model/city_model.dart';
import '../../Model/province_model.dart';
import '../Components/ApartmentCard.dart';
import '../Components/CustomDrawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FilterController filterController = Get.put(FilterController());

    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Center(
          child: Text(
            "LUXESTAY",
            style: TextStyle(
              fontFamily: 'Virust',
              letterSpacing: 4,
              fontWeight: FontWeight.bold,
              fontSize: 40,
              foreground: Paint()
                ..shader = LinearGradient(
                  colors: <Color>[
                    Color(0xfff6c9c5),
                    Color(0xffdc85b4),
                    Color(0xffae4fdc),
                    Color(0xff6918e8),

                    // Color(0xff5a00ff), Color(0xffBF9BFF)
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ).createShader(Rect.fromLTWH(0.0, 0.0, 300.0, 70.0)),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Get.isDarkMode
                ? Icon(Icons.wb_sunny_sharp)
                : Icon(Icons.dark_mode_sharp),
            onPressed: () {
              if (Get.isDarkMode) {
                Get.changeTheme(ThemeData.light());
              } else {
                Get.changeTheme(ThemeData.dark());
              }
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      drawer: CustomDrawer(),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filter Section
            _buildFilterSection(filterController, context),

            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Featured Properties",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  TextButton(
                    onPressed: () {
                      filterController.fetchApartments();
                      filterController.resetFilters();
                    },
                    child: Text("See All"),
                  ),
                ],
              ),
            ),

            // List
            Obx(
              () => filterController.isLoading.value
                  ? Center(
                      child: const CircularProgressIndicator(strokeWidth: 3),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      itemCount: filterController.filteredApartments.length,
                      itemBuilder: (context, index) {
                        return ApartmentCard(
                          apartment: filterController.filteredApartments[index],
                        );
                      },
                    ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterSection(FilterController filterController,
      BuildContext context,) {
    return Obx(
      () => Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(36),
          gradient: Get.isDarkMode
              ? LinearGradient(
            colors: [
              Color(0xff7f3aa1),
              Color(0xff5416b5),
              Color(0xff150b52),
              Color(0xff0c0516),
              Color(0xff190019),
              // Color(0xff41394f), Color(0xff261f32)
            ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : //light  mode
                LinearGradient(
                  colors: [
                    Color(0xfff6c9c5),
                    Color(0xffdc85b4),
                    Color(0xffae4fdc),
                    Color(0xff6918e8),
                    // Color.fromARGB(245, 255, 255, 255),
                    // const Color.fromARGB(171, 255, 255, 255),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
          boxShadow: [
            BoxShadow(
              blurStyle: BlurStyle.normal,
              color: Color(0xff846be7),
              spreadRadius: 0.5,
              blurRadius: 15,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ClipRRect(
            // borderRadius: BorderRadius.circular(24),
            child: ExpansionTile(
              initiallyExpanded: filterController.isFilterExpanded.value,
              onExpansionChanged: filterController.updateFilterExpanded,
              tilePadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 8,
              ),
              childrenPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              title: Row(
                children: [
                  Icon(Icons.tune, color: Colors.white),
                  SizedBox(width: 10),
                  Text(
                    "Filter Search",
                    style: TextStyle(fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
              // subtitle: !filterController.isFilterExpanded.value
              //     ? Text(
              //         "Tap to expand filters",
              //         style: TextStyle(fontSize: 12, color: Colors.grey),
              //       )
              //     : null,
              children: [
                const Divider(height: 1),
                const SizedBox(height: 20),

                // -------- Dropdowns --------
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 140,
                      child: Obx(
                        () => DropdownButton<Province>(
                          isExpanded: true,
                          icon: Icon(
                            Icons.gps_fixed_outlined,
                            color: Color(0xffcebbfd),
                          ),
                          value: filterController.selectedProvince.value,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          hint: Text(
                            "Province", style: TextStyle(color: Colors.white),),
                          items: provinces.map((province) {
                            return DropdownMenuItem(
                              value: province,
                              child: Text(province.name),
                            );
                          }).toList(),
                          onChanged: (val) =>
                              filterController.updateProvince(val),
                        ),
                      ),
                    ),

                    IconButton(
                      icon: Icon(Icons.repeat, color: Colors.white),
                      onPressed: filterController.resetFilters,
                    ),

                    SizedBox(
                      width: 140,
                      child: Obx(
                        () => DropdownButton<City>(
                          isExpanded: true,
                          iconDisabledColor: Colors.grey,
                          iconEnabledColor: Color(0xffcebbfd),
                          icon: Icon(Icons.location_city_sharp),
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          value: filterController.selectedCity.value,
                          hint: Text(
                            "City", style: TextStyle(color: Colors.white),),
                          items:
                              filterController.selectedProvince.value?.cities
                                  .map((city) {
                                    return DropdownMenuItem(
                                      value: city,
                                      child: Text(city.name),
                                    );
                                  })
                                  .toList() ??
                              [],
                          onChanged: (val) => filterController.updateCity(val),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                // -------- Price Range --------
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Price Range",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "\$${filterController.priceRange.value.start.round()} - \$${filterController.priceRange.value.end.round()}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ],
                ),
                RangeSlider(
                  values: filterController.priceRange.value,
                  min: 100,
                  max: 5000,
                  activeColor: Color(0xff7120e4),
                  divisions: 50,
                  labels: RangeLabels(
                    "\$${filterController.priceRange.value.start.round()}",
                    "\$${filterController.priceRange.value.end.round()}",
                  ),
                  onChanged: filterController.updatePriceRange,
                ),

                const SizedBox(height: 10),
                const Text(
                  "Bedrooms",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),

                // -------- Bedrooms --------
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(6, (index) {
                      int rooms = index + 1;
                      bool isSelected =
                          filterController.selectedRooms.value == rooms;

                      return GestureDetector(
                        onTap: () =>
                            filterController.updateSelectedRooms(rooms),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: const EdgeInsets.only(right: 10),
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                            color: Get.isDarkMode
                                ? isSelected
                                ? Color(0xff7120e4)
                                      : Color(0xff261f32)
                                : isSelected
                                ? Color(0xff7120e4)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                              color: isSelected
                                  ? Color(0xff7120e4)
                                  : Colors.transparent,
                            ),
                            boxShadow: isSelected
                                ? [
                                    BoxShadow(
                                      color: Theme.of(context).primaryColor,
                                      spreadRadius: 4,
                                      blurRadius: 10,
                                    ),
                                  ]
                                : [],
                          ),
                          child: Center(
                            child: Text(
                              "$rooms",
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : Colors.grey.shade700,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: filterController.applyFilters,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      "Apply Filters",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
