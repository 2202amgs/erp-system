import 'package:flutter/material.dart';
import 'package:frontend/app/core/constants/app_sizes.dart';
import 'package:frontend/app/core/utils/responsive.dart';
import 'package:frontend/presentation/single/controllers/single_car_controller.dart';
import 'package:frontend/presentation/single/views/widgets/car/advance_data_table.dart';
import 'package:frontend/presentation/single/views/widgets/car/single_car_shipments_table.dart';
import 'package:frontend/presentation/single/views/widgets/car/total_section.dart';
import 'package:get/get.dart';

class SingleCarAccount extends StatelessWidget {
  SingleCarAccount({
    Key? key,
  }) : super(key: key);
  final SingleCarController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SingleCarShipmentsTable(),
          SizedBox(
            width: double.infinity,
            child: Wrap(
              textDirection: TextDirection.ltr,
              alignment: Responsive.isMobile(context)
                  ? WrapAlignment.center
                  : WrapAlignment.spaceAround,
              runSpacing: AppSize.s2,
              spacing: AppSize.s2,
              children: [
                TotalSection(),
                AdvanceDataTable(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
