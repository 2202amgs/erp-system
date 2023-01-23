import 'package:flutter/material.dart';
import 'package:frontend/app/core/constants/app_sizes.dart';
import 'package:frontend/app/core/utils/responsive.dart';
import 'package:frontend/presentation/main/controllers/shipments_controller.dart';
import 'package:frontend/presentation/main/view/widgets/dashboard/header.dart';
import 'package:frontend/presentation/main/view/widgets/shipment/shipment_table.dart';
import 'package:frontend/presentation/main/view/widgets/shipment/shipments_tool_bar.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

class ShipmentsScreen extends StatelessWidget {
  const ShipmentsScreen({Key? key}) : super(key: key);

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
              title: 'اليومية',
              toolBar: ShipmentsToolBar(),
            ),
            SizedBox(height: AppSize.s2),
            GetBuilder<ShipmentsController>(builder: (controller) {
              return Text(
                Jiffy(controller.dateTime).yMMMMEEEEd.toString(),
                style: Theme.of(context).textTheme.headline1,
              );
            }),
            SizedBox(height: AppSize.s3),
            const ShipmentTable(),
          ],
        ),
      ),
    );
  }
}
