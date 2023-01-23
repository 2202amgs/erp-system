import 'package:flutter/material.dart';
import 'package:frontend/app/core/constants/app_sizes.dart';
import 'package:frontend/app/core/utils/head_item.dart';
import 'package:frontend/presentation/single/controllers/single_car_controller.dart';
import 'package:get/get.dart';

class SingleCarHeadContainer extends StatelessWidget {
  SingleCarHeadContainer({
    Key? key,
  }) : super(key: key);

  final SingleCarController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSize.s2),
      color: Theme.of(context).canvasColor,
      width: double.infinity,
      child: Wrap(
        // textDirection: TextDirection.rtl,
        alignment: WrapAlignment.spaceBetween,
        // crossAxisAlignment: WrapCrossAlignment.end,
        runAlignment: WrapAlignment.spaceBetween,
        children: [
          HeadIem(
            title: 'اسم المالك',
            value: controller.singleCarModel!.car!.ownerName!,
          ),
          HeadIem(
            title: 'اسم السائق',
            value: controller.singleCarModel!.car!.driverName!,
          ),
          HeadIem(
            title: 'رقم الرأس',
            value: controller.singleCarModel!.car!.carNumber!.toString(),
          ),
          HeadIem(
            title: 'رقم المقطورة',
            value: controller.singleCarModel!.car!.locoNumber!.toString(),
          ),
          HeadIem(
            title: 'نوع السيارة',
            value: controller.singleCarModel!.car!.sailon! ? 'سايلون' : 'فرش',
          ),
          if (controller.singleCarModel!.car!.sailon!)
            HeadIem(
              title: 'رصيد الرأس السابق',
              value:
                  controller.singleCarModel!.data!.oldTotalForCar!.toString(),
            ),
          if (controller.singleCarModel!.car!.sailon!)
            HeadIem(
              title: 'رصيد المقطورة السابق',
              value:
                  controller.singleCarModel!.data!.oldTotalForLoco!.toString(),
            ),
          HeadIem(
            title: 'رصيد سابق',
            value: controller.singleCarModel!.data!.oldTotal!.toString(),
          ),
        ],
      ),
    );
  }
}
