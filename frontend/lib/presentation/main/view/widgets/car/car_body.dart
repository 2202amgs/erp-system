import 'package:flutter/cupertino.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:frontend/app/core/constants/app_arguments.dart';
import 'package:frontend/app/core/constants/app_routes.dart';
import 'package:frontend/app/core/constants/app_sizes.dart';
import 'package:frontend/app/core/utils/custom_dialog.dart';
import 'package:frontend/app/core/utils/no_data.dart';
import 'package:frontend/presentation/main/controllers/car_controller.dart';
import 'package:frontend/presentation/main/view/widgets/car/car_form.dart';
import 'package:frontend/presentation/main/view/widgets/car/car_taile.dart';
import 'package:get/get.dart';

class CarBody extends GetView<CarController> {
  const CarBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GetBuilder<CarController>(
        builder: (controller) {
          return Conditional.single(
            context: context,
            conditionBuilder: (context) => controller.cars.isEmpty,
            widgetBuilder: (context) => const NoData(),
            fallbackBuilder: (context) => ListView.separated(
              controller: ScrollController(initialScrollOffset: 0),
              shrinkWrap: true,
              itemCount: controller.cars.length,
              itemBuilder: (context, index) => CarTaile(
                car: controller.cars[index],
                onArchive: () {
                  if (index < controller.cars.length) {
                    controller.carArchive(controller.cars[index]);
                  }
                },
                onEdit: () {
                  controller.modelToController(controller.cars[index]);
                  CustomDialog().set(
                    context: context,
                    title: 'تعديل بيانات السيارة',
                    confirm: () {
                      if (controller.formKey.currentState!.validate()) {
                        controller.carUpdate(controller.cars[index]);
                      }
                    },
                    body: const CarForm(),
                  );
                },
                onTap: () => Get.toNamed(
                  AppRoutes.car,
                  arguments: {
                    AppArguments.carId: controller.cars[index].id,
                  },
                ),
              ),
              separatorBuilder: (context, index) =>
                  SizedBox(height: AppSize.s2),
            ),
          );
        },
      ),
    );
  }

  // ListView _getTail() {
  //   // return ListView(children: controller.cars.toList().mao);
  // }
}
