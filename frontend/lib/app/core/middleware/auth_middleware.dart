import 'package:flutter/material.dart';
import 'package:frontend/app/core/constants/app_keys.dart';
import 'package:frontend/app/core/constants/app_routes.dart';
import 'package:frontend/app/core/shared/local_helper.dart';
import 'package:get/get.dart';

class AuthMiddleWare extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (LocalHelper.get(AppKeys.token) != null) {
      return RouteSettings(name: AppRoutes.dashboard);
    }
    return null;
  }
}
