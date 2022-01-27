import 'package:get/get.dart';
import 'package:perfect/app/routes/app_pages.dart';

class SplashController extends GetxController {

  @override
  void onInit() {
    super.onInit();
    _mockCheckForSession().then((status) {
      Get.offAndToNamed(Routes.HOME);
    });
  }

  Future<bool> _mockCheckForSession() async {
    await Future.delayed(Duration(milliseconds: 1500), () {});
    return true;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

}
