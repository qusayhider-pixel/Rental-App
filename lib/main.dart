import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_project/View/Screens/HomePage.dart';
import 'package:uni_project/View/Screens/ReservationManageScreen.dart';
import 'Bindings.dart';
import 'View/Screens/SplashScreenWidget.dart';

SharedPreferences ? sharedPreference ;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  sharedPreference = await SharedPreferences.getInstance() ;
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      initialBinding: MyBinding(),
      home:
      SplashScreenWidget(),
    );

  }
}
