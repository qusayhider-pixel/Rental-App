import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'constants.dart';


Widget CreateTextField(String title , IconData icon , Color color , TextEditingController controller)

{
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 30.0),
    child: TextFormField(
      controller: controller,
      validator: (value)
      {
        if(value!.isEmpty)
        {
          return "Empty !";
        }
        // if(icon == Icons.phone)
        //   {
        //     if(value.length != 10 )
        //     {
        //       return "Please enter a Valid Number [10 digits]";
        //     }
        //   }
        return null;
      },
      inputFormatters: icon == Icons.phone ? [FilteringTextInputFormatter.digitsOnly] : null,
      textInputAction: TextInputAction.next,
      obscureText: false,
      cursorColor: kPrimaryColor,
      decoration: InputDecoration(
        filled: true,
        fillColor: color,

        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: kPrimaryLightColor),
          borderRadius: BorderRadius.all(Radius.circular(40)),
        ),

        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: kPrimaryColor),
            borderRadius: BorderRadius.all(Radius.circular(40))
        ),
        errorBorder:  const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.all(Radius.circular(40))
        ),

        focusedErrorBorder:  const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.all(Radius.circular(40))
        ),
        hintText: title,
        prefixIcon: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Icon(icon),
        ),
      ),
    ),
  );
}
