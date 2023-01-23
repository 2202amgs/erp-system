import 'package:flutter/material.dart';
import 'package:frontend/app/core/types/car_table_type.dart';
import 'package:frontend/app/core/utils/custom_dialog.dart';
import 'package:frontend/app/core/utils/custom_table.dart';
import 'package:frontend/data/models/shipment_model.dart';
import 'package:frontend/presentation/main/controllers/shipments_controller.dart';
import 'package:frontend/presentation/main/view/widgets/shipment/shipment_form.dart';
import 'package:frontend/presentation/single/controllers/single_car_controller.dart';
import 'package:get/get.dart';

class SingleCarShipmentsTable extends StatelessWidget {
  SingleCarShipmentsTable({Key? key}) : super(key: key);
  final SingleCarController controller = Get.find();
  final ShipmentsController shipmentsController = Get.find();
  // final CarTableType type;

  @override
  Widget build(BuildContext context) {
    return CustomDataTable(
      columns: _listOfColumn(),
      rows: [
        ..._listOfShipmentsRow(context),
        _footer(context),
      ],
    );
  }

  // list of shipments rows
  List<DataRow> _listOfShipmentsRow(BuildContext context) {
    return List.generate(
      controller.singleCarModel!.shipments.length,
      (index) => DataRow(
        onLongPress: () => _onDelete(context, index),
        onSelectChanged: (value) => _onEdit(context, index),
        cells: _listofCells(index),
      ),
    ).toList();
  }

  // on edit one shipment
  void _onEdit(BuildContext context, int index) {
    shipmentsController.modelToController(
      controller.singleCarModel!.shipments[index],
    );
    CustomDialog().set(
      context: context,
      title: 'تعديل النقلة',
      confirm: () async {
        await shipmentsController.shipmentUpdate(
          controller.singleCarModel!.shipments[index],
        );
        controller.getSingleCar();
      },
      body: ShipmentForm(),
    );
  }

  // on delete one shipment
  void _onDelete(BuildContext context, int index) {
    CustomDialog().remove(
      context: context,
      title: "حذف النقلة",
      confirm: () async {
        await shipmentsController.deleteShipment(
          controller.singleCarModel!.shipments[index].id!,
        );
        controller.getSingleCar();
      },
    );
  }

  // column generated
  List<DataColumn> _listOfColumn() {
    return controller.columns.map((e) => DataColumn(label: Text(e))).toList();
  }

  // list of cells
  List<DataCell> _listofCells(int index) {
    ShipmentModel s = controller.singleCarModel!.shipments[index];
    num nolon = s.nolon!;
    if (controller.tableType == CarTableType.forCar) {
      nolon = s.nolon! * s.carRatio! / 100;
    } else if (controller.tableType == CarTableType.forLoco) {
      nolon = s.nolon! * (100 - s.carRatio!) / 100;
    }
    return [
      (index + 1).toString(),
      s.date.toString().substring(0, 10),
      s.clientName.toString(),
      s.driverName.toString(),
      s.factory.toString(),
      s.side.toString(),
      s.poneName.toString(),
      s.quantity.toString(),
      nolon.toStringAsFixed(2),
      s.tip.toString(),
      s.t3t.toString(),
      s.total.toString(),
      if (controller.tableType != CarTableType.forLoco) s.custody.toString(),
      if (controller.tableType == CarTableType.noramal)
        s.differenceNolon.toString(),
      s.carPureTotal.toString(),
      if (controller.tableType == CarTableType.forCar ||
          controller.tableType == CarTableType.sailon)
        s.carTotal,
      if (controller.tableType == CarTableType.forLoco ||
          controller.tableType == CarTableType.sailon)
        s.locoTotal
    ].map((s) => DataCell(Text(s.toString()))).toList();
  }

  // footer data row
  DataRow _footer(BuildContext context) {
    var data = controller.singleCarModel!.data!;
    return DataRow(
      color: MaterialStatePropertyAll<Color?>(Theme.of(context).hintColor),
      cells: [
        const DataCell(Text('----')),
        const DataCell(Text('الإجــمــالــى')),
        const DataCell(Text('----')),
        const DataCell(Text('----')),
        const DataCell(Text('----')),
        const DataCell(Text('----')),
        const DataCell(Text('----')),
        const DataCell(Text('----')),
        const DataCell(Text('----')),
        const DataCell(Text('----')),
        const DataCell(Text('----')),
        DataCell(Text(data.total.toString())),
        if (controller.tableType != CarTableType.forLoco)
          DataCell(Text(data.totalCustody.toString())),
        if (controller.tableType == CarTableType.noramal)
          DataCell(Text(data.totalDifferenceNolon.toString())),
        DataCell(Text(data.totalNewShipment.toString())),
        if (controller.tableType == CarTableType.forCar ||
            controller.tableType == CarTableType.sailon)
          DataCell(Text(data.totalNewShipmentForCar.toString())),
        if (controller.tableType == CarTableType.forLoco ||
            controller.tableType == CarTableType.sailon)
          DataCell(Text(data.totalNewShipmentForLoco.toString())),
      ],
    );
  }
}
