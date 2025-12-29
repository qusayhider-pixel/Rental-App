import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:get/get.dart'; // For ImageFilter


class LuxeStayApp extends StatelessWidget {
  const LuxeStayApp({super.key});

  @override
  Widget build(BuildContext context) {
    Color mainColor = Color(0xff846be7);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LuxeStay',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor:  mainColor, // Gold Color
        scaffoldBackgroundColor: const Color(0xFF0F172A), // Dark Navy
        useMaterial3: true,
        fontFamily: 'Georgia',
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white.withOpacity(0.05),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: mainColor, width: 1.5),
          ),
          labelStyle: TextStyle(color: Colors.white.withOpacity(0.7), fontFamily: 'Sans-serif'),
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.4), fontFamily: 'Sans-serif'),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        ),
      ),
      home: const AddApartmentScreen(),
    );
  }
}

// ==========================================
// الخلفية المشتركة (LuxeBackground)
// ==========================================
class LuxeBackground extends StatelessWidget {
  final Widget child;
  const LuxeBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/Apartments/purple1.jpg',
            fit: BoxFit.cover,
          ),
        ),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors:
                Get.isDarkMode ?
                [
                  Color(0xff41394f).withOpacity(0.6),
                  Color(0xff261f32).withOpacity(0.6)
                ]
                    :
                [
                   Color(0xff894eff).withOpacity(0.3),
                  Color.fromARGB(255, 124, 75, 253).withOpacity(0.3),
                ]
                ,
              ),
            ),
          ),
        ),
        SafeArea(child: child),
      ],
    );
  }
}

// ==========================================
// شاشة إضافة شقة (Add Apartment Screen)
// ==========================================
class AddApartmentScreen extends StatefulWidget {
  const AddApartmentScreen({super.key});

  @override
  State<AddApartmentScreen> createState() => _AddApartmentScreenState();
}

class _AddApartmentScreenState extends State<AddApartmentScreen> {
  Color DarkModeColor = Color(0xff846be7);
  Color LightModeColor = Color(0xD5FFFFFF);

  // بيانات المحافظات والمدن (Mock Data)
  final Map<String, List<String>> _locations = {
    'Damascus': ['Malki', 'Mezzeh', 'Shaalan', 'Old City', 'Dummar'],
    'Aleppo': ['Shahba', 'Mogambo', 'Aziziyah', 'Halab Al-Jadida'],
    'Homs': ['Inshaat', 'Ghouta', 'Hamra', 'Dablan'],
  };

  String? _selectedGovernorate;
  String? _selectedCity;
  List<String> _cities = [];

