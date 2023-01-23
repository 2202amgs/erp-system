import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:frontend/app/core/constants/app_sizes.dart';
import 'package:frontend/app/core/utils/custom_indicator.dart';
import 'package:frontend/app/core/utils/no_data.dart';
import 'package:frontend/presentation/single/controllers/single_typegoods_controller.dart';
import 'package:frontend/presentation/single/views/widgets/typegoods/single_typegoods_buygoods.dart';
import 'package:frontend/presentation/single/views/widgets/typegoods/single_typegoods_head_container.dart';
import 'package:frontend/presentation/single/views/widgets/typegoods/single_typegoods_shipment_table.dart';
import 'package:frontend/presentation/single/views/widgets/typegoods/single_typegoods_toolbar.dart';
import 'package:get/get.dart';

class SingleTypeGoodsScreen extends StatelessWidget {
  SingleTypeGoodsScreen({Key? key}) : super(key: key);
  final SingleTypeGoodsController controller =
      Get.put(SingleTypeGoodsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SingleTypeGoodsController>(
        builder: (controller) {
          return Conditional.single(
            context: context,
            conditionBuilder: (context) =>
                controller.singleTypeGoodsModel == null,
            widgetBuilder: (context) =>
                controller.loading ? const CustomIndicator() : const NoData(),
            fallbackBuilder: (context) {
              return Container(
                padding: EdgeInsets.all(AppSize.s1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Header
                    SingleTypeGoodsToolBar(),
                    SizedBox(height: AppSize.s5),
                    SingleTypeGoodsHeadContainer(),
                    SizedBox(height: AppSize.s5),
                    // Tables
                    Expanded(
                      child: SingleChildScrollView(
                        controller: ScrollController(),
                        child: SizedBox(
                          width: double.infinity,
                          child: Wrap(
                            runSpacing: AppSize.s15,
                            alignment: WrapAlignment.spaceEvenly,
                            children: [
                              SingleTypeGoodsBuyGoodsTable(),
                              SingleTypeGoodsShipmentTable(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
