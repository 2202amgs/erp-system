import 'package:flutter/material.dart';
import 'package:frontend/app/core/utils/add_button.dart';
import 'package:frontend/app/core/utils/archive_toolbar_button.dart';
import 'package:frontend/app/core/utils/custom_dialog.dart';
import 'package:frontend/presentation/main/controllers/supplier_controller.dart';
import 'package:frontend/presentation/main/view/widgets/buygoods/buygoods_add_button.dart';
import 'package:frontend/presentation/main/view/widgets/supplier/supplier_form.dart';
import 'package:get/get.dart';

class SupplierToolBar extends GetView<SupplierController> {
  const SupplierToolBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AddButton(
          label: 'إضافة مورد جديد',
          onPressed: () {
            controller.clearControllers();
            CustomDialog().set(
              context: context,
              title: 'إضافة مورد جديد',
              confirm: () {
                if (controller.formKey.currentState!.validate()) {
                  controller.createSupplier();
                }
              },
              body: const SupplierForm(),
            );
          },
        ),
        const BuyGoodsAddBotton(),
        GetBuilder<SupplierController>(builder: (controller) {
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
