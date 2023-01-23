import 'package:flutter/material.dart';
import 'package:frontend/app/core/utils/add_button.dart';
import 'package:frontend/app/core/utils/archive_toolbar_button.dart';
import 'package:frontend/app/core/utils/custom_dialog.dart';
import 'package:frontend/presentation/main/controllers/safe_controller.dart';
import 'package:frontend/presentation/main/view/widgets/safe/safe_form.dart';
import 'package:frontend/presentation/main/view/widgets/transfer/transfer_add_button.dart';
import 'package:get/get.dart';

class SafeToolBar extends GetView<SafeController> {
  const SafeToolBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AddButton(
          label: 'إضافة خزينة جديدة',
          onPressed: () {
            controller.clearControllers();
            CustomDialog().set(
              context: context,
              title: 'إضافة خزينة جديدة',
              confirm: () {
                if (controller.formKey.currentState!.validate()) {
                  controller.createSafe();
                }
              },
              body: const SafeForm(),
            );
          },
        ),
        const TransferAddBotton(),
        GetBuilder<SafeController>(builder: (controller) {
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
