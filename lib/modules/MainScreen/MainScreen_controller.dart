import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:simple_social_media/modules/MainScreen/MainScreen.dart';

class MainScreenController extends GetxController {

  final MainScreenService _service;

  MainScreenController(this._service);

  var indexButtonNavigation = 0.obs;
  late PageController pageController;

  @override
  void onInit() {
    _init();
    super.onInit();

  }
  @override
  void onClose() {
    super.onClose();
    pageController.dispose();
  }

  Future<void> _init() async {
    pageController = PageController(initialPage: 0);
  }
  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }
  void onPageChanged(int page) {
    indexButtonNavigation.value = page;
    if(page == 0) {

    } else if(page == 1) {

    }
  }

}