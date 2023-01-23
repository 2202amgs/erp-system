import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:frontend/app/core/utils/custom_dialog.dart';
import 'package:frontend/app/core/utils/custom_table.dart';
import 'package:frontend/app/core/utils/no_data.dart';
import 'package:frontend/presentation/main/controllers/polices_controller.dart';
import 'package:frontend/presentation/main/view/widgets/policy/policy_form.dart';
import 'package:get/get.dart';

class PolicyTable extends GetView<PolicyController> {
  const PolicyTable({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GetBuilder<PolicyController>(
        builder: (controller) {
          return Conditional.single(
            context: context,
            conditionBuilder: (context) => controller.polices.isNotEmpty,
            widgetBuilder: (context) => Conditional.single(
              context: context,
              conditionBuilder: (context) => controller.isLoad,
              widgetBuilder: (context) =>
                  const Center(child: RefreshProgressIndicator()),
              fallbackBuilder: (context) => Center(
                child: CustomDataTable(
                  columns: controller
                      .column()
                      .map((e) => DataColumn(label: Text(e)))
                      .toList(),
                  rows: List.generate(
                    controller.polices.length,
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
            ),
            fallbackBuilder: (context) => const NoData(),
          );
        },
      ),
    );
  }

  void _onUpdate(context, index) {
    controller.modelToController(controller.polices[index]);
    CustomDialog().set(
      context: context,
      title: 'تعديل البواليص',
      confirm: () async {
        if (controller.formKey.currentState!.validate()) {
          await controller.policyUpdate(controller.polices[index]);
          controller.getPolices();
        }
      },
      body: const PolicyForm(),
    );
  }

  void _onDelete(context, index) {
    CustomDialog().remove(
      context: context,
      title: 'حذف البواليص',
      confirm: () async {
        await controller.deletePolicy(controller.polices[index].id!);
        await controller.getPolices();
      },
    );
  }
}
