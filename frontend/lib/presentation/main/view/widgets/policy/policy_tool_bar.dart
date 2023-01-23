import 'package:flutter/material.dart';
import 'package:frontend/app/core/utils/add_button.dart';
import 'package:frontend/app/core/utils/custom_dialog.dart';
import 'package:frontend/app/core/utils/date_range_button.dart';
import 'package:frontend/app/core/utils/printing_button.dart';
import 'package:frontend/presentation/main/controllers/polices_controller.dart';
import 'package:frontend/presentation/main/view/widgets/policy/policy_form.dart';
import 'package:get/get.dart';

class PolicyToolBar extends GetView<PolicyController> {
  const PolicyToolBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AddButton(
          label: 'إضافة بواليص جديدة',
          onPressed: () {
            controller.clearControllers();
            CustomDialog().set(
              context: context,
              title: 'إضافة بواليص جديدة',
              confirm: () async {
                if (controller.formKey.currentState!.validate()) {
                  await controller.createPolicy();
                }
              },
              body: const PolicyForm(),
            );
          },
        ),
        DateRangeButton(
          onPressed: () async {
            DateTime? dateTime = await showDatePicker(
              context: context,
              initialDate: controller.dateTime,
              firstDate: DateTime(2022),
              lastDate: DateTime.now(),
            );
            if (dateTime != null) {
              controller.dateTime = dateTime;
              controller.getPolices();
            }
          },
        ),
        PrintingButton(
          onPressed: () {
            // Get.to(PrintingScreen('اليومية', page: dailyPdf()));
          },
        ),
      ],
    );
  }
}
