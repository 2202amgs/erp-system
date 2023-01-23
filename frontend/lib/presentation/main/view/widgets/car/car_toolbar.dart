import 'package:flutter/material.dart';
import 'package:frontend/app/core/utils/add_button.dart';
import 'package:frontend/app/core/utils/archive_toolbar_button.dart';
import 'package:frontend/app/core/utils/custom_dialog.dart';
import 'package:frontend/presentation/main/controllers/car_controller.dart';
import 'package:frontend/presentation/main/view/widgets/car/car_form.dart';
import 'package:get/get.dart';

class CarToolBar extends GetView<CarController> {
  const CarToolBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CarController>(
      builder: (controller) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButton(
              items: const [
                DropdownMenuItem(value: null, child: Text('الكل')),
                DropdownMenuItem(value: true, child: Text('سايلون')),
                DropdownMenuItem(value: false, child: Text('عادى'))
              ],
              onChanged: (value) {
                controller.setType(value);
              },
              value: controller.type,
            ),
            AddButton(
              label: 'إضافة سيارة جديدة',
              onPressed: () {
                controller.clearControllers();
                CustomDialog().set(
                  context: context,
                  title: 'إضافة سيارة جديدة',
                  confirm: () {
                    if (controller.formKey.currentState!.validate()) {
                      controller.createCar();
                    }
                  },
                  body: const CarForm(),
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
