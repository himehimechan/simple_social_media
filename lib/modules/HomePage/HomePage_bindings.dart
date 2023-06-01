import 'package:get/get.dart';

import 'package:simple_social_media/modules/HomePage/HomePage.dart';

class HomePageBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomePageController(HomePageService()));
  }
}