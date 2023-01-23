import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:frontend/app/core/constants/app_sizes.dart';
import 'package:frontend/app/core/utils/custom_indicator.dart';
import 'package:frontend/app/core/utils/no_data.dart';
import 'package:frontend/presentation/single/controllers/single_bank_controller.dart';
import 'package:frontend/presentation/single/views/widgets/bank/single_bank_head_container.dart';
import 'package:frontend/presentation/single/views/widgets/bank/single_bank_head_toolbar.dart';
import 'package:frontend/presentation/single/views/widgets/bank/single_bank_transfer_table.dart';
import 'package:get/get.dart';

class SingleBankScreen extends StatelessWidget {
  SingleBankScreen({Key? key}) : super(key: key);
  final SingleBankController controller = Get.put(SingleBankController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SingleBankController>(
        builder: (controller) {
          return Conditional.single(
            context: context,
            conditionBuilder: (context) => controller.singleBankModel == null,
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
                      SingleBankToolBar(),
                      SizedBox(height: AppSize.s5),
                      SingleBankHeadContainer(),
                      SizedBox(height: AppSize.s5),
                      // Fotter
                      SingleBankTransferTable(),
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
