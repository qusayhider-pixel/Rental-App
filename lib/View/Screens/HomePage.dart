import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controller/FilterController.dart';
import '../../Model/city_model.dart';
import '../../Model/province_model.dart';
import '../Components/ApartmentCard.dart';
import '../Components/CustomDrawer.dart';

// ---------------------------------------------------------------------------
// 1. Theme & App Configuration
// ---------------------------------------------------------------------------
class RentalApp extends StatelessWidget {
   const RentalApp({super.key});


  @override
  Widget build(BuildContext context) {

    return MainScreen();
      // GetMaterialApp(
      // // debugShowCheckedModeBanner: false, // إخفاء شريط Debug
      // // title: 'Premium Rent',
      // // theme: ThemeData(
      // //   useMaterial3: true,
      // //   primaryColor: const Color(0xFF6F35A5),
      // //   textTheme: GoogleFonts.poppinsTextTheme(),
      // //   colorScheme: ColorScheme.fromSeed(
      // //     seedColor: const Color(0xFF6F35A5),
      // //     secondary: const Color(0xcba474fe),
      // //     surface: const Color(0xFFF5F7FA),
      // //   ),
      // //   scaffoldBackgroundColor: const Color(0xFFF5F7FA),
      // //   appBarTheme: const AppBarTheme(
      // //     backgroundColor: Colors.transparent,
      // //     elevation: 0,
      // //     centerTitle: true,
      // //     iconTheme: IconThemeData(color: Color(0xFF6F35A5)),
      // //     titleTextStyle: TextStyle(
      // //       color: Color(0xFF6F35A5),
      // //       fontSize: 20,
      // //       fontWeight: FontWeight.bold,
      // //     ),
      // //   ),
      // // ),
      // home: MainScreen(),
    // );
  }
}

// ---------------------------------------------------------------------------
// 3. Main Screen
// ---------------------------------------------------------------------------
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});


  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  FilterController filterController = Get.put(FilterController());
  RangeValues _currentPriceRange = const RangeValues(200, 2000);
  int _selectedRooms = 2;
  bool _isFilterExpanded = false;

  @override
  Widget build(BuildContext context) {

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
                  colors: <Color>[Color(0xff5a00ff), Color(0xffBF9BFF)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ).createShader(Rect.fromLTWH(0.0, 0.0, 300.0, 70.0)),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Get.isDarkMode ?  Icon(Icons.wb_sunny_sharp):Icon(Icons.dark_mode_sharp),
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

      drawer:  CustomDrawer(),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filter Section
            _buildFilterSection(),

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
                  TextButton(onPressed: () {}, child: Text("See All")),
                ],
              ),
            ),

            // List
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              itemCount: sampleApartments.length,
              itemBuilder: (context, index) {
                return ApartmentCard(apartment: sampleApartments[index]);
              },
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterSection() {
    FilterController filterController = Get.put(FilterController());

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        gradient: Get.isDarkMode
            ? LinearGradient(
                colors: [Color(0xff41394f), Color(0xff261f32)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : //light  mode
              LinearGradient(
                colors: [
                  Color.fromARGB(245, 255, 255, 255),
                  const Color.fromARGB(171, 255, 255, 255),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
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
          borderRadius: BorderRadius.circular(24),
          child: ExpansionTile(
            initiallyExpanded: false,
            onExpansionChanged: (expanded) {
              setState(() {
                _isFilterExpanded = expanded;
              });
            },
            tilePadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 8,
            ),
            childrenPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            title: Row(
              children: [
                Icon(Icons.tune),
                const SizedBox(width: 10),
                Text(
                  "Filter Search",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            subtitle: !_isFilterExpanded
                ? const Text(
                    "Tap to expand filters",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  )
                : null,
            children: [
              const Divider(height: 1),
              const SizedBox(height: 20),




              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [

                  SizedBox(
                    width: 140,
                    child: Obx(() => DropdownButton<Province>(
                      icon: Icon(Icons.gps_fixed_outlined , color: Colors.teal),
                      value: filterController.selectedProvince.value,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      hint: Text("  Province \t"),
                      items: filterController.provinces.map((province) {
                        return DropdownMenuItem(
                          value: province,
                          child: Text(province.name),
                        );
                      }).toList(),
                      onChanged: (val) => filterController.updateProvince(val),
                    )),
                  ),


                  SizedBox(
                    width: 140,
                    child: Obx(() => DropdownButton<City>(
                      iconDisabledColor: Colors.grey,
                      iconEnabledColor: Colors.teal,
                      icon: Icon(Icons.location_city_sharp ),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      value: filterController.selectedCity.value,
                      hint: Text("  City \t"),
                      items: filterController.selectedProvince.value?.cities.map((city) {
                        return DropdownMenuItem(
                          value: city,
                          child: Text(city.name),
                        );
                      }).toList() ?? [],
                      onChanged: (val) => filterController.updateCity(val),
                    )),
                  ),
                ]),






              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Price Range",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "\$${_currentPriceRange.start.round()} - \$${_currentPriceRange.end.round()}",
                    style: TextStyle(
                      // color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              RangeSlider(
                values: _currentPriceRange,
                min: 100,
                max: 5000,
                divisions: 50,
                // activeColor: Theme.of(context).primaryColor,
                // inactiveColor: Colors.grey[200],
                labels: RangeLabels(
                  "\$${_currentPriceRange.start.round()}",
                  "\$${_currentPriceRange.end.round()}",
                ),
                onChanged: (RangeValues values) {
                  setState(() {
                    _currentPriceRange = values;
                  });
                },
              ),

              const SizedBox(height: 10),
              const Text(
                "Bedrooms",
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(5, (index) {
                    int rooms = index + 1;
                    bool isSelected = _selectedRooms == rooms;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedRooms = rooms),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.only(right: 10),
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          color: Get.isDarkMode
                              ? isSelected
                                    ? Color.fromARGB(195, 208, 188, 255)
                                    : Color(0xff261f32)
                              : isSelected //light mode
                              ? Color(0xff594ba0)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            color: isSelected
                                ? Color(0xff594ba0)
                                : Colors.transparent,
                          ),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: Theme.of(context).primaryColor,
                                    spreadRadius: 4,
                                    blurRadius: 10,
                                    // offset: const Offset(0, 4),
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
                  onPressed: () {


                  },
                  style: ElevatedButton.styleFrom(
                    // backgroundColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    "Apply Filters",
                    style: TextStyle(
                      // color: Colors.white,
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
    );
  }
}
