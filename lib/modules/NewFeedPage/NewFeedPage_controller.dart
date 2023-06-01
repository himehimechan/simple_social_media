import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import 'package:simple_social_media/modules/NewFeedPage/NewFeedPage.dart';

import '../../models/PostByUser.dart';
import '../../utils/api_request_status.dart';
import '../../utils/function.dart';

class NewFeedPageController extends GetxController {

  final NewFeedPageService _service;

  NewFeedPageController(this._service);
  var pageStatus = APIRequestStatus.unInitialized.obs;
  var loadPageMoreStatus = APIRequestStatus.loaded.obs;
  var listPostData = <Data>[].obs;
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
      PostByUser? postByUser = await _service.listPostByUser(currentPage);
      if(postByUser!=null && (postByUser.data?.length??0) > 0) {

        currentPage = postByUser.page??0;
        totalPage = Functions.calculateTotalPages(postByUser.total??0, 20);
        if(!isLoadPage) {
          scrollController.animateTo(scrollController.position.pixels+80,
              duration: const Duration(milliseconds: 100), curve :Curves.easeInOut);
        }
        if (kDebugMode) {
          print(totalPage);
        }
        // List<Data> temp = listUserData.value;
        // temp.addAll(listUser.data??[]);
        listPostData.addAll(postByUser.data??[]);
      }
    } catch (e) {
      Functions.checkErrorPopup(e);
    }
    isLoadPage ? pageStatus.value = APIRequestStatus.loaded:
    loadPageMoreStatus.value = APIRequestStatus.loaded;
  }
}