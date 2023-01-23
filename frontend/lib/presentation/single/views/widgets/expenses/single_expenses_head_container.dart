import 'package:flutter/material.dart';
import 'package:frontend/app/core/constants/app_sizes.dart';
import 'package:frontend/app/core/utils/head_item.dart';
import 'package:frontend/data/models/single_expenses_model.dart';
import 'package:frontend/presentation/single/controllers/single_expenses_controller.dart';
import 'package:get/get.dart';

class SingleExpensesHeadContainer extends StatelessWidget {
  SingleExpensesHeadContainer({
    Key? key,
  }) : super(key: key);

  final SingleExpensesController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    SingleExpensesModel scm = controller.singleExpensesModel!;
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
            title: 'اسم القسم',
            value: scm.expenses!.name!,
          ),
          HeadIem(
            title: 'الحالة',
            value: scm.expenses!.archive! ? 'معطل' : 'نشط',
          ),
          HeadIem(
            title: 'المبلغ',
            value: scm.total.toString(),
          ),
        ],
      ),
    );
  }
}
