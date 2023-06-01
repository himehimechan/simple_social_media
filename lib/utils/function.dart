
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../config/strings.dart';
import 'api_request_status.dart';

class Functions {

  static int calculateTotalPages(int totalData, int dataPerPage) {
    return (totalData / dataPerPage).ceil()-1;
  }

  static showSnackBar(String message, String subMessage, IconData icon) {
    Get.snackbar(
      message,
      subMessage,
      padding: const EdgeInsets.all(15),
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(25),
      icon: Icon(icon, size: 21),
    );
  }

  static bool checkConnectionError(e) {
    if (e.toString().contains('SocketException') ||
        e.toString().contains('HandshakeException')) {
      return true;
    } else {
      return false;
    }
  }


  static APIRequestStatus checkErrorPopup(e) {
    if (Functions.checkConnectionError(e)) {
      return APIRequestStatus.connectionError;
    } else {
      return APIRequestStatus.error;
    }
  }

  static bool checkFormValid(GlobalKey<FormState> globalKey){
    if(globalKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  static String ConvertDateTime(String date){
    var inputFormat = DateFormat("yyyy-MM-dd");
    var outputFormat = DateFormat("dd-MM-yyyy");

    var dateInput = inputFormat.parse(date);
    var dateInputParse = outputFormat.format(dateInput);
    String dateParse = dateInputParse.toString();
    return dateParse;
  }

  static String ConvertDateToDays(String date){
    var inputFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

    var dateInput = inputFormat.parse(date);
    var dateInputParse = DateFormat('EEEE').format(dateInput);
    String dateParse = dateInputParse.toString();
    return dateParse;
  }

}
