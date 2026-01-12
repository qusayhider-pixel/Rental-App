import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:uni_project/View/Screens/WelcomeScreen.dart';

import '../Model/LoginResponse.dart';

class AuthController extends GetxController {
  var user = Rxn<LoginResponse>();
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    final storedUser = getUserFromStorage();
    if (storedUser != null) {
      user.value = storedUser;
    }
  }

  void setUser(LoginResponse user) {
    box.write('token', user.token);
    box.write('firstname', user.firstname);
    box.write('lastname', user.lastname);
    box.write('phone', user.phone);
    box.write('avatar', user.avatar);

    this.user.value = user;
  }

  LoginResponse? getUserFromStorage() {
    final token = box.read('token');
    if (token == null) return null;

    return LoginResponse(
      token: token,
      firstname: box.read('firstname') ?? '',
      lastname: box.read('lastname') ?? '',
      phone: box.read('phone') ?? '',
      avatar: box.read('avatar') ?? '',
    );
  }

  void logout() {
    box.erase();
    user.value = null;
    Get.offAll(() => WelcomeScreen());
  }
}
