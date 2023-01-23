import 'package:flutter/material.dart';
import 'package:frontend/app/core/utils/custom_dialog.dart';
import 'package:frontend/app/core/utils/custom_table.dart';
import 'package:frontend/data/models/single_bank_model.dart';
import 'package:frontend/presentation/main/controllers/transfer_controller.dart';
import 'package:frontend/presentation/main/view/widgets/transfer/transfer_form.dart';
import 'package:frontend/presentation/single/controllers/single_bank_controller.dart';
import 'package:get/get.dart';

class SingleBankTransferTable extends StatelessWidget {
  SingleBankTransferTable({Key? key}) : super(key: key);
  final SingleBankController controller = Get.find();
  final TransferController _transferController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Center(
          child: CustomDataTable(
            columns: ['التاريخ', 'الوصف', 'المرسل', 'المرسل إليه', 'المبلغ']
                .map((e) => DataColumn(label: Text(e)))
                .toList(),
            rows: _listOfTransfers(context),
          ),
        ),
      ),
    );
  }

  // Generate List Of Shipments
  List<DataRow> _listOfTransfers(BuildContext context) {
    SingleBankModel scm = controller.singleBankModel!;
    return [
      ...List.generate(
        scm.transfers!.length,
        (index) => DataRow(
          color: MaterialStateProperty.all(
            scm.transfers![index].senderId ==
                    controller.singleBankModel!.bank!.id
                ? Theme.of(context).scaffoldBackgroundColor
                : Theme.of(context).canvasColor,
          ),
          cells: [
            DataCell(Text(scm.transfers![index].date!.substring(0, 10))),
            DataCell(Text(scm.transfers![index].description!)),
            DataCell(Text(scm.transfers![index].senderName!)),
            DataCell(Text(scm.transfers![index].receiverName!)),
            DataCell(Text(scm.transfers![index].amount!.toString())),
          ],
          onLongPress: () => _onDelete(context, index),
          onSelectChanged: (value) => _onEdit(context, index),
        ),
      ),
    ];
  }

  // Delete Form Show
  void _onDelete(BuildContext context, int index) {
    SingleBankModel scm = controller.singleBankModel!;
    CustomDialog().remove(
      context: context,
      title: "حذف الدفعة",
      confirm: () async {
        await _transferController.deleteTransfer(scm.transfers![index].id!);
        controller.getSingleBank();
      },
    );
  }

  // Edit Form Show
  void _onEdit(BuildContext context, int index) {
    SingleBankModel scm = controller.singleBankModel!;
    _transferController.modelToController(scm.transfers![index]);
    CustomDialog().set(
      context: context,
      title: 'تعديل الدفعة',
      confirm: () async {
        await _transferController.transferUpdate(scm.transfers![index]);
        controller.getSingleBank();
      },
      body: TransferForm(),
    );
  }
}
