import 'package:flutter/material.dart';
import 'package:frontend/app/core/utils/add_button.dart';
import 'package:frontend/app/core/utils/archive_toolbar_button.dart';
import 'package:frontend/app/core/utils/custom_dialog.dart';
import 'package:frontend/presentation/main/controllers/bank_controller.dart';
import 'package:frontend/presentation/main/view/widgets/bank/bank_form.dart';
import 'package:frontend/presentation/main/view/widgets/transfer/transfer_add_button.dart';
import 'package:get/get.dart';

class BankToolBar extends GetView<BankController> {
  const BankToolBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AddButton(
          label: 'إضافة بنك جديد',
          onPressed: () {
            controller.clearControllers();
            CustomDialog().set(
              context: context,
              title: 'إضافة بنك جديد',
              confirm: () {
                if (controller.formKey.currentState!.validate()) {
                  controller.createBank();
                }
              },
              body: const BankForm(),
            );
          },
        ),
        const TransferAddBotton(),
        GetBuilder<BankController>(builder: (controller) {
          return ArchiveToolBarButton(
            isArchive: controller.archive,
            onPressed: () {
              controller.archive = !controller.archive;
              controller.update();
            },
          );
        }),
      ],
    );
  }
}
