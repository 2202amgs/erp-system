import 'package:flutter/material.dart';
import 'package:frontend/app/core/constants/app_sizes.dart';
import 'package:frontend/app/core/utils/custom_form_field.dart';
import 'package:frontend/presentation/main/controllers/expenses_controller.dart';
import 'package:get/get.dart';

class ExpensesForm extends GetView<ExpensesController> {
  const ExpensesForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Container(
        width: 400,
        padding: EdgeInsets.all(AppSize.s2),
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Wrap(
          runSpacing: AppSize.s2,
          children: [
            CustomFormField(
              controller: controller.name,
              label: 'اسم القسم',
              validator: (value) {
                if (value.toString().isEmpty) {
                  return 'أملأ الحقل';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
