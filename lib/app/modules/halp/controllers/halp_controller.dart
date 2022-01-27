import 'package:get/get.dart';
import 'package:perfect/app/models/help.dart';

class HalpController extends GetxController {
  var helpList = <Help>[].obs;
  
  @override
  void onInit() {
    super.onInit();
    
    getHelpList();
    
  }
  
  

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void getHelpList() {
    
    helpList.add(Help(media: "assets/image/help_1.png", help_type: "Video", description: "Lorem ipsum dolor sit amet, consectetur adipi scing elit. Id id vel potenti arcu."));
    helpList.add(Help(media: "assets/image/help_2.png", help_type: "Video", description: "Vel consequat at nunc a. Laoreet maecenas eget non purus accumsan etiam."));
    helpList.add(Help(media: "assets/image/help_3.png", help_type: "Video", description: "Sed dictum eu, in felis egestas malesuada mattis diam hac. Pulvinar amet sapien egestas"));
    helpList.add(Help(media: "assets/image/help_4.png", help_type: "Video", description: "Sed dictum eu, in felis egestas malesuada mattis diam hac. Pulvinar amet sapien egestas"));
    helpList.add(Help(media: "assets/image/help_5.png", help_type: "Video", description: "Consequat at nunc a. Laoreet maecenas eget non purus accumsan etiam. hac. Pulvinar amet sapien egestas"));
    helpList.add(Help(media: "assets/image/help_6.png", help_type: "Video", description: "Lorem ipsum dolor sit amet, consectetur adipi scing elit. Id id vel potenti arcu."));

  }
  
}
