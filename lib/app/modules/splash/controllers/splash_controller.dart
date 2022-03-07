import 'package:get/get.dart';
import 'package:perfect/app/routes/app_pages.dart';
import 'package:perfect/preferences/user_preferences.dart';

class SplashController extends GetxController {

  @override
  void onInit() {
    super.onInit();
    _mockCheckForSession().then((status) {
      // Get.offAndToNamed(Routes.HOME);
      UserPreferences().isLoggedIn ? Get.offNamedUntil(Routes.HOME, (route) => false) :Get.offNamedUntil(Routes.LOGIN, (route) => false);
    });
  }

  Future<bool> _mockCheckForSession() async {
    await Future.delayed(Duration(milliseconds: 1500), () {

    });
    return true;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

}
