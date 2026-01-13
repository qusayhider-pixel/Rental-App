import 'package:get/get.dart';
import 'package:uni_project/Model/Notificaion_model.dart';
import 'package:uni_project/Services/api_service.dart';

class NotificationController extends GetxController {
  ApiService service = ApiService();
  var notifications = <NotificationModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNotification();
  }

  void fetchNotification() async {
    try {
      isLoading(true);
      notifications.value = await service.fetchingNotifications();
      print("Is My notifications empty ? : ${notifications.isEmpty}");
    } catch (e) {
      Get.snackbar('Error', 'Failed to load my notifications');
    } finally {
      isLoading(false);
    }
  }

  @override
  void onClose() {
    service.changeNotificationStatus();
    super.onClose();
  }
}
