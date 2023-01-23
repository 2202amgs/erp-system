import 'package:flutter/material.dart';
import 'package:frontend/app/core/utils/custom_dialog.dart';
import 'package:frontend/app/core/utils/custom_table.dart';
import 'package:frontend/data/models/single_emp_model.dart';
import 'package:frontend/presentation/main/controllers/empmoney_controller.dart';
import 'package:frontend/presentation/main/view/widgets/empmoney/empmoney_form.dart';
import 'package:frontend/presentation/single/controllers/single_emp_controller.dart';
import 'package:get/get.dart';

class SingleEmpMoneyTable extends StatelessWidget {
  SingleEmpMoneyTable({Key? key}) : super(key: key);
  final SingleEmpController controller = Get.find();
  final EmpMoneyController _empMoneyController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('مستحقات', style: Theme.of(context).textTheme.headline2),
        CustomDataTable(
          columns: controller.columns
              .map((e) => DataColumn(label: Text(e)))
              .toList(),
          rows: _listOfEmpMoney(context),
        ),
      ],
    );
  }

  // Generate List Of Shipments
  List<DataRow> _listOfEmpMoney(BuildContext context) {
    SingleEmpModel scm = controller.singleEmpModel!;
    return [
      ...List.generate(
        scm.empMoney!.length,
        (index) => DataRow(
          cells: controller
              .cells(index)
              .map(
                (e) => DataCell(Text(e.toString())),
              )
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
        await _empMoneyController.deleteEmpMoney(scm.empMoney![index].id!);
        controller.getSingleEmp();
      },
    );
  }

  // Edit Form Show
  void _onEdit(BuildContext context, int index) {
    SingleEmpModel scm = controller.singleEmpModel!;
    _empMoneyController.modelToController(scm.empMoney![index]);
    CustomDialog().set(
      context: context,
      title: 'تعديل الدفعة',
      confirm: () async {
        await _empMoneyController.empMoneyUpdate(scm.empMoney![index]);
        controller.getSingleEmp();
      },
      body: EmpMoneyForm(),
    );
  }
}
