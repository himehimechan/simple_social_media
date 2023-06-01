import 'package:simple_social_media/models/ListUser.dart';

import '../../data/network/api.dart';

class HomePageService {

  Future<ListUser?> listUser(int currentPage) async {
    try {
      var res = await Api.listUser(currentPage);
      ListUser dataJson;
      dataJson = ListUser.fromJson(res);
      return dataJson;
    } catch (e) {
      return null;
    }
  }

}