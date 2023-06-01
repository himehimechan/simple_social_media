import 'package:get/get.dart';

import 'package:simple_social_media/modules/NewFeedPage/NewFeedPage.dart';

class NewFeedPageBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NewFeedPageController(NewFeedPageService()));
  }
}