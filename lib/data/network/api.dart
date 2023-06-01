import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

part 'api_constant.dart';
part 'api_exception.dart';
part 'api_handler.dart';

class Api {
  static final ApiHandler _handler = ApiHandler();

  static Future listUser(int currentPage) async {
    return await _handler.get(APIURL.userUrl+"?limit=20&page=$currentPage");
  }

  static Future listPostByUser(int currentPage, String id) async {
    return await _handler.get(APIURL.userUrl+id+APIURL.postUserUrl+"?limit=20&page=$currentPage");
  }

  static Future listPost(int currentPage) async {
    return await _handler.get(APIURL.baseUrl+APIURL.postUserUrl+"?limit=20&page=$currentPage");
  }

  static Future detailUser(String id) async {
    return await _handler.get(APIURL.userUrl+id);
  }

}