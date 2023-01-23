import 'package:flutter/material.dart';
import 'package:frontend/app/core/constants/app_sizes.dart';
import 'package:frontend/app/core/utils/responsive.dart';
import 'package:frontend/presentation/main/controllers/user_controller.dart';
import 'package:frontend/presentation/main/view/widgets/dashboard/header.dart';
import 'package:frontend/presentation/main/view/widgets/user/user_body.dart';
import 'package:frontend/presentation/main/view/widgets/user/user_toolbar.dart';
import 'package:get/get.dart';

class UserScreen extends GetView<UserController> {
  const UserScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(AppSize.s2),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: Responsive.isMobile(context)
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
          children: [
            const Header(
              title: 'الموظفون',
              toolBar: UserToolBar(),
            ),
            SizedBox(height: AppSize.s5),
            const UserBody(),
          ],
        ),
      ),
    );
  }
}
