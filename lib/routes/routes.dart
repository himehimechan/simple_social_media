import 'package:get/get.dart';
import 'package:simple_social_media/modules/MainScreen/MainScreen.dart';
import 'package:simple_social_media/screens/DetailUserScreen.dart';
import 'package:simple_social_media/screens/MainScreen.dart';

import '../modules/DetailUserScreen/DetailUserScreen_bindings.dart';

class Routes {
  static const String root = '/';
  static const String detailUser = '/homePage/DetailUser';
}

final List<GetPage> routes = [
  GetPage(name: Routes.root, page: () => MainScreen(Get.find()), binding: MainScreenBindings()),
  GetPage(name: Routes.detailUser, page: () => DetailUserScreen(Get.find()), binding: DetailUserScreenBindings()),
];