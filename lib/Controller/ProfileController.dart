import 'package:get/get.dart';
import 'package:uni_project/Model/Profile_model.dart';
import 'package:uni_project/Services/api_service.dart';

class ProfileController extends GetxController {
  ApiService service = ApiService();
  var isLoading = false.obs;
  Rxn<ProfileModel> profile = Rxn<ProfileModel>();

  @override
  void onInit() {
    super.onInit();
    getProfile();
  }

  Future<void> getProfile() async {
    try {
      isLoading(true);
      profile.value = await service.getProfile();
    } catch (e) {
      Get.snackbar('Error', 'Failed to load');
      rethrow;
    } finally {
      isLoading(false);
    }
  }
}
