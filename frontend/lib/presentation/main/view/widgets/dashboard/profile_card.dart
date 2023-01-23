import 'package:flutter/material.dart';
import 'package:frontend/presentation/auth/controllers/auth_controller.dart';
import 'package:frontend/app/core/constants/app_sizes.dart';
import 'package:get/get.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find();
    return Container(
      height: AppSize.s15,
      padding: EdgeInsets.symmetric(
        vertical: AppSize.s2 / 2,
        horizontal: AppSize.s2,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: BorderRadius.circular(AppSize.s2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.person,
            size: AppSize.s12,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSize.s3 / 2),
            child: Text(
              authController.user.value?.name ?? '',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: AppSize.s2),
            width: 3,
            height: AppSize.s10,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          // InkWell(
          //   onTap: () => authController.logout(),
          //   child: Image.asset(AppAssets.logoutIcon),
          // ),
        ],
      ),
    );
  }
}
