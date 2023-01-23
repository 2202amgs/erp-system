import 'package:flutter/material.dart';
import 'package:frontend/app/core/api/dio_consumer.dart';
import 'package:frontend/app/core/api/end_points.dart';
import 'package:frontend/app/core/api/status_code.dart';
import 'package:frontend/app/core/constants/app_keys.dart';
import 'package:frontend/app/core/constants/app_routes.dart';
import 'package:frontend/app/core/services/initial_services.dart';
import 'package:frontend/app/core/shared/local_helper.dart';
import 'package:frontend/app/core/utils/custom_snackbar.dart';
import 'package:frontend/data/models/user_model.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final Rx<UserModel?> user = Rx<UserModel?>(null);

  Future<void> login({required String email, required String password}) async {
    var res = await DioConsumer.post(EndPoint.login, body: {
      'email': email,
      'password': password,
    });

    if (res != null && res.statusCode == StatusCode.ok) {
      LocalHelper.setString(AppKeys.token, res.data['user'][AppKeys.token]);
      Get.offAllNamed(AppRoutes.dashboard);
      CustomSnackbar.success('تم تسجيل الدخول');
    }
    // load data
    InitialSrvice initialSrvice = Get.find();
    initialSrvice.init();
  }

  void logout() async {
    Get.back();
    await Future.delayed(const Duration(seconds: 1));
    user.call(null);
    LocalHelper.remove(AppKeys.token);
    Get.offAllNamed(AppRoutes.login);
    CustomSnackbar.success('تم تسجيل الخروج');
  }

  Future<void> getUserData() async {
    var res = await DioConsumer.post(EndPoint.users);
    if (res != null && res.statusCode == StatusCode.ok) {
      user.call(UserModel.fromJson(res.data));
    } else if (res != null && res.statusCode == StatusCode.unAuthorized) {
      logout();
    }
  }
}
