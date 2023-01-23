import 'package:flutter/material.dart';
import 'package:frontend/app/core/utils/custom_dialog.dart';
import 'package:frontend/app/core/utils/custom_table.dart';
import 'package:frontend/app/core/utils/no_data.dart';
import 'package:frontend/data/models/single_client_model.dart';
import 'package:frontend/presentation/main/controllers/shipments_controller.dart';
import 'package:frontend/presentation/main/view/widgets/shipment/shipment_form.dart';
import 'package:frontend/presentation/single/controllers/single_client_controller.dart';
import 'package:get/get.dart';

class SingleClientShipmentTable extends StatelessWidget {
  SingleClientShipmentTable({Key? key}) : super(key: key);
  final SingleClientController controller = Get.find();
  final ShipmentsController _shipmentsController = Get.find();
  @override
  Widget build(BuildContext context) {
    if (controller.singleClientModel!.shipments!.isEmpty) {
      return const NoData();
    }
    return SingleChildScrollView(
      child: Center(
        child: CustomDataTable(
          columns:
              controller.column.map((s) => DataColumn(label: Text(s))).toList(),
          rows: _listOfShipments(context),
        ),
      ),
    );
  }

  // Generate List Of Shipments
  List<DataRow> _listOfShipments(BuildContext context) {
    SingleClientModel scm = controller.singleClientModel!;
    return [
      ...List.generate(
        scm.shipments!.length,
        (index) => DataRow(
          color: MaterialStateProperty.all(
            scm.shipments![index].typeGoodsId != null
                ? Theme.of(context).canvasColor
                : Theme.of(context).scaffoldBackgroundColor,
          ),
          cells: controller.cells(scm.shipments![index], index),
          onLongPress: () => _onDelete(context, index),
          onSelectChanged: (value) => _onEdit(context, index),
        ),
      ),
    ];
  }

  // Delete Form Show
  void _onDelete(BuildContext context, int index) {
    SingleClientModel scm = controller.singleClientModel!;
    CustomDialog().remove(
      context: context,
      title: "حذف الدفعة",
      confirm: () async {
        await _shipmentsController.deleteShipment(scm.shipments![index].id!);
        controller.getSingleClient();
      },
    );
  }

  // Edit Form Show
  void _onEdit(BuildContext context, int index) {
    SingleClientModel scm = controller.singleClientModel!;
    _shipmentsController.modelToController(scm.shipments![index]);
    CustomDialog().set(
      context: context,
      title: 'تعديل الدفعة',
      confirm: () async {
        await _shipmentsController.shipmentUpdate(scm.shipments![index]);
        controller.getSingleClient();
      },
      body: ShipmentForm(),
    );
  }
}
