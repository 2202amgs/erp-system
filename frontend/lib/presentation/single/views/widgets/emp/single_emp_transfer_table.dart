import 'package:flutter/material.dart';
import 'package:frontend/app/core/utils/custom_dialog.dart';
import 'package:frontend/app/core/utils/custom_table.dart';
import 'package:frontend/data/models/single_emp_model.dart';
import 'package:frontend/presentation/main/controllers/transfer_controller.dart';
import 'package:frontend/presentation/main/view/widgets/transfer/transfer_form.dart';
import 'package:frontend/presentation/single/controllers/single_emp_controller.dart';
import 'package:get/get.dart';

class SingleEmpTransferTable extends StatelessWidget {
  SingleEmpTransferTable({Key? key}) : super(key: key);
  final SingleEmpController controller = Get.find();
  final TransferController _transferController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('دفعات', style: Theme.of(context).textTheme.headline2),
        CustomDataTable(
          columns: controller.comlumnOfTransfer
              .map((e) => DataColumn(label: Text(e)))
              .toList(),
          rows: _listOfTransfers(context),
        ),
      ],
    );
  }

  // Generate List Of Shipments
  List<DataRow> _listOfTransfers(BuildContext context) {
    SingleEmpModel scm = controller.singleEmpModel!;
    return [
      ...List.generate(
        scm.transfers!.length,
        (index) => DataRow(
          color: MaterialStateProperty.all(
            scm.transfers![index].senderId ==
                    controller.singleEmpModel!.user!.id
                ? Theme.of(context).canvasColor
                : Theme.of(context).scaffoldBackgroundColor,
          ),
          cells: controller
              .cellsOfTransfer(index)
              .map((e) => DataCell(Text(e.toString())))
              .toList(),
          onLongPress: () => _onDelete(context, index),
          onSelectChanged: (value) => _onEdit(context, index),
        ),
      ),
    ];
  }

  // Delete Form Show
  void _onDelete(BuildContext context, int index) {
    SingleEmpModel scm = controller.singleEmpModel!;
    CustomDialog().remove(
      context: context,
      title: "حذف الدفعة",
      confirm: () async {
        await _transferController.deleteTransfer(scm.transfers![index].id!);
        controller.getSingleEmp();
      },
    );
  }

  // Edit Form Show
  void _onEdit(BuildContext context, int index) {
    SingleEmpModel scm = controller.singleEmpModel!;
    _transferController.modelToController(scm.transfers![index]);
    CustomDialog().set(
      context: context,
      title: 'تعديل الدفعة',
      confirm: () async {
        await _transferController.transferUpdate(scm.transfers![index]);
        controller.getSingleEmp();
      },
      body: TransferForm(),
    );
  }
}
