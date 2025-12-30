import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:get/get.dart';
import 'package:uni_project/Controller/FilterController.dart';
import '../../Model/city_model.dart';
import '../../Model/province_model.dart';

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
                   Color(0xffffffff).withOpacity(0.7),
                  Color.fromARGB(255, 124, 75, 253).withOpacity(0.5),
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


class AddApartmentScreen extends StatefulWidget {
  const AddApartmentScreen({super.key});

  @override
  State<AddApartmentScreen> createState() => _AddApartmentScreenState();
}

class _AddApartmentScreenState extends State<AddApartmentScreen> {
  Color DarkModeColor = Color(0xff846be7);
  Color LightModeColor = Color(0xFF2A2A2A);
  FilterController filterController = Get.find();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("List Your Property", style: TextStyle(color: Get.isDarkMode ? Colors.white : Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Get.isDarkMode ? Colors.white : Colors.black),
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
                    SizedBox(width: 400, child: Obx(() => DropdownButton<Province>(
                        isExpanded: true,
                        icon: Icon(Icons.gps_fixed_outlined, color: Color(0xffcebbfd)),
                        value: filterController.selectedProvince.value,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        hint: Text("  Province \t"),
                        items: provinces.map((province) {
                          return DropdownMenuItem(
                            value: province,
                            child:
                            Text(province.name),
                          );
                        }).toList(), onChanged: (val) => filterController.updateProvince(val),
                      )),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(width: 400, child: Obx(() => DropdownButton<City>(
                        isExpanded: true,
                        iconDisabledColor: Colors.grey,
                        iconEnabledColor:
                        Color(0xffcebbfd),
                        icon: Icon(Icons.location_city_sharp),
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        value: filterController.selectedCity.value,
                        hint: Text("  City \t"),
                        items: filterController.selectedProvince.value?.cities.map((city) {
                          return DropdownMenuItem(value: city, child: Text(city.name),);}).toList() ?? [],
                        onChanged: (val) => filterController.updateCity(val),
                      )),
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
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Get.isDarkMode ? Color(0xff261f32).withOpacity(0.8) :Colors.white.withOpacity(0.6),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: child,
        ),
      ),
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