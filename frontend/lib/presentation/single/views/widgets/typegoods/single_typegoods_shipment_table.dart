import 'package:flutter/material.dart';
import 'package:frontend/app/core/utils/custom_dialog.dart';
import 'package:frontend/app/core/utils/custom_table.dart';
import 'package:frontend/data/models/single_type_goods_model.dart';
import 'package:frontend/presentation/main/controllers/shipments_controller.dart';
import 'package:frontend/presentation/main/view/widgets/shipment/shipment_form.dart';
import 'package:frontend/presentation/single/controllers/single_typegoods_controller.dart';
import 'package:get/get.dart';

class SingleTypeGoodsShipmentTable extends StatelessWidget {
  SingleTypeGoodsShipmentTable({Key? key}) : super(key: key);
  final SingleTypeGoodsController controller = Get.find();
  final ShipmentsController _shipmentsController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('مبيعات', style: Theme.of(context).textTheme.headline2),
        CustomDataTable(
          columns: _listOfColumn(),
          rows: _listOfShipments(context),
        ),
      ],
    );
  }

  // Generate List Of Shipments
  List<DataRow> _listOfShipments(BuildContext context) {
    SingleTypeGoodsModel scm = controller.singleTypeGoodsModel!;
    return [
      ...List.generate(
        scm.shipments!.length,
        (index) => DataRow(
          color: MaterialStateProperty.all(
            scm.shipments![index].typeGoodsId != null
                ? Theme.of(context).canvasColor
                : Theme.of(context).scaffoldBackgroundColor,
          ),
          cells: _listofCells(index),
          onLongPress: () => _onDelete(context, index),
          onSelectChanged: (value) => _onEdit(context, index),
        ),
      ),
    ];
  }

  // Delete Form Show
  void _onDelete(BuildContext context, int index) {
    SingleTypeGoodsModel scm = controller.singleTypeGoodsModel!;
    CustomDialog().remove(
      context: context,
      title: "حذف الدفعة",
      confirm: () async {
        await _shipmentsController.deleteShipment(scm.shipments![index].id!);
        controller.getSingleTypeGoods();
      },
    );
  }

  // Edit Form Show
  void _onEdit(BuildContext context, int index) {
    SingleTypeGoodsModel scm = controller.singleTypeGoodsModel!;
    _shipmentsController.modelToController(scm.shipments![index]);
    CustomDialog().set(
      context: context,
      title: 'تعديل الدفعة',
      confirm: () async {
        await _shipmentsController.shipmentUpdate(scm.shipments![index]);
        controller.getSingleTypeGoods();
      },
      body: ShipmentForm(),
    );
  }

  // column generated
  List<DataColumn> _listOfColumn() {
    return controller.columnsOfShipments
        .map((e) => DataColumn(label: Text(e)))
        .toList();
  }

  // cells generated
  List<DataCell> _listofCells(int index) {
    return controller
        .cellsOfShipment(index)
        .map((s) => DataCell(Text(s.toString())))
        .toList();
  }
}
