import 'package:flutter/material.dart';
import 'package:frontend/app/core/constants/app_sizes.dart';
import 'package:frontend/app/core/utils/responsive.dart';
import 'package:frontend/presentation/main/controllers/car_controller.dart';
import 'package:frontend/presentation/main/view/widgets/car/car_body.dart';
import 'package:frontend/presentation/main/view/widgets/car/car_toolbar.dart';
import 'package:frontend/presentation/main/view/widgets/dashboard/header.dart';
import 'package:get/get.dart';

class CarsScreen extends GetView<CarController> {
  const CarsScreen({Key? key}) : super(key: key);

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
              title: 'السيارات',
              toolBar: CarToolBar(),
            ),
            SizedBox(height: AppSize.s5),
            const CarBody(),
          ],
        ),
      ),
    );
  }
}
