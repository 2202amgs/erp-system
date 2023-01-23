import 'package:flutter/material.dart';
import 'package:frontend/app/core/constants/app_sizes.dart';
import 'package:frontend/app/core/utils/head_item.dart';
import 'package:frontend/presentation/single/controllers/single_client_controller.dart';
import 'package:get/get.dart';

class SingleClientHeadContainer extends StatelessWidget {
  SingleClientHeadContainer({
    Key? key,
  }) : super(key: key);

  final SingleClientController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSize.s2),
      color: Theme.of(context).canvasColor,
      width: double.infinity,
      child: Wrap(
        textDirection: TextDirection.rtl,
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.end,
        runAlignment: WrapAlignment.spaceBetween,
        children: [
          HeadIem(
            title: 'اسم الشركة',
            value: controller.singleClientModel!.client!.clientName!,
          ),
          HeadIem(
            title: 'اسم البون',
            value: controller.singleClientModel!.client!.ponName!,
          ),
          HeadIem(
            title: 'رقم الهاتف',
            value: controller.singleClientModel!.client!.phone!,
          ),
          HeadIem(
            title: 'رصيد سابق',
            value: controller.singleClientModel!.data!.oldTotal!.toString(),
          ),
          HeadIem(
            title: 'الرصيد الحالى',
            value: (controller.singleClientModel!.data!.newTotal! +
                    controller.singleClientModel!.data!.oldTotal!)
                .toString(),
          ),
        ],
      ),
    );
  }
}
