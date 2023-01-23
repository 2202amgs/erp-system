// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:frontend/app/core/constants/app_sizes.dart';
import 'package:frontend/app/core/utils/custom_dialog.dart';
import 'package:frontend/app/core/utils/custom_table.dart';
import 'package:frontend/data/models/transfer_model.dart';
import 'package:frontend/presentation/main/controllers/transfer_controller.dart';
import 'package:frontend/presentation/main/view/widgets/transfer/transfer_form.dart';
import 'package:frontend/presentation/single/controllers/single_car_controller.dart';
import 'package:get/get.dart';

class AdvanceDataTable extends StatelessWidget {
  AdvanceDataTable({
    Key? key,
  }) : super(key: key);
  final SingleCarController controller = Get.find();
  final TransferController _transferController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomDataTable(
          columns: controller.columnsOfAdvance
              .map((e) => DataColumn(label: Text(e)))
              .toList(),
          rows: [
            ..._listOfAdvances(context),
            _footer(context),
          ],
        ),
      ],
    );
  }

  // create footer
  DataRow _footer(BuildContext context) {
    return DataRow(
      color: MaterialStatePropertyAll<Color?>(Theme.of(context).hintColor),
      cells: [
        const DataCell(Text('الإجـــمــالــى')),
        DataCell(Icon(
          Icons.arrow_forward_outlined,
          size: AppSize.s11,
          color: Theme.of(context).secondaryHeaderColor,
        )),
        DataCell(
          Text(controller.totalAdvance.toString()),
        ),
      ],
    );
  }

  // generate list advance
  List<DataRow> _listOfAdvances(BuildContext context) {
    return controller
        .getTransfers()
        .map(
          (transfer) => DataRow(
            color: MaterialStateProperty.all(
              transfer.senderId == controller.carId
                  ? Theme.of(context).canvasColor
                  : Theme.of(context).scaffoldBackgroundColor,
            ),
            cells: [
              DataCell(Text(transfer.date!.substring(0, 10))),
              DataCell(Text(transfer.description!)),
              DataCell(Text(transfer.amount!.toString())),
            ],
            onLongPress: () => _onDelete(context, transfer),
            onSelectChanged: (value) => _onEdit(context, transfer),
          ),
        )
        .toList();
  }

  // On Edit Advance
  void _onEdit(BuildContext context, TransferModel transfer) {
    _transferController.modelToController(transfer);
    CustomDialog().set(
      context: context,
      title: 'تعديل السلفة/السداد',
      confirm: () async {
        await _transferController.transferUpdate(transfer);
        controller.getSingleCar();
      },
      body: TransferForm(),
    );
  }

  // on delete davance
  void _onDelete(BuildContext context, TransferModel transfer) {
    CustomDialog().remove(
      context: context,
      title: "حذف السلفة/السداد",
      confirm: () async {
        await _transferController.deleteTransfer(transfer.id!);
        controller.getSingleCar();
      },
    );
  }
}
