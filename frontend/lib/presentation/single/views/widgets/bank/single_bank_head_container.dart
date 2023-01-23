import 'package:flutter/material.dart';
import 'package:frontend/app/core/constants/app_sizes.dart';
import 'package:frontend/app/core/utils/head_item.dart';
import 'package:frontend/data/models/single_bank_model.dart';
import 'package:frontend/presentation/single/controllers/single_bank_controller.dart';
import 'package:get/get.dart';

class SingleBankHeadContainer extends StatelessWidget {
  SingleBankHeadContainer({
    Key? key,
  }) : super(key: key);

  final SingleBankController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    SingleBankModel scm = controller.singleBankModel!;
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
            title: scm.bank!.accountNumber == null ? 'اسم الخزنة' : 'اسم البنك',
            value: scm.bank!.name ?? '',
          ),
          if (scm.bank!.accountNumber != null)
            HeadIem(
              title: 'رقم الحساب',
              value: scm.bank!.accountNumber ?? '',
            ),
          HeadIem(
            title: 'الحالة',
            value: scm.bank!.archive! ? 'معطل' : 'نشط',
          ),
          HeadIem(
            title: 'الرصيد',
            value: scm.total.toString(),
          ),
        ],
      ),
    );
  }
}
