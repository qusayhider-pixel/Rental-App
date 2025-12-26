// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
//
// import 'ApartmentDetailsScreen.dart'; // IMPORTANT: You need to add 'intl' package to pubspec.yaml for date formatting
//
// // ---------------------------------------------------------------------------
// // 1. Theme & App Configuration
// // ---------------------------------------------------------------------------
// class RealEstateApp2 extends StatelessWidget {
//   const RealEstateApp2({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Premium Rent',
//       theme: ThemeData(
//         useMaterial3: true,
//         primaryColor: const Color(0xFF1E3C72), // Premium Deep Blue
//         colorScheme: ColorScheme.fromSeed(
//           seedColor: const Color(0xFF1E3C72),
//           secondary: const Color(0xFF2A5298),
//           surface: const Color(0xFFF5F7FA), // Light Grey Background
//         ),
//         scaffoldBackgroundColor: const Color(0xFFF5F7FA),
//         appBarTheme: const AppBarTheme(
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           centerTitle: true,
//           iconTheme: IconThemeData(color: Color(0xFF1E3C72)),
//           titleTextStyle: TextStyle(
//             color: Color(0xFF1E3C72),
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         // Fixing font family issue if not available locally, using standard
//         fontFamily: 'Roboto',
//       ),
//       home: const MainScreen(),
//     );
//   }
// }
//
// // ---------------------------------------------------------------------------
// // 2. Data Model (Updated)
// // ---------------------------------------------------------------------------
// class Apartment {
//   final String id;
//   final String title;
//   final String description;
//   final List<String> imageUrls; // Changed from single URL to a List of URLs
//   final double price;
//   final String location;
//   final int beds;
//   final int baths;
//   final int area;
//   // New Owner Info Fields
//   final String ownerName;
//   final String ownerPhone;
//   final String ownerImageUrl;
//
//   Apartment({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.imageUrls, // Updated
//     required this.price,
//     required this.location,
//     required this.beds,
//     required this.baths,
//     required this.area,
//     required this.ownerName, // New
//     required this.ownerPhone, // New
//     required this.ownerImageUrl, // New
//   });
// }
//
// // Sample Data (Updated with multiple images and owner info)
// final List<Apartment> sampleApartments = [
//   Apartment(
//     id: '1',
//     title: 'Luxury Nile View Apartment',
//     description:
//         'A stunning modern apartment with a direct view of the Nile. Fully furnished with high-end amenities. Located in the heart of Zamalek, close to top restaurants and cafes.',
//     imageUrls: [
//       'https://images.pexels.com/photos/1571460/pexels-photo-1571460.jpeg?auto=compress&cs=tinysrgb&w=800',
//       'https://images.pexels.com/photos/271624/pexels-photo-271624.jpeg?auto=compress&cs=tinysrgb&w=800',
//       'https://images.pexels.com/photos/1918291/pexels-photo-1918291.jpeg?auto=compress&cs=tinysrgb&w=800',
//     ],
//     price: 1200.0,
//     location: 'Zamalek, Cairo',
//     beds: 3,
//     baths: 2,
//     area: 180,
//     ownerName: 'Karim Essam',
//     ownerPhone: '+20 100 234 5678',
//     ownerImageUrl:
//         'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=200',
//   ),
//   Apartment(
//     id: '2',
//     title: 'Modern Studio in Downtown',
//     description:
//         'Perfect for professionals. Close to all business hubs and metro stations. Minimalist design with smart home features.',
//     imageUrls: [
//       'https://images.pexels.com/photos/276724/pexels-photo-276724.jpeg?auto=compress&cs=tinysrgb&w=800',
//       'https://images.pexels.com/photos/276583/pexels-photo-276583.jpeg?auto=compress&cs=tinysrgb&w=800',
//       'https://images.pexels.com/photos/1571459/pexels-photo-1571459.jpeg?auto=compress&cs=tinysrgb&w=800',
//     ],
//     price: 450.0,
//     location: 'Downtown, Alexandria',
//     beds: 1,
//     baths: 1,
//     area: 75,
//     ownerName: 'Mona Ahmed',
//     ownerPhone: '+20 122 987 6543',
//     ownerImageUrl:
//         'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=200',
//   ),
//   Apartment(
//     id: '3',
//     title: 'Cozy Family House',
//     description:
//         'Spacious garden, quiet neighborhood, and close to international schools. Ideal for families looking for tranquility.',
//     imageUrls: [
//       'https://images.pexels.com/photos/1643383/pexels-photo-1643383.jpeg?auto=compress&cs=tinysrgb&w=800',
//       'https://images.pexels.com/photos/1643389/pexels-photo-1643389.jpeg?auto=compress&cs=tinysrgb&w=800',
//       'https://images.pexels.com/photos/259588/pexels-photo-259588.jpeg?auto=compress&cs=tinysrgb&w=800',
//     ],
//     price: 850.0,
//     location: 'New Cairo, Cairo',
//     beds: 4,
//     baths: 3,
//     area: 250,
//     ownerName: 'Mosab Abu Draaaa',
//     ownerPhone: '0938362405',
//     ownerImageUrl:
//         'https://images.pexels.com/photos/91227/pexels-photo-91227.jpeg?auto=compress&cs=tinysrgb&w=200',
//   ),
// ];
//
// // ---------------------------------------------------------------------------
// // 3. Main Screen (Unchanged mostly)
// // ---------------------------------------------------------------------------
// class MainScreen extends StatefulWidget {
//   const MainScreen({super.key});
//
//   @override
//   State<MainScreen> createState() => _MainScreenState();
// }
//
// class _MainScreenState extends State<MainScreen> {
//   RangeValues _currentPriceRange = const RangeValues(200, 2000);
//   int _selectedRooms = 2;
//   bool _isFilterExpanded = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: false,
//       appBar: AppBar(
//         title: const Text("LuxeStay"),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.notifications_outlined),
//             onPressed: () {},
//           ),
//           const SizedBox(width: 8),
//         ],
//       ),
//       drawer: const CustomDrawer(),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildFilterSection(),
//             const SizedBox(height: 20),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "Featured Properties",
//                     style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black87,
//                     ),
//                   ),
//                   TextButton(onPressed: () {}, child: const Text("See All")),
//                 ],
//               ),
//             ),
//             ListView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//               itemCount: sampleApartments.length,
//               itemBuilder: (context, index) {
//                 return ApartmentCard(apartment: sampleApartments[index]);
//               },
//             ),
//             const SizedBox(height: 30),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildFilterSection() {
//     return Container(
//       margin: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(24),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             blurRadius: 20,
//             offset: const Offset(0, 10),
//           ),
//         ],
//       ),
//       // Theme wrapper to remove default dividers of ExpansionTile
//       child: Theme(
//         data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(24),
//           child: ExpansionTile(
//             initiallyExpanded: false, // Collapsed by default to save space
//             onExpansionChanged: (expanded) {
//               setState(() {
//                 _isFilterExpanded = expanded;
//               });
//             },
//             tilePadding: const EdgeInsets.symmetric(
//               horizontal: 20,
//               vertical: 8,
//             ),
//             childrenPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
//             title: Row(
//               children: [
//                 Icon(
//                   Icons.tune,
//                   color: _isFilterExpanded
//                       ? Theme.of(context).primaryColor
//                       : Colors.black87,
//                 ),
//                 const SizedBox(width: 10),
//                 Text(
//                   "Filter Search",
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     color: _isFilterExpanded
//                         ? Theme.of(context).primaryColor
//                         : Colors.black87,
//                   ),
//                 ),
//               ],
//             ),
//             subtitle: !_isFilterExpanded
//                 ? const Text(
//                     "Tap to expand filters",
//                     style: TextStyle(fontSize: 12, color: Colors.grey),
//                   )
//                 : null,
//             children: [
//               const Divider(height: 1), // Subtle divider inside
//               const SizedBox(height: 20),
//               // Location Dropdowns Row
//               Row(
//                 children: [
//                   Expanded(child: _buildMockDropdown("Governorate", Icons.map)),
//                   const SizedBox(width: 10),
//                   Expanded(
//                     child: _buildMockDropdown("City", Icons.location_city),
//                   ),
//                 ],
//               ),
//
//               const SizedBox(height: 15),
//
//               // Price Range Slider
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Text(
//                     "Price Range",
//                     style: TextStyle(
//                       color: Colors.grey,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   Text(
//                     "\$${_currentPriceRange.start.round()} - \$${_currentPriceRange.end.round()}",
//                     style: TextStyle(
//                       color: Theme.of(context).primaryColor,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//               RangeSlider(
//                 values: _currentPriceRange,
//                 min: 100,
//                 max: 5000,
//                 divisions: 50,
//                 activeColor: Theme.of(context).primaryColor,
//                 inactiveColor: Colors.grey[200],
//                 labels: RangeLabels(
//                   "\$${_currentPriceRange.start.round()}",
//                   "\$${_currentPriceRange.end.round()}",
//                 ),
//                 onChanged: (RangeValues values) {
//                   setState(() {
//                     _currentPriceRange = values;
//                   });
//                 },
//               ),
//
//               // Rooms Selector
//               const SizedBox(height: 10),
//               const Text(
//                 "Bedrooms",
//                 style: TextStyle(
//                   color: Colors.grey,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               const SizedBox(height: 10),
//               SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Row(
//                   children: List.generate(5, (index) {
//                     int rooms = index + 1;
//                     bool isSelected = _selectedRooms == rooms;
//                     return GestureDetector(
//                       onTap: () => setState(() => _selectedRooms = rooms),
//                       child: AnimatedContainer(
//                         duration: const Duration(milliseconds: 200),
//                         margin: const EdgeInsets.only(right: 10),
//                         width: 45,
//                         height: 45,
//                         decoration: BoxDecoration(
//                           color: isSelected
//                               ? Theme.of(context).primaryColor
//                               : Colors.white,
//                           borderRadius: BorderRadius.circular(12),
//                           border: Border.all(
//                             color: isSelected
//                                 ? Theme.of(context).primaryColor
//                                 : Colors.grey.shade300,
//                           ),
//                           boxShadow: isSelected
//                               ? [
//                                   BoxShadow(
//                                     color: Theme.of(
//                                       context,
//                                     ).primaryColor.withOpacity(0.3),
//                                     blurRadius: 8,
//                                     offset: const Offset(0, 4),
//                                   ),
//                                 ]
//                               : [],
//                         ),
//                         child: Center(
//                           child: Text(
//                             "$rooms",
//                             style: TextStyle(
//                               color: isSelected
//                                   ? Colors.white
//                                   : Colors.grey.shade700,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   }),
//                 ),
//               ),
//
//               const SizedBox(height: 20),
//               SizedBox(
//                 width: double.infinity,
//                 height: 50,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     // Logic to collapse after applying could go here
//                     // e.g., ExpansionTileController (advanced) or just leave it open
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Theme.of(context).primaryColor,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(14),
//                     ),
//                     elevation: 0,
//                   ),
//                   child: const Text(
//                     "Apply Filters",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildMockDropdown(String hint, IconData icon) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//       decoration: BoxDecoration(
//         color: Colors.grey[100],
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Row(
//         children: [
//           Icon(icon, size: 18, color: Colors.grey[600]),
//           const SizedBox(width: 8),
//           Text(hint, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
//           const Spacer(),
//           Icon(Icons.keyboard_arrow_down, size: 18, color: Colors.grey[600]),
//         ],
//       ),
//     );
//   }
// }
//
// // ---------------------------------------------------------------------------
// // 4. Custom Drawer (Unchanged)
// // ---------------------------------------------------------------------------
// class CustomDrawer extends StatelessWidget {
//   const CustomDrawer({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: Column(
//         children: [
//           Container(
//             padding: const EdgeInsets.only(top: 60, left: 20, bottom: 20),
//             width: double.infinity,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   Theme.of(context).primaryColor,
//                   Theme.of(context).colorScheme.secondary,
//                 ],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(3),
//                   decoration: const BoxDecoration(
//                     color: Colors.white,
//                     shape: BoxShape.circle,
//                   ),
//                   child: const CircleAvatar(
//                     radius: 35,
//                     backgroundImage: NetworkImage(
//                       'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=200',
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 15),
//                 const Text(
//                   "Ahmed Mohamed",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const Text(
//                   "ahmed.dev@example.com",
//                   style: TextStyle(color: Colors.white70, fontSize: 14),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 10),
//           _buildDrawerItem(Icons.person_outline, "My Profile"),
//           _buildDrawerItem(Icons.add_home_outlined, "Add Apartment"),
//           _buildDrawerItem(Icons.bookmark_border, "My Reservations"),
//           _buildDrawerItem(
//             Icons.manage_accounts_outlined,
//             "Reservation Management",
//           ),
//           const Divider(thickness: 1, indent: 20, endIndent: 20),
//           _buildDrawerItem(Icons.logout, "Logout", isDestructive: true),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildDrawerItem(
//     IconData icon,
//     String title, {
//     bool isDestructive = false,
//   }) {
//     return ListTile(
//       leading: Icon(
//         icon,
//         color: isDestructive ? Colors.redAccent : Colors.grey[700],
//       ),
//       title: Text(
//         title,
//         style: TextStyle(
//           color: isDestructive ? Colors.redAccent : Colors.black87,
//           fontWeight: FontWeight.w500,
//         ),
//       ),
//       onTap: () {},
//     );
//   }
// }
//
// // ---------------------------------------------------------------------------
// // 5. Apartment Listing Card (Updated for Navigation and new Model)
// // ---------------------------------------------------------------------------
// class ApartmentCard extends StatelessWidget {
//   final Apartment apartment;
//
//   const ApartmentCard({super.key, required this.apartment});
//
//   @override
//   Widget build(BuildContext context) {
//     // Wrap the entire card with GestureDetector for navigation
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => ApartmentDetailsScreen(apartment: apartment),
//           ),
//         );
//       },
//       child: Container(
//         margin: const EdgeInsets.only(bottom: 24),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(20),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.08),
//               spreadRadius: 2,
//               blurRadius: 15,
//               offset: const Offset(0, 5),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Stack(
//               children: [
//                 ClipRRect(
//                   borderRadius: const BorderRadius.vertical(
//                     top: Radius.circular(20),
//                   ),
//                   // Use the first image from the list for the card thumbnail
//                   child: Image.network(
//                     apartment.imageUrls.isNotEmpty
//                         ? apartment.imageUrls[0]
//                         : '',
//                     height: 200,
//                     width: double.infinity,
//                     fit: BoxFit.cover,
//                     errorBuilder: (context, error, stackTrace) {
//                       return Container(
//                         height: 200,
//                         color: Colors.grey[300],
//                         child: const Center(child: Icon(Icons.error)),
//                       );
//                     },
//                   ),
//                 ),
//                 Positioned(
//                   top: 15,
//                   right: 15,
//                   child: Container(
//                     padding: const EdgeInsets.all(8),
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.9),
//                       shape: BoxShape.circle,
//                     ),
//                     child: const Icon(
//                       Icons.favorite_border,
//                       color: Colors.red,
//                       size: 20,
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   bottom: 15,
//                   left: 15,
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 10,
//                       vertical: 5,
//                     ),
//                     decoration: BoxDecoration(
//                       color: Theme.of(context).primaryColor.withOpacity(0.9),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Text(
//                       "\$${apartment.price.toInt()}/night", // Changed to /night
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       const Icon(
//                         Icons.location_on,
//                         size: 16,
//                         color: Colors.grey,
//                       ),
//                       const SizedBox(width: 4),
//                       Text(
//                         apartment.location,
//                         style: const TextStyle(
//                           color: Colors.grey,
//                           fontSize: 13,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     apartment.title,
//                     style: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black87,
//                     ),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   const SizedBox(height: 6),
//                   Text(
//                     apartment.description,
//                     style: TextStyle(
//                       fontSize: 13,
//                       color: Colors.grey[600],
//                       height: 1.4,
//                     ),
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   const SizedBox(height: 15),
//                   const Divider(height: 1),
//                   const SizedBox(height: 12),
//
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       // Reusing a static helper method for features
//                       ApartmentDetailsScreen._buildFeatureIcon(
//                         Icons.bed_outlined,
//                         "${apartment.beds} Beds",
//                       ),
//                       ApartmentDetailsScreen._buildFeatureIcon(
//                         Icons.bathtub_outlined,
//                         "${apartment.baths} Bath",
//                       ),
//                       ApartmentDetailsScreen._buildFeatureIcon(
//                         Icons.square_foot_outlined,
//                         "${apartment.area} m²",
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class ApartmentDetailsScreen extends StatefulWidget {
//   final Apartment apartment;
//
//   ApartmentDetailsScreen({super.key, required this.apartment});
//
//   // Helper method exposed for reuse in ApartmentCard
//   static Widget _buildFeatureIcon(IconData icon, String label) {
//     return Row(
//       children: [
//         Icon(icon, size: 18, color: Colors.grey[500]),
//         const SizedBox(width: 6),
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: 13,
//             color: Colors.grey[700],
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ],
//     );
//   }
//
//   @override
//   State<ApartmentDetailsScreen> createState() => _ApartmentDetailsScreenState();
// }
//
//
// class _ApartmentDetailsScreenState extends State<ApartmentDetailsScreen> {
//   DateTimeRange? _selectedDateRange;
//
//   // Function to show date picker and update state
//   Future<void> _selectDates(BuildContext context) async {
//     final DateTime now = DateTime.now();
//     final DateTimeRange? picked = await showDateRangePicker(
//       context: context,
//       firstDate: now,
//       lastDate: DateTime(now.year + 1), // Allow booking up to 1 year ahead
//       initialDateRange: _selectedDateRange,
//       builder: (context, child) {
//         return Theme(
//           data: Theme.of(context).copyWith(
//             colorScheme: ColorScheme.light(
//               primary: Theme.of(
//                 context,
//               ).primaryColor, // Header background color
//               onPrimary: Colors.white, // Header text color
//               onSurface: Colors.black, // Body text color
//             ),
//             textButtonTheme: TextButtonThemeData(
//               style: TextButton.styleFrom(
//                 foregroundColor: Theme.of(
//                   context,
//                 ).primaryColor, // Button text color
//               ),
//             ),
//           ),
//           child: child!,
//         );
//       },
//     );
//
//     if (picked != null && picked != _selectedDateRange) {
//       setState(() {
//         _selectedDateRange = picked;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final apartment = widget.apartment;
//     final int nights = _selectedDateRange?.duration.inDays ?? 0;
//     final double totalPrice = nights * apartment.price;
//     // Using intl package for formatting would be better, but simple approach for now:
//     // Make sure to add 'intl: ^0.18.1' (or newer) to your pubspec.yaml dependencies.
//     final DateFormat formatter = DateFormat('MMM dd, yyyy');
//
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Main Content scrollable
//           SingleChildScrollView(
//             padding: const EdgeInsets.only(bottom: 100), // Space for bottom bar
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // --- Image Gallery (PageView) ---
//                 SizedBox(
//                   height: 300,
//                   child: PageView.builder(
//                     itemCount: apartment.imageUrls.length,
//                     itemBuilder: (context, index) {
//                       return Image.network(
//                         apartment.imageUrls[index],
//                         fit: BoxFit.cover,
//                         errorBuilder: (context, error, stackTrace) => Container(
//                           color: Colors.grey[300],
//                           child: const Icon(Icons.error),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//
//                 Padding(
//                   padding: const EdgeInsets.all(20.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Title and Location
//                       Text(
//                         apartment.title,
//                         style: const TextStyle(
//                           fontSize: 24,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Row(
//                         children: [
//                           Icon(
//                             Icons.location_on,
//                             size: 16,
//                             color: Theme.of(context).primaryColor,
//                           ),
//                           const SizedBox(width: 4),
//                           Text(
//                             apartment.location,
//                             style: const TextStyle(
//                               color: Colors.grey,
//                               fontSize: 15,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 20),
//
//                       // --- Specs Row ---
//                       Container(
//                         padding: const EdgeInsets.all(16),
//                         decoration: BoxDecoration(
//                           color: Colors.grey[100],
//                           borderRadius: BorderRadius.circular(16),
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             ApartmentDetailsScreen._buildFeatureIcon(
//                               Icons.bed_outlined,
//                               "${apartment.beds} Beds",
//                             ),
//                             ApartmentDetailsScreen._buildFeatureIcon(
//                               Icons.bathtub_outlined,
//                               "${apartment.baths} Baths",
//                             ),
//                             ApartmentDetailsScreen._buildFeatureIcon(
//                               Icons.square_foot_outlined,
//                               "${apartment.area} m²",
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//
//                       // --- Description ---
//                       const Text(
//                         "Description",
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       Text(
//                         apartment.description,
//                         style: TextStyle(
//                           fontSize: 15,
//                           color: Colors.grey[700],
//                           height: 1.5,
//                         ),
//                       ),
//                       const SizedBox(height: 25),
//
//                       // --- Owner Info ---
//                       const Text(
//                         "Owner Information",
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 15),
//                       Row(
//                         children: [
//                           CircleAvatar(
//                             radius: 30,
//                             backgroundImage: NetworkImage(
//                               apartment.ownerImageUrl,
//                             ),
//                             onBackgroundImageError: (_, __) =>
//                             const Icon(Icons.person),
//                           ),
//                           const SizedBox(width: 15),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 apartment.ownerName,
//                                 style: const TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               const SizedBox(height: 5),
//                               Row(
//                                 children: [
//                                   const Icon(
//                                     Icons.phone,
//                                     size: 16,
//                                     color: Colors.grey,
//                                   ),
//                                   const SizedBox(width: 5),
//                                   Text(
//                                     apartment.ownerPhone,
//                                     style: const TextStyle(color: Colors.grey),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                           const Spacer(),
//                           IconButton(
//                             onPressed: () {}, // Mock call action
//                             icon: Container(
//                               padding: const EdgeInsets.all(8),
//                               decoration: BoxDecoration(
//                                 color: Colors.green[50],
//                                 shape: BoxShape.circle,
//                               ),
//                               child: const Icon(
//                                 Icons.phone,
//                                 color: Colors.green,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 30),
//                       Divider(color: Colors.grey[300]),
//                       const SizedBox(height: 20),
//
//                       // --- Date Picker Section ---
//                       const Text(
//                         "Select Dates",
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 15),
//                       InkWell(
//                         onTap: () => _selectDates(context),
//                         borderRadius: BorderRadius.circular(12),
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(
//                             vertical: 16,
//                             horizontal: 20,
//                           ),
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.grey.shade300),
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Row(
//                                 children: [
//                                   Icon(
//                                     Icons.calendar_today_outlined,
//                                     color: Theme.of(context).primaryColor,
//                                   ),
//                                   const SizedBox(width: 12),
//                                   Text(
//                                     _selectedDateRange == null
//                                         ? "Check-in  →  Check-out"
//                                         : "${formatter.format(_selectedDateRange!.start)}  →  ${formatter.format(_selectedDateRange!.end)}",
//                                     style: TextStyle(
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.w500,
//                                       color: _selectedDateRange == null
//                                           ? Colors.grey
//                                           : Colors.black87,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const Icon(
//                                 Icons.arrow_forward_ios,
//                                 size: 16,
//                                 color: Colors.grey,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//
//                       // Calculation Summary
//                       if (_selectedDateRange != null) ...[
//                         const SizedBox(height: 20),
//                         Container(
//                           padding: const EdgeInsets.all(16),
//                           decoration: BoxDecoration(
//                             color: Theme.of(
//                               context,
//                             ).primaryColor.withOpacity(0.05),
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: Column(
//                             children: [
//                               Row(
//                                 mainAxisAlignment:
//                                 MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     "$nights nights x \$${apartment.price.toInt()}",
//                                     style: const TextStyle(fontSize: 15),
//                                   ),
//                                   Text(
//                                     "\$${totalPrice.toInt()}",
//                                     style: const TextStyle(
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: 10),
//                               Divider(color: Colors.grey[300]),
//                               const SizedBox(height: 10),
//                               Row(
//                                 mainAxisAlignment:
//                                 MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   const Text(
//                                     "Total (USD)",
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   Text(
//                                     "\$${totalPrice.toInt()}",
//                                     style: TextStyle(
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.bold,
//                                       color: Theme.of(context).primaryColor,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//           // --- Custom Back Button (Top Left) ---
//           Positioned(
//             top: 50,
//             left: 20,
//             child: GestureDetector(
//               onTap: () => Navigator.pop(context),
//               child: Container(
//                 padding: const EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   shape: BoxShape.circle,
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.1),
//                       blurRadius: 8,
//                     ),
//                   ],
//                 ),
//                 child: const Icon(Icons.arrow_back_ios_new, size: 20),
//               ),
//             ),
//           ),
//
//           // --- Bottom Booking Bar ---
//           Positioned(
//             bottom: 0,
//             left: 0,
//             right: 0,
//             child: Container(
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.05),
//                     blurRadius: 10,
//                     offset: const Offset(0, -5),
//                   ),
//                 ],
//               ),
//               child: Row(
//                 children: [
//                   // Price display on the left
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text(
//                         "Price per night",
//                         style: TextStyle(color: Colors.grey, fontSize: 12),
//                       ),
//                       RichText(
//                         text: TextSpan(
//                           children: [
//                             TextSpan(
//                               text: "\$${apartment.price.toInt()}",
//                               style: TextStyle(
//                                 fontSize: 22,
//                                 fontWeight: FontWeight.bold,
//                                 color: Theme.of(context).primaryColor,
//                               ),
//                             ),
//                             const TextSpan(
//                               text: "/night",
//                               style: TextStyle(color: Colors.grey),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(width: 20),
//                   // Booking Button
//                   Expanded(
//                     child: SizedBox(
//                       height: 50,
//                       child: ElevatedButton(
//                         onPressed: _selectedDateRange == null
//                             ? null // Disable if no dates selected
//                             : () {
//                           // Show confirmation message
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(
//                               content: Text(
//                                 "Booking confirmed for $nights nights! Total: \$${totalPrice.toInt()}",
//                               ),
//                               backgroundColor: Colors.green,
//                               behavior: SnackBarBehavior.floating,
//                             ),
//                           );
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Theme.of(context).primaryColor,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(14),
//                           ),
//                           elevation: 0,
//                           disabledBackgroundColor: Colors.grey[300],
//                         ),
//                         child: const Text(
//                           "Book Now",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//
