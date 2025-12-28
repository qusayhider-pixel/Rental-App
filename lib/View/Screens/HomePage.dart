import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Components/ApartmentCard.dart';
import '../Components/CustomDrawer.dart';

// ---------------------------------------------------------------------------
// 1. Theme & App Configuration
// ---------------------------------------------------------------------------
class RealEstateApp extends StatelessWidget {
   RealEstateApp({super.key});

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
// 2. Data Model
// ---------------------------------------------------------------------------
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
    location: 'Zamalek, Cairo',
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
    location: 'Downtown, Alexandria',
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
    location: 'New Cairo, Cairo',
    beds: 4,
    baths: 3,
    area: 250,
    ownerName: 'Mosab Abu Draaaa',
    ownerPhone: '0938362405',
    ownerImageUrl:
        'https://images.pexels.com/photos/91227/pexels-photo-91227.jpeg?auto=compress&cs=tinysrgb&w=200',
  ),
];

// ---------------------------------------------------------------------------
// 3. Main Screen
// ---------------------------------------------------------------------------
class MainScreen extends StatefulWidget {

  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

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
            color: Color.fromARGB(156, 133, 2, 255),
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
                spacing: 10,
                children: [
                  Expanded(child: _buildMockDropdown("Governorate", Icons.map)),
                  Expanded(
                    child: _buildMockDropdown("City", Icons.location_city),
                  ),
                ],
              ),
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
                  onPressed: () {},
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

  Widget _buildMockDropdown(String hint, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        // color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            // color: const Color.fromARGB(255, 168, 167, 167)
          ),
          const SizedBox(width: 8),
          Text(
            hint,
            style: TextStyle(
              // color: const Color.fromARGB(255, 186, 186, 186),
              fontSize: 13,
            ),
          ),
          const Spacer(),
          Icon(
            Icons.keyboard_arrow_down,
            size: 18,
            //  color: Colors.grey[600]
          ),
        ],
      ),
    );
  }
}
