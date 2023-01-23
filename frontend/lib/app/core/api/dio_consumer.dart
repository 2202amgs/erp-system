import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend/app/core/api/end_points.dart';
import 'package:frontend/app/core/api/status_code.dart';
import 'package:frontend/app/core/constants/app_keys.dart';
import 'package:frontend/app/core/shared/local_helper.dart';
import 'package:get/get.dart';

class DioConsumer {
  static late Dio dio;

  static init() {
    dio = Dio(BaseOptions(
      baseUrl: EndPoint.baseUrl,
      receiveTimeout: 20 * 1000,
      sendTimeout: 20 * 1000,
      connectTimeout: 20 * 1000,
      receiveDataWhenStatusError: true,
    ));
  }

  static Future get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      return await dio.get(
        path,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            AppKeys.token: LocalHelper.get(AppKeys.token),
          },
        ),
      );
    } on DioError catch (e) {
      Get.snackbar(
        'خطأ',
        e.response?.data['message'] ?? '',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  static Future post(String path,
      {Map<String, dynamic>? body,
      Map<String, dynamic>? queryParameters}) async {
    try {
      return await dio.post(
        path,
        queryParameters: queryParameters,
        data: body,
        options: Options(
          headers: {
            AppKeys.token: LocalHelper.get(AppKeys.token),
          },
        ),
      );
    } on DioError catch (e) {
      Get.snackbar(
        'خطأ',
        e.response?.data['message'] ?? '',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  static Future put(String path,
      {Map<String, dynamic>? body,
      Map<String, dynamic>? queryParameters}) async {
    try {
      return await dio.put(
        path,
        queryParameters: queryParameters,
        data: body,
        options: Options(
          headers: {
            AppKeys.token: LocalHelper.get(AppKeys.token),
          },
        ),
      );
    } on DioError catch (e) {
      Get.snackbar(
        'خطأ',
        e.response?.data['message'] ?? '',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  static Future delete(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      return await dio.delete(
        path,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            AppKeys.token: LocalHelper.get(AppKeys.token),
          },
        ),
      );
    } on DioError catch (e) {
      Get.snackbar(
        'خطأ',
        e.response!.statusCode != StatusCode.notFound
            ? e.response?.data['message']
            : 'الصفحة غير موجودة',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
  // DioErrorType
}
