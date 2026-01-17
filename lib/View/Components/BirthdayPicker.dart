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
      decoration:
      InputDecoration(
        labelText: "Your Birthday",
        labelStyle: const TextStyle(color: Colors.white70, fontSize: 13),
        prefixIcon: Icon(
            Icons.calendar_month, color: const Color(0xff9e14e4), size: 20),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Color(0xFFC293F3), width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.all(Radius.circular(12))
        ),

        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.all(Radius.circular(12))
        ),
        errorStyle: TextStyle(color: Color(0xFFFF001E)),
      ),
      // InputDecoration(
      //   filled: true,
      //   fillColor: const Color(0xffBF9BFF),
      //
      //   enabledBorder: OutlineInputBorder(
      //     borderSide: BorderSide(color: kPrimaryLightColor),
      //     borderRadius: const BorderRadius.all(Radius.circular(40)),
      //   ),
      //
      //   focusedBorder: const OutlineInputBorder(
      //     borderSide: BorderSide(color: kPrimaryColor),
      //     borderRadius: BorderRadius.all(Radius.circular(40)),
      //   ),
      //
      //   errorBorder: const OutlineInputBorder(
      //     borderSide: BorderSide(color: Colors.red),
      //     borderRadius: BorderRadius.all(Radius.circular(40)),
      //   ),
      //
      //   focusedErrorBorder: const OutlineInputBorder(
      //     borderSide: BorderSide(color: Colors.red),
      //     borderRadius: BorderRadius.all(Radius.circular(40)),
      //   ),
      //
      //   hintText: "Your Birthday",
      //   prefixIcon: const Padding(
      //     padding: EdgeInsets.all(defaultPadding),
      //     child: Icon(Icons.calendar_month),
      //   ),
      // ),
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
