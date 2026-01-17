import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uni_project/Controller/SignUpController.dart';
import 'constants.dart';

class BirthdayPicker extends StatefulWidget {
  final SignUpController controller = Get.find();
   BirthdayPicker({super.key});

  @override
  State<BirthdayPicker> createState() => _BirthdayPickerState();
}

class _BirthdayPickerState extends State<BirthdayPicker> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "Required";
        }
        return null;
      },
      controller: widget.controller.dobController,
      textInputAction: TextInputAction.next,
      style: const TextStyle(color: Color(0xFF712BB7), fontSize: 13),
      decoration:
      // InputDecoration(
      //   labelText: "Your Birthday",
      //   labelStyle: const TextStyle(color: Colors.white70, fontSize: 13),
      //   prefixIcon: Icon(
      //       Icons.calendar_month, color: const Color(0xff9e14e4), size: 20),
      //   filled: true,
      //   fillColor: Colors.white.withOpacity(0.1),
      //   border: OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(12),
      //     borderSide: BorderSide.none,
      //   ),
      //   focusedBorder: OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(12),
      //     borderSide: BorderSide(color: Color(0xFFC293F3), width: 1.5),
      //   ),
      //   errorBorder: OutlineInputBorder(
      //       borderSide: BorderSide(color: Colors.red),
      //       borderRadius: BorderRadius.all(Radius.circular(12))
      //   ),
      //
      //   focusedErrorBorder: OutlineInputBorder(
      //       borderSide: BorderSide(color: Colors.red),
      //       borderRadius: BorderRadius.all(Radius.circular(12))
      //   ),
      //   errorStyle: TextStyle(color: Color(0xFFFF001E)),
      // ),

      InputDecoration(
        filled: true,
        labelStyle: const TextStyle(color: Color(0xff6e35a4), fontSize: 13),
        fillColor: Colors.white.withOpacity(0.2),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Color(0xFFC293F3), width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: const BorderRadius.all(Radius.circular(30)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: const BorderRadius.all(Radius.circular(30)),
        ),
        errorStyle: const TextStyle(color: Color(0xFFFF001E)
        ),

        hintText: "Your Birthday",
        hintStyle: const TextStyle(color: Color(0xFF712BB7), fontSize: 13),
        prefixIcon: const Padding(
          padding: EdgeInsets.all(defaultPadding),
          child: Icon(Icons.calendar_month, color: Color(0xff8726db)),
        ),
      ),
      readOnly: true,
      onTap: () {
        _selectDate();
      },
    );
  }

  Future<void> _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2005),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      widget.controller.dobController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      print(widget.controller.dobController.text);

    }
  }
}
