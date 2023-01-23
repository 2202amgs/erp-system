import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:frontend/app/core/constants/app_sizes.dart';
import 'package:frontend/app/core/utils/custom_indicator.dart';
import 'package:frontend/app/core/utils/no_data.dart';
import 'package:frontend/presentation/single/controllers/single_emp_controller.dart';
import 'package:frontend/presentation/single/views/widgets/emp/single_emp_head_container.dart';
import 'package:frontend/presentation/single/views/widgets/emp/single_emp_head_toolbar.dart';
import 'package:frontend/presentation/single/views/widgets/emp/single_emp_money_table.dart';
import 'package:frontend/presentation/single/views/widgets/emp/single_emp_transfer_table.dart';
import 'package:get/get.dart';

class SingleEmpScreen extends StatelessWidget {
  SingleEmpScreen({Key? key}) : super(key: key);
  final SingleEmpController controller = Get.put(SingleEmpController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SingleEmpController>(
        builder: (controller) {
          return Conditional.single(
            context: context,
            conditionBuilder: (context) => controller.singleEmpModel == null,
            widgetBuilder: (context) =>
                controller.loading ? const CustomIndicator() : const NoData(),
            fallbackBuilder: (context) {
              return DefaultTabController(
                length: 3,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  padding: EdgeInsets.all(AppSize.s1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Header
                      SingleEmpToolBar(),
                      SizedBox(height: AppSize.s5),
                      SingleEmpHeadContainer(),
                      SizedBox(height: AppSize.s5),
                      // Fotter
                      Expanded(
                        child: SingleChildScrollView(
                          controller: ScrollController(),
                          child: SizedBox(
                            width: double.infinity,
                            child: Wrap(
                              runSpacing: AppSize.s15,
                              alignment: WrapAlignment.spaceEvenly,
                              children: [
                                SingleEmpMoneyTable(),
                                SingleEmpTransferTable(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
