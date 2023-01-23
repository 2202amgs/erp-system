import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:frontend/app/core/utils/custom_dialog.dart';
import 'package:frontend/app/core/utils/custom_table.dart';
import 'package:frontend/app/core/utils/no_data.dart';
import 'package:frontend/presentation/main/controllers/shipments_controller.dart';
import 'package:frontend/presentation/main/view/widgets/shipment/shipment_form.dart';
import 'package:get/get.dart';

class ShipmentTable extends GetView<ShipmentsController> {
  const ShipmentTable({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GetBuilder<ShipmentsController>(
        builder: (controller) {
          return Conditional.single(
            context: context,
            conditionBuilder: (context) => controller.shipments.isNotEmpty,
            widgetBuilder: (context) => Conditional.single(
              context: context,
              conditionBuilder: (context) => controller.isLoad,
              widgetBuilder: (context) =>
                  const Center(child: RefreshProgressIndicator()),
              fallbackBuilder: (context) => CustomDataTable(
                columns: controller
                    .column()
                    .map((e) => DataColumn(label: Text(e)))
                    .toList(),
                rows: List.generate(
                  controller.shipments.length,
                  (index) => DataRow(
                    onLongPress: () => _onDelete(context, index),
                    onSelectChanged: (v) => _onUpdate(context, index),
                    cells: controller
                        .cells(index)
                        .map((c) => DataCell(Text(c)))
                        .toList(),
                  ),
                ),
              ),
            ),
            fallbackBuilder: (context) => const NoData(),
          );
        },
      ),
    );
  }

  void _onUpdate(context, index) {
    controller.modelToController(controller.shipments[index]);
    CustomDialog().set(
      context: context,
      title: 'تعديل نقلة',
      confirm: () async {
        if (controller.formKey.currentState!.validate()) {
          await controller.shipmentUpdate(controller.shipments[index]);
          controller.getShipments();
        }
      },
      body: ShipmentForm(),
    );
  }

  void _onDelete(context, index) {
    CustomDialog().remove(
      context: context,
      title: 'تعديل نقلة',
      confirm: () async {
        await controller.deleteShipment(controller.shipments[index].id!);
        await controller.getShipments();
      },
    );
  }
}
