import 'package:flutter/material.dart';
import 'package:frontend/app/core/utils/responsive.dart';
import 'package:frontend/presentation/main/controllers/dashboard_controller.dart';
import 'package:frontend/presentation/main/view/widgets/dashboard/drawer_list.dart';
import 'package:get/get.dart';

class DashBoardBody extends GetView<DashboardController> {
  const DashBoardBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!Responsive.isMobile(context)) const DrawerList(),
        Expanded(
          child: GetBuilder(
            builder: (DashboardController controller) {
              return controller.dashboardScreens[controller.currentIndex];
            },
          ),
        )
      ],
    );
  }
}
