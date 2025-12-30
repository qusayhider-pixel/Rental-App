import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:uni_project/View/Screens/WelcomeScreen.dart';

import '../Model/LoginResponse.dart';

class AuthController extends GetxController {
  var user = Rxn<LoginResponse>();
  final box = GetStorage();
  bool get isLoggedIn => user.value != null;

  void setUser(LoginResponse loginResponse) {
    user.value = loginResponse;
    box.write('user', {
      'token': loginResponse.token,
      'first_name': loginResponse.firstname,
      'last_name': loginResponse.lastname,
      'phone': loginResponse.phone,
      'avatar': loginResponse.avatar,
    });
  }

  void loadUser() {
    final data = box.read('user');
    if (data != null) {
      user.value = LoginResponse(
        token: data['token'],
        firstname: data['first_name'],
        lastname: data['last_name'],
        phone: data['phone'],
        avatar: data['avatar'],
      );
    }
  }

  void logout() {
    box.erase();
    user.value = null;
    Get.offAll(() => WelcomeScreen());
  }
}
