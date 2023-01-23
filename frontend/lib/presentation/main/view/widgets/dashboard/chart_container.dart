import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:frontend/app/core/constants/app_assets.dart';
import 'package:frontend/app/core/constants/app_sizes.dart';
import 'package:frontend/presentation/main/controllers/bank_controller.dart';
import 'package:frontend/presentation/main/controllers/car_controller.dart';
import 'package:frontend/presentation/main/controllers/client_controller.dart';
import 'package:frontend/presentation/main/controllers/safe_controller.dart';
import 'package:frontend/presentation/main/view/widgets/dashboard/custom_chart.dart';
import 'package:frontend/presentation/main/view/widgets/dashboard/detail_item.dart';
import 'package:get/get.dart';

class ChartContainer extends StatelessWidget {
  ChartContainer({
    Key? key,
    required this.chartSelctionData,
  }) : super(key: key);

  final List<PieChartSectionData> chartSelctionData;
  final CarController carController = Get.find();
  final ClientController clientController = Get.find();
  final BankController bankController = Get.find();
  final SafeController safeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSize.s2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.s2),
        color: Theme.of(context).canvasColor,
      ),
      // height: 500,
      child: Column(
        children: [
          Text(
            'معلومات عامة',
            style: Theme.of(context).textTheme.headline1,
          ),
          const SizedBox(height: 10),
          CustomChart(chartSelctionData: chartSelctionData),
          DetailItem(
            icon: AppAssets.movingIcon,
            text: 'السيارات',
            value: carController.cars.length,
          ),
          DetailItem(
            icon: AppAssets.creativeIcon,
            text: 'العملاء',
            value: clientController.clients.length,
          ),
          DetailItem(
            icon: AppAssets.factoryIcon,
            text: 'البنوك',
            value: bankController.banks.length,
          ),
          DetailItem(
            icon: AppAssets.profitsIcon,
            text: 'الخزن',
            value: safeController.safes.length,
          ),
        ],
      ),
    );
  }
}
