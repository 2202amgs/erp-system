import 'package:flutter/material.dart';
import 'package:frontend/app/core/utils/add_button.dart';
import 'package:frontend/app/core/utils/archive_toolbar_button.dart';
import 'package:frontend/app/core/utils/custom_dialog.dart';
import 'package:frontend/presentation/main/controllers/expenses_controller.dart';
import 'package:frontend/presentation/main/view/widgets/expenses/expenses_form.dart';
import 'package:get/get.dart';

class ExpensesToolBar extends StatelessWidget {
  const ExpensesToolBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExpensesController>(
      builder: (controller) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AddButton(
              label: 'إضافة قسم مصروفات جديد',
              onPressed: () {
                controller.clearControllers();
                CustomDialog().set(
                  context: context,
                  title: 'إضافة قسم مصروفات جديد',
                  confirm: () {
                    if (controller.formKey.currentState!.validate()) {
                      controller.createExpenses();
                    }
                  },
                  body: const ExpensesForm(),
                );
              },
            ),
            ArchiveToolBarButton(
              isArchive: controller.archive,
              onPressed: () {
                controller.archive = !controller.archive;
                controller.update();
              },
            ),
          ],
        );
      },
    );
  }
}
