import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'constants.dart';


Widget CreateTextField({
  required String title,
  required IconData icon,
  required Color color,
  required TextEditingController controller,
  bool isPassword = false,
}) {
  if (!isPassword) {
    return TextFormField(
      controller: controller,
      inputFormatters: icon == Icons.phone
          ? [FilteringTextInputFormatter.digitsOnly]
          : null,
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value!.isEmpty) {
          return "Empty !";
        }
        return null;
      },
      style: const TextStyle(color: Color(0xFF712BB7), fontSize: 13),
      cursorColor: Color(0xff9e14e4),
      decoration: InputDecoration(
        labelText: title,
        labelStyle: const TextStyle(color: Color(0xff6e35a4), fontSize: 13),
        prefixIcon: Icon(icon, color: const Color(0xff8726db), size: 20),
        filled: true,
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
        errorStyle: const TextStyle(color: Color(0xFFFF001E)),
      ),
    );
  }
  return ObxValue<RxBool>(
    (isVisible) => TextFormField(
      controller: controller,
      obscureText: !isVisible.value,
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value!.isEmpty) {
          return "Empty !";
        }
        return null;
      },
      style: const TextStyle(color: Color(0xFF712BB7), fontSize: 13),
      cursorColor: Color(0xff9e14e4),
      decoration: InputDecoration(
        labelText: title,
        labelStyle: const TextStyle(color: Color(0xff6e35a4), fontSize: 13),
        prefixIcon: Icon(icon, color: const Color(0xff8726db), size: 20),
        suffixIcon: IconButton(
          icon: Icon(
            isVisible.value ? Icons.visibility : Icons.visibility_off,
            color: isVisible.value ? Color(0xff8726db) : Color(0x50c25af5),
          ),
          onPressed: isVisible.toggle,
        ),
        filled: true,
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
        errorStyle: const TextStyle(color: Color(0xFFFF001E)),
      ),
    ),
    false.obs,
  );

  // TextFormField(
  // controller: controller,
  //   validator: (value)
  //   {
  //     if(value!.isEmpty)
  //     {
  //       return "Empty !";
  //     }
  //     return null;
  //   },
  //   inputFormatters: icon == Icons.phone ? [FilteringTextInputFormatter.digitsOnly] : null,
  //   textInputAction: TextInputAction.next,
  //   obscureText: false,
  //   cursorColor: kPrimaryColor,
  //   decoration: InputDecoration(
  //
  //     filled: true,
  //     fillColor: color,
  //     enabledBorder: const OutlineInputBorder(
  //       borderSide: BorderSide(color: kPrimaryLightColor),
  //       borderRadius: BorderRadius.all(Radius.circular(40)),
  //     ),
  //
  //     focusedBorder: const OutlineInputBorder(
  //         borderSide: BorderSide(color: kPrimaryColor),
  //         borderRadius: BorderRadius.all(Radius.circular(40))
  //     ),
  //     errorBorder:  const OutlineInputBorder(
  //         borderSide: BorderSide(color: Colors.red),
  //         borderRadius: BorderRadius.all(Radius.circular(40))
  //     ),
  //
  //     focusedErrorBorder:  const OutlineInputBorder(
  //         borderSide: BorderSide(color: Colors.red),
  //         borderRadius: BorderRadius.all(Radius.circular(40))
  //     ),
  //     hintText: title,
  //     prefixIcon: Padding(
  //       padding: const EdgeInsets.all(defaultPadding),
  //       child: Icon(icon),
  //     ),
  //   ),
  // ),
  // );
}
