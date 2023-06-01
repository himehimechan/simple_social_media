import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:simple_social_media/models/ListUser.dart';

import 'package:simple_social_media/modules/HomePage/HomePage.dart';

import '../../utils/api_request_status.dart';
import '../../utils/function.dart';

class HomePageController extends GetxController {

  final HomePageService _service;

  HomePageController(this._service);
  var pageStatus = APIRequestStatus.unInitialized.obs;
  var loadPageMoreStatus = APIRequestStatus.loaded.obs;
  var listUserData = <Data>[].obs;
  ScrollController scrollController = ScrollController();
  var totalPage = 0;
  var currentPage = 0;

  @override
  void onInit() {
    loadDataUsers(true);
    scrollController.addListener(_scrollListener);
    super.onInit();

  }

  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent && currentPage < totalPage
        && pageStatus.value != APIRequestStatus.loading) {
      currentPage++;
      loadDataUsers(false);
    }
  }

  Future<void> resetLoadData() async {
    currentPage = 0;
    totalPage = 0;
    loadDataUsers(true);
  }

  Future<void> loadDataUsers(bool isLoadPage) async {
    isLoadPage ? pageStatus.value = APIRequestStatus.loading:
    loadPageMoreStatus.value = APIRequestStatus.loading;
    try {
      ListUser? listUser = await _service.listUser(currentPage);
      if(listUser!=null && (listUser.data?.length??0) > 0) {

        currentPage = listUser.page??0;
        totalPage = Functions.calculateTotalPages(listUser.total??0, 20);
        if(!isLoadPage) {
          scrollController.animateTo(scrollController.position.pixels+80,
              duration: const Duration(milliseconds: 100), curve :Curves.easeInOut);
        }
        if (kDebugMode) {
          print(totalPage);
        }
        // List<Data> temp = listUserData.value;
        // temp.addAll(listUser.data??[]);
        listUserData.addAll(listUser.data??[]);
      } else {
        Functions.checkErrorPopup("");
      }
    } catch (e) {
      Functions.checkErrorPopup(e);
    }
    isLoadPage ? pageStatus.value = APIRequestStatus.loaded:
    loadPageMoreStatus.value = APIRequestStatus.loaded;
  }

}