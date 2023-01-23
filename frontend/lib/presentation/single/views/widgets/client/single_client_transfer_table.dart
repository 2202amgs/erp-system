import 'package:flutter/material.dart';
import 'package:frontend/app/core/utils/custom_dialog.dart';
import 'package:frontend/app/core/utils/custom_table.dart';
import 'package:frontend/app/core/utils/no_data.dart';
import 'package:frontend/data/models/single_client_model.dart';
import 'package:frontend/presentation/main/controllers/transfer_controller.dart';
import 'package:frontend/presentation/main/view/widgets/transfer/transfer_form.dart';
import 'package:frontend/presentation/single/controllers/single_client_controller.dart';
import 'package:get/get.dart';

class SingleClientTransferTable extends StatelessWidget {
  SingleClientTransferTable({Key? key}) : super(key: key);
  final SingleClientController controller = Get.find();
  final TransferController _transferController = Get.find();
  @override
  Widget build(BuildContext context) {
    if (controller.singleClientModel!.transfers!.isEmpty) {
      return const NoData();
    }
    return SingleChildScrollView(
      child: Center(
        child: CustomDataTable(
          columns: ['م', 'التاريخ', 'الوصف', 'المبلغ']
              .map((e) => DataColumn(label: Text(e)))
              .toList(),
          rows: _listOfTransfers(context),
        ),
      ),
    );
  }

  // Generate List Of Transfer
  List<DataRow> _listOfTransfers(BuildContext context) {
    SingleClientModel scm = controller.singleClientModel!;
    return [
      ...List.generate(
        scm.transfers!.length,
        (index) => DataRow(
          color: MaterialStateProperty.all(
            scm.transfers![index].receiverId ==
                    controller.singleClientModel!.client!.id
                ? Theme.of(context).canvasColor
                : Theme.of(context).scaffoldBackgroundColor,
          ),
          cells: [
            DataCell(Text((index + 1).toString())),
            DataCell(Text(scm.transfers![index].date!.substring(0, 10))),
            DataCell(Text(scm.transfers![index].description!)),
            DataCell(Text(scm.transfers![index].amount.toString())),
          ],
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
        await _transferController.deleteTransfer(scm.transfers![index].id!);
        controller.getSingleClient();
      },
    );
  }

  // Edit Form Show
  void _onEdit(BuildContext context, int index) {
    SingleClientModel scm = controller.singleClientModel!;
    _transferController.modelToController(scm.transfers![index]);
    CustomDialog().set(
      context: context,
      title: 'تعديل الدفعة',
      confirm: () async {
        await _transferController.transferUpdate(scm.transfers![index]);
        controller.getSingleClient();
      },
      body: TransferForm(),
    );
  }
}
