import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:frontend/presentation/auth/controllers/auth_controller.dart';
import 'package:frontend/app/core/utils/custom_indicator.dart';
import 'package:frontend/presentation/main/controllers/dashboard_controller.dart';
import 'package:frontend/presentation/main/view/widgets/dashboard/dashboard_body.dart';
import 'package:frontend/presentation/main/view/widgets/dashboard/drawer_list.dart';
import 'package:get/get.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.formKey,
      drawer: const DrawerList(),
      body: SafeArea(
        child: GetX<AuthController>(
          builder: (controller) {
            return Conditional.single(
              context: context,
              conditionBuilder: (context) => controller.user.value == null,
              widgetBuilder: (context) => const CustomIndicator(),
              fallbackBuilder: (context) => const DashBoardBody(),
            );
          },
        ),
      ),
    );
  }
}
