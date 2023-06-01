import 'package:get/get.dart';

import 'package:simple_social_media/modules/DetailUserScreen/DetailUserScreen.dart';

class DetailUserScreenBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DetailUserScreenController(DetailUserScreenService()));
  }
}