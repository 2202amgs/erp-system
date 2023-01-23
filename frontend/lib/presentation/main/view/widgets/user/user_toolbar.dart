import 'package:flutter/material.dart';
import 'package:frontend/app/core/utils/add_button.dart';
import 'package:frontend/app/core/utils/archive_toolbar_button.dart';
import 'package:frontend/app/core/utils/custom_dialog.dart';
import 'package:frontend/presentation/main/controllers/user_controller.dart';
import 'package:frontend/presentation/main/view/widgets/empmoney/empmoney_add_button.dart';
import 'package:frontend/presentation/main/view/widgets/transfer/transfer_add_button.dart';
import 'package:frontend/presentation/main/view/widgets/user/user_form.dart';
import 'package:get/get.dart';

class UserToolBar extends GetView<UserController> {
  const UserToolBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AddButton(
          label: 'إضافة موظف جديد',
          onPressed: () {
            controller.clearControllers();
            CustomDialog().set(
              context: context,
              title: 'إضافة موظف جديد',
              confirm: () {
                if (controller.formKey.currentState!.validate()) {
                  controller.createUser();
                }
              },
              body: const UserForm(),
            );
          },
        ),
        const EmpMoneyAddBotton(),
        const TransferAddBotton(),
        GetBuilder<UserController>(builder: (controller) {
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
