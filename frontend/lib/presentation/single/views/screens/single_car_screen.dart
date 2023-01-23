import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:frontend/app/core/constants/app_sizes.dart';
import 'package:frontend/app/core/types/car_table_type.dart';
import 'package:frontend/app/core/utils/custom_indicator.dart';
import 'package:frontend/app/core/utils/no_data.dart';
import 'package:frontend/presentation/single/controllers/single_car_controller.dart';
import 'package:frontend/presentation/single/views/widgets/car/single_car_account.dart';
import 'package:frontend/presentation/single/views/widgets/car/single_car_head_container.dart';
import 'package:frontend/presentation/single/views/widgets/car/single_car_totalbar.dart';
import 'package:get/get.dart';

class SingleCarScreen extends StatelessWidget {
  SingleCarScreen({Key? key}) : super(key: key);
  final SingleCarController controller = Get.put(SingleCarController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SingleCarController>(
        builder: (controller) {
          return Conditional.single(
            context: context,
            conditionBuilder: (context) => controller.singleCarModel == null,
            widgetBuilder: (context) =>
                controller.loading ? const CustomIndicator() : const NoData(),
            fallbackBuilder: (context) {
              return DefaultTabController(
                length: 3,
                child: Padding(
                  padding: EdgeInsets.all(AppSize.s1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Header
                      SingleCarToolBar(),
                      SizedBox(height: AppSize.s5),
                      SingleCarHeadContainer(),
                      SizedBox(height: AppSize.s5),
                      // Fotter
                      if (controller.singleCarModel!.car!.sailon!)
                        TabBar(
                          onTap: (value) {
                            switch (value) {
                              case 1:
                                controller.setType(CarTableType.forCar);
                                break;
                              case 2:
                                controller.setType(CarTableType.forLoco);
                                break;
                              default:
                                controller.setType(CarTableType.sailon);
                            }
                          },
                          tabs: const [
                            Tab(
                              child: Text('السيارة'),
                            ),
                            Tab(
                              child: Text('الرأس'),
                            ),
                            Tab(
                              child: Text('المقطورة'),
                            ),
                          ],
                        ),
                      if (controller.singleCarModel!.car!.sailon!)
                        Expanded(
                          child: TabBarView(
                            children: [
                              SingleCarAccount(),
                              SingleCarAccount(),
                              SingleCarAccount(),
                            ],
                          ),
                        ),
                      if (!controller.singleCarModel!.car!.sailon!)
                        SingleCarAccount(),
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
