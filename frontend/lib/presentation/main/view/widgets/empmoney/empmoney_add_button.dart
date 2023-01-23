import 'package:flutter/material.dart';
import 'package:frontend/app/core/utils/custom_dialog.dart';
import 'package:frontend/presentation/main/controllers/empmoney_controller.dart';
import 'package:frontend/presentation/main/view/widgets/empmoney/empmoney_form.dart';
import 'package:get/get.dart';

class EmpMoneyAddBotton extends GetView<EmpMoneyController> {
  const EmpMoneyAddBotton({Key? key, this.onFinish}) : super(key: key);
  final void Function()? onFinish;
  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'إضافة مستحقات الموظف',
      child: IconButton(
        onPressed: () {
          controller.clearControllers();
          CustomDialog().set(
            context: context,
            title: 'إضافة مستحقات الموظف',
            confirm: () async {
              if (controller.formKey.currentState!.validate()) {
                await controller.createEmpMoney(DateTime.now());
                if (onFinish != null) onFinish!();
              }
            },
            body: EmpMoneyForm(),
          );
        },
        icon: const Icon(Icons.money_outlined),
      ),
    );
  }
}
