import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackbar {
  static void success(String message) {
    Get.snackbar(
      'عملية ناجحة',
      message,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      // borderColor: Colors.white,
    );
  }

  static void error(String message) {
    Get.snackbar(
      'عملية غير مكتملة',
      message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      // borderColor: Colors.white,
    );
  }
}
