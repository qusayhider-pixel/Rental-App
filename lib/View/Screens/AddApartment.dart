import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:uni_project/Controller/ApartmentDetailsController.dart';

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
                colors: Get.isDarkMode
                    ? [
                        Color(0xff41394f).withOpacity(0.6),
                        Color(0xff261f32).withOpacity(0.6),
                      ]
                    : [
                  Color.fromARGB(255, 124, 75, 253).withOpacity(0.5),
                        Color(0xffffffff).withOpacity(0.7),
                      ],
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
  ApartmentDetailsController apartmentController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          "List Your Property",
          style: TextStyle(
            color: Get.isDarkMode ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
              fontFamily: 'Multicolore',
              fontSize: 18
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Get.isDarkMode ? Colors.white : Colors.black,
          ),
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
                    //------------------drop downs--------------------------
                    SizedBox(
                      width: 400,
                      child: Obx(
                        () => DropdownButton<Province>(
                          isExpanded: true,
                          icon: Icon(
                            Icons.gps_fixed_outlined,
                            color: Color(0xffcebbfd),
                          ),
                          value: apartmentController.selectedProvince.value,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          hint: Text("  Province \t"),
                          items: provinces.map((province) {
                            return DropdownMenuItem(
                              value: province,
                              child: Text(province.name),
                            );
                          }).toList(),
                          onChanged: (val) =>
                              apartmentController.updateProvince(val),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 400,
                      child: Obx(
                        () => DropdownButton<City>(
                          isExpanded: true,
                          iconDisabledColor: Colors.grey,
                          iconEnabledColor: Color(0xffcebbfd),
                          icon: Icon(Icons.location_city_sharp),
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          value: apartmentController.selectedCity.value,
                          hint: Text("  City \t"),
                          items:
                              apartmentController.selectedProvince.value?.cities
                                  .map((city) {
                                    return DropdownMenuItem(
                                      value: city,
                                      child: Text(city.name),
                                    );
                                  })
                                  .toList() ??
                              [],
                          onChanged: (val) =>
                              apartmentController.updateCity(val),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //----------------------apartment images section-------------------
              const SizedBox(height: 20),
              _buildSectionHeader("Property Gallery"),
              const SizedBox(height: 5),
              const Text(
                "Upload at least 3 photos to showcase your luxury stay.",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Sans-serif',
                ),
              ),
              const SizedBox(height: 15),

              // قسم الصور
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  spacing: 10,
                  children: [
                    _buildImageUploadBox(
                      label: "Main Photo",
                      isMain: true,
                      i: 0,
                    ),
                    _buildImageUploadBox(label: "Living Room", i: 1),
                    _buildImageUploadBox(label: "Bedroom", i: 2),
                    _buildImageUploadBox(label: "Bathroom", i: 3),
                    _buildImageUploadBox(label: "Add More +", i: 4),
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
                        Expanded(
                          child: _buildTextField(
                            label: "Price / Night",
                            icon: Icons.attach_money,
                            suffix: "\$",
                            c: apartmentController.price,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: _buildTextField(
                            label: "Area Size",
                            icon: Icons.square_foot,
                            suffix: "m²",
                            c: apartmentController.area,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                            label: "Rooms",
                            icon: Icons.bed_outlined,
                            c: apartmentController.rooms,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: _buildTextField(
                            label: "Bathrooms",
                            icon: Icons.bathtub_outlined,
                            c: apartmentController.bathrooms,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: apartmentController.description,
                      maxLines: 4,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: "Description",
                        labelStyle: TextStyle(
                          color: Get.isDarkMode
                              ? DarkModeColor
                              : LightModeColor,
                        ),
                        alignLabelWithHint: true,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(bottom: 60),
                          // لرفع الأيقونة للأعلى
                          child: Icon(
                            Icons.description_outlined,
                            color: Get.isDarkMode
                                ? DarkModeColor
                                : LightModeColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              _buildGoldButton(label: "Publish Listing"),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  //--------------------------- Helper Widgets-------------------------------


  Widget _buildSectionHeader(String title) {
    return Text(
      title.toUpperCase(),
      style: TextStyle(
        color: Get.isDarkMode ? DarkModeColor : LightModeColor,
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
            color: Get.isDarkMode
                ? Color(0xff261f32).withOpacity(0.8)
                : Colors.white.withOpacity(0.6),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: child,
        ),
      ),
    );
  }

  Widget _buildImageUploadBox({required String label, bool isMain = false, required int i,}) {
    return Column(
      children: [
        Container(
          width: isMain ? 120 : 90,
          height: isMain ? 120 : 90,
          decoration: BoxDecoration(
            color: Get.isDarkMode
                ? Color(0xff261f32).withOpacity(0.2)
                : Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: isMain ? DarkModeColor : Colors.white.withOpacity(0.2),
              style: BorderStyle.solid, // استخدمنا solid بدلاً من dashed
              width: isMain ? 1.5 : 1,
            ),
          ),
          child: Center(
            child: GestureDetector(
              onTap: () => apartmentController.pickImage(i),
              child: Obx(() {
                return Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.transparent,
                      backgroundImage:
                          apartmentController.selectedImages[i] != null
                          ? FileImage(apartmentController.selectedImages[i]!)
                          : null,
                      child: apartmentController.selectedImages[i] == null
                          ? const Icon(
                              Icons.camera_alt,
                              size: 30,
                              color: Colors.white,
                            )
                          : null,
                    ),
                    if (apartmentController.selectedImages[i] != null)
                      GestureDetector(
                        onTap: () => apartmentController.removeImage(i),
                        child: const CircleAvatar(
                          radius: 12,
                          backgroundColor: Colors.red,
                          child: Icon(
                            Icons.close,
                            size: 15,
                            color: Colors.white,
                          ),
                        ),
                      )
                    else
                      const CircleAvatar(
                        radius: 12,
                        backgroundColor: Color(0xff846be7),
                        child: Icon(Icons.add, size: 15, color: Colors.white),
                      ),
                  ],
                );
              }),
            ),
          ),
        ),

        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 15),
        ),
      ],
    );
  }

  Widget _buildTextField({String suffix = "", required String label, required IconData icon, required TextEditingController c,}) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "Empty !";
        }
        return null;
      },
      controller: c,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: Get.isDarkMode ? DarkModeColor : LightModeColor,
        ),
        prefixIcon: Icon(
          icon,
          color: Get.isDarkMode ? DarkModeColor : LightModeColor,
          size: 20,
        ),
        suffixText: suffix,
        suffixStyle: TextStyle(
          color: Get.isDarkMode ? DarkModeColor : LightModeColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildGoldButton({required String label}) {
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
            color: DarkModeColor.withOpacity(0.9),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed:apartmentController.uploadApartment,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
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
