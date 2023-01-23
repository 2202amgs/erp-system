import 'package:flutter/material.dart';
import 'package:frontend/app/core/constants/app_sizes.dart';
import 'package:frontend/app/core/utils/head_item.dart';
import 'package:frontend/presentation/single/controllers/single_emp_controller.dart';
import 'package:get/get.dart';

class SingleEmpHeadContainer extends StatelessWidget {
  SingleEmpHeadContainer({
    Key? key,
  }) : super(key: key);

  final SingleEmpController controller = Get.find();
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
            title: 'اسم الموظف',
            value: controller.singleEmpModel!.user!.name!,
          ),
          HeadIem(
            title: 'البريد الإلكترونى',
            value: controller.singleEmpModel!.user!.email!,
          ),
          HeadIem(
            title: 'الرتبة على النظام',
            value: controller.singleEmpModel!.user!.isAdmin! ? 'مدير' : 'موظف',
          ),
          HeadIem(
            title: 'الحالة',
            value: controller.singleEmpModel!.user!.archive! ? 'معطل' : 'نشط',
          ),
          HeadIem(
            title: 'المستحقات',
            value: controller.singleEmpModel!.account!.toString(),
          ),
        ],
      ),
    );
  }
}
