import 'package:flutter/material.dart';
import 'package:frontend/presentation/auth/controllers/auth_controller.dart';
import 'package:frontend/app/core/constants/app_assets.dart';
import 'package:frontend/app/core/utils/custom_dialog.dart';
import 'package:frontend/presentation/main/controllers/dashboard_controller.dart';
import 'package:frontend/presentation/main/view/widgets/dashboard/drawer_list_tile.dart';
import 'package:get/get.dart';

class DrawerList extends GetView<AuthController> {
  const DrawerList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      builder: (DashboardController controller) {
        return Drawer(
          width: 160,
          child: ListView(
            children: [
              DrawerHeader(
                child: Image.asset(AppAssets.ammarIcon),
              ),
              DrawerListTile(
                title: 'الرئيسية',
                icon: AppAssets.monitorIcon,
                onTap: () => controller.changeScreen(0),
                selected: controller.currentIndex == 0,
              ),
              DrawerListTile(
                title: 'اليومية',
                icon: AppAssets.claendarIcon,
                onTap: () => controller.changeScreen(1),
                selected: controller.currentIndex == 1,
              ),
              DrawerListTile(
                title: 'السيارات',
                icon: AppAssets.movingIcon,
                onTap: () => controller.changeScreen(2),
                selected: controller.currentIndex == 2,
              ),
              DrawerListTile(
                title: 'العملاء',
                icon: AppAssets.creativeIcon,
                onTap: () => controller.changeScreen(3),
                selected: controller.currentIndex == 3,
              ),
              DrawerListTile(
                title: 'الموردين',
                icon: AppAssets.salaryIcon,
                onTap: () => controller.changeScreen(4),
                selected: controller.currentIndex == 4,
              ),
              DrawerListTile(
                title: 'البضاعة',
                icon: AppAssets.deliveryTruck,
                onTap: () => controller.changeScreen(5),
                selected: controller.currentIndex == 5,
              ),
              DrawerListTile(
                title: 'البنوك',
                icon: AppAssets.bankIcon,
                onTap: () => controller.changeScreen(6),
                selected: controller.currentIndex == 6,
              ),
              DrawerListTile(
                title: 'الخزنة',
                icon: AppAssets.profitsIcon,
                onTap: () => controller.changeScreen(7),
                selected: controller.currentIndex == 7,
              ),
              DrawerListTile(
                title: 'الموظفون',
                icon: AppAssets.teamworkIcon,
                onTap: () => controller.changeScreen(8),
                selected: controller.currentIndex == 8,
              ),
              DrawerListTile(
                title: 'المصروفات',
                icon: AppAssets.moneyIcon,
                onTap: () => controller.changeScreen(9),
                selected: controller.currentIndex == 9,
              ),
              DrawerListTile(
                title: 'خروج',
                icon: AppAssets.logoutIcon,
                onTap: () {
                  CustomDialog().logOut(
                    context: context,
                    title: 'تسجيل الخروج',
                    confirm: () => super.controller.logout(),
                  );
                },
                selected: false,
              ),
            ],
          ),
        );
      },
    );
  }
}
