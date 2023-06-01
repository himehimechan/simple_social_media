import '../../data/network/api.dart';
import '../../models/PostByUser.dart';

class NewFeedPageService {
  Future<PostByUser?> listPostByUser(int currentPage) async {
    try {
      var res = await Api.listPost(currentPage);
      PostByUser dataJson;
      dataJson = PostByUser.fromJson(res);
      return dataJson;
    } catch (e) {
      return null;
    }
  }
}