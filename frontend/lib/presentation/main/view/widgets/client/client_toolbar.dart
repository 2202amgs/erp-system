import 'package:flutter/material.dart';
import 'package:frontend/app/core/utils/add_button.dart';
import 'package:frontend/app/core/utils/archive_toolbar_button.dart';
import 'package:frontend/app/core/utils/custom_dialog.dart';
import 'package:frontend/presentation/main/controllers/client_controller.dart';
import 'package:frontend/presentation/main/view/widgets/buygoods/buygoods_add_button.dart';
import 'package:frontend/presentation/main/view/widgets/client/client_form.dart';
import 'package:get/get.dart';

class ClientToolBar extends GetView<ClientController> {
  const ClientToolBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AddButton(
          label: 'إضافة عميل جديد',
          onPressed: () {
            controller.clearControllers();
            CustomDialog().set(
              context: context,
              title: 'إضافة عميل جديد',
              confirm: () {
                if (controller.formKey.currentState!.validate()) {
                  controller.createClient();
                }
              },
              body: const ClientForm(),
            );
          },
        ),
        const BuyGoodsAddBotton(),
        GetBuilder<ClientController>(builder: (controller) {
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
