import 'package:flutter/material.dart';
import 'package:frontend/app/core/utils/add_button.dart';
import 'package:frontend/app/core/utils/archive_toolbar_button.dart';
import 'package:frontend/app/core/utils/custom_dialog.dart';
import 'package:frontend/presentation/main/controllers/typegoods_contoller.dart';
import 'package:frontend/presentation/main/view/widgets/buygoods/buygoods_add_button.dart';
import 'package:frontend/presentation/main/view/widgets/typegoods/typegoods_form.dart';
import 'package:get/get.dart';

class TypeGoodsToolBar extends GetView<TypeGoodsController> {
  const TypeGoodsToolBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AddButton(
          label: 'إضافة صنف جديد',
          onPressed: () {
            controller.clearControllers();
            CustomDialog().set(
              context: context,
              title: 'إضافة صنف جديد',
              confirm: () {
                if (controller.formKey.currentState!.validate()) {
                  controller.createTypeGoods();
                }
              },
              body: const TypeGoodsForm(),
            );
          },
        ),
        const BuyGoodsAddBotton(),
        GetBuilder<TypeGoodsController>(builder: (controller) {
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
