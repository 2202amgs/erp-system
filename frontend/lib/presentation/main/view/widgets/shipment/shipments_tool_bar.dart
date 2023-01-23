import 'package:flutter/material.dart';
import 'package:frontend/app/core/utils/add_button.dart';
import 'package:frontend/app/core/utils/custom_dialog.dart';
import 'package:frontend/app/core/utils/date_range_button.dart';
import 'package:frontend/app/core/utils/printing_button.dart';
import 'package:frontend/presentation/main/controllers/shipments_controller.dart';
import 'package:frontend/presentation/main/view/widgets/shipment/shipment_form.dart';
import 'package:frontend/presentation/printing/views/screens/daily_pdf.dart';
import 'package:frontend/presentation/printing/views/screens/printing_screen.dart';
import 'package:get/get.dart';

class ShipmentsToolBar extends GetView<ShipmentsController> {
  const ShipmentsToolBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AddButton(
          label: 'إضافة نقلة جديدة',
          onPressed: () {
            controller.clearControllers();
            CustomDialog().set(
              context: context,
              title: 'إضافة نقلة جديدة',
              confirm: () async {
                if (controller.formKey.currentState!.validate()) {
                  await controller.createShipment();
                  // Get.back();
                }
              },
              body: ShipmentForm(),
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
              controller.getShipments();
            }
          },
        ),
        PrintingButton(
          onPressed: () {
            Get.to(PrintingScreen('اليومية', page: dailyPdf()));
          },
        ),
      ],
    );
  }
}
