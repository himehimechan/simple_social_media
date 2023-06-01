import 'package:get/get.dart';

import 'package:simple_social_media/modules/MainScreen/MainScreen.dart';

class MainScreenBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainScreenController(MainScreenService()));
  }
}