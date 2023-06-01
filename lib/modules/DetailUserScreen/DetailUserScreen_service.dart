import 'package:simple_social_media/models/DetailUser.dart';
import 'package:simple_social_media/models/PostByUser.dart';

import '../../data/network/api.dart';

class DetailUserScreenService {
  Future<DetailUser?> detailUser(String id) async {
    try {
      var res = await Api.detailUser(id);
      DetailUser dataJson;
      dataJson = DetailUser.fromJson(res);
      return dataJson;
    } catch (e) {
      return null;
    }
  }
  Future<PostByUser?> listPostByUser(int currentPage, String id) async {
    try {
      var res = await Api.listPostByUser(currentPage, id);
      PostByUser dataJson;
      dataJson = PostByUser.fromJson(res);
      return dataJson;
    } catch (e) {
      return null;
    }
  }
}