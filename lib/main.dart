import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'Bindings.dart';
import 'View/Screens/HomeScreen.dart';
import 'View/Screens/SplashScreenWidget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      initialBinding: MyBinding(),
      home: GetStorage().read('token') != null
          ? HomeScreen()
          : SplashScreenWidget(),
    );

  }
}
