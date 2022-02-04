import 'package:get/get.dart';

import '../controllers/recommend_to_friend_controller.dart';

class RecommendToFriendBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RecommendToFriendController>(
      () => RecommendToFriendController(),
    );
  }
}