  // دالة تحديث المدن عند اختيار المحافظة
  void _onGovernorateChanged(String? newValue) {
    setState(() {
      _selectedGovernorate = newValue;
      _cities = newValue != null ? _locations[newValue]! : [];
      _selectedCity = null; // تصفير المدينة عند تغيير المحافظة
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("List Your Property", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: LuxeBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 23),
              _buildSectionHeader("Location Details"),
              const SizedBox(height: 10),

              _buildGlassCard(

                child: Column(
                  children: [

                    _buildDropdown(
                      label: "Governorate",
                      icon: Icons.map_outlined,
                      value: _selectedGovernorate,
                      items: _locations.keys.toList(),
                      onChanged: _onGovernorateChanged,
                    ),
                    const SizedBox(height: 20),
                    // قائمة المدن (تعتمد على المحافظة)
                    _buildDropdown(
                      label: "City / District",
                      icon: Icons.location_city,
                      value: _selectedCity,
                      items: _cities,
                      onChanged: (val) => setState(() => _selectedCity = val),
                      isDisabled: _selectedGovernorate == null,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              _buildSectionHeader("Property Gallery"),
              const SizedBox(height: 5),
              const Text(
                "Upload at least 3 photos to showcase your luxury stay.",
                style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'Sans-serif'),
              ),
              const SizedBox(height: 15),

              // قسم الصور
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildImageUploadBox(label: "Main Photo", isMain: true),
                    const SizedBox(width: 10),
                    _buildImageUploadBox(label: "Living Room"),
                    const SizedBox(width: 10),
                    _buildImageUploadBox(label: "Bedroom"),
                    const SizedBox(width: 10),
                    _buildImageUploadBox(label: "Add More +"),
                  ],
                ),
              ),

              const SizedBox(height: 30),
              _buildSectionHeader("Property Details"),
              const SizedBox(height: 15),

              // كارت التفاصيل (Grid)
              _buildGlassCard(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: _buildTextField(label: "Price / Night", icon: Icons.attach_money, suffix: "\$", inputType: TextInputType.number)),
                        const SizedBox(width: 15),
                        Expanded(child: _buildTextField(label: "Area Size", icon: Icons.square_foot, suffix: "m²", inputType: TextInputType.number)),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(child: _buildCounterField(label: "Rooms", icon: Icons.bed_outlined)),
                        const SizedBox(width: 15),
                        Expanded(child: _buildCounterField(label: "Bathrooms", icon: Icons.bathtub_outlined)),
                      ],
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      maxLines: 4,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: "Description",
                        labelStyle: TextStyle(color: Get.isDarkMode ? DarkModeColor : LightModeColor),
                        alignLabelWithHint: true,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(bottom: 60), // لرفع الأيقونة للأعلى
                          child: Icon(Icons.description_outlined, color:Get.isDarkMode ? DarkModeColor : LightModeColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              _buildGoldButton(label: "Publish Listing", onTap: () {}),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  // ======================
  // Helper Widgets
  // ======================

  Widget _buildSectionHeader(String title) {
    return Text(
      title.toUpperCase(),
      style: TextStyle(
        color:Get.isDarkMode ? DarkModeColor : LightModeColor,
        fontSize: 14,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.2,
        fontFamily: 'Sans-serif',
      ),
    );
  }

  Widget _buildGlassCard({required Widget child}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 8),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Get.isDarkMode ? Color(0xff261f32).withOpacity(0.8) :Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: child,
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required IconData icon,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
    bool isDisabled = false,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      items: items.map((item) => DropdownMenuItem(
        value: item,
        child: Text(item, style:  TextStyle(color: Colors.white)),
      )).toList(),
      onChanged: isDisabled ? null : onChanged,
      dropdownColor:  Color(0xBA8761D2), // Dark Dropdown BG
      borderRadius: BorderRadius.all(Radius.circular(30)),
      icon: Icon(Icons.arrow_drop_down, color:Get.isDarkMode ? DarkModeColor : LightModeColor),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color:   Get.isDarkMode ? DarkModeColor : LightModeColor),
        prefixIcon: Icon(icon, color: isDisabled ? Colors.grey :  Get.isDarkMode ? DarkModeColor : LightModeColor),
      ),
      style: const TextStyle(color: Colors.white, fontFamily: 'Sans-serif'),
    );
  }

  Widget _buildImageUploadBox({required String label, bool isMain = false}) {
    return Column(
      children: [
        Container(
          width: isMain ? 120 : 90,
          height: isMain ? 120 : 90,
          decoration: BoxDecoration(
            color: Get.isDarkMode ? Color(0xff261f32).withOpacity(0.2) : Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
                color: isMain ?  DarkModeColor : Colors.white.withOpacity(0.2),
                style: BorderStyle.solid, // استخدمنا solid بدلاً من dashed
                width: isMain ? 1.5 : 1
            ),
          ),
          child: Center(
            child: Icon(
              Icons.add_a_photo,
              color: isMain ?  DarkModeColor : Colors.white.withOpacity(0.5),
              size: isMain ? 30 : 20,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 15)),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required IconData icon,
    String suffix = "",
    TextInputType inputType = TextInputType.text,
  }) {
    return TextField(
      keyboardType: inputType,
      style:  TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color:  Get.isDarkMode ? DarkModeColor : LightModeColor),
        prefixIcon: Icon(icon, color:  Get.isDarkMode ? DarkModeColor : LightModeColor, size: 20),
        suffixText: suffix,
        suffixStyle: TextStyle(color:Get.isDarkMode ? DarkModeColor : LightModeColor, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildCounterField({required String label, required IconData icon}) {
    return TextField(
      keyboardType: TextInputType.number,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Get.isDarkMode ? DarkModeColor : LightModeColor),
        prefixIcon: Icon(icon, color:  Get.isDarkMode ? DarkModeColor : LightModeColor, size: 20),
      ),
    );
  }

  Widget _buildGoldButton({required String label, required VoidCallback onTap}) {
    return Container(
      width: double.infinity,
      height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        gradient: LinearGradient(
          colors: [DarkModeColor, const Color(0xFFC5A028)], // Gold Gradient
        ),
        boxShadow: [
          BoxShadow(
            color:  DarkModeColor.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}