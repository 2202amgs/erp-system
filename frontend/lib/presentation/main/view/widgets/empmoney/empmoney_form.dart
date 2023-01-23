import 'package:flutter/material.dart';

import 'package:frontend/app/core/constants/app_sizes.dart';
import 'package:frontend/app/core/shared/dropdown_lists.dart';
import 'package:frontend/app/core/utils/custom_form_field.dart';
import 'package:frontend/presentation/main/controllers/empmoney_controller.dart';
import 'package:frontend/presentation/main/controllers/user_controller.dart';
import 'package:get/get.dart';

class EmpMoneyForm extends GetView<EmpMoneyController> {
  EmpMoneyForm({super.key});
  final UserController _userController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Container(
        width: 400,
        padding: EdgeInsets.all(AppSize.s2),
        color: Theme.of(context).scaffoldBackgroundColor,
        child: GetBuilder<EmpMoneyController>(builder: (controller) {
          return Wrap(
            runSpacing: AppSize.s2,
            children: [
              DropdownButtonFormField(
                items: userList(_userController, controller.empId),
                onChanged: (value) {
                  controller.setEmployeeId(value!);
                },
                hint: const Text('الموظف'),
                value: controller.empId,
                validator: (value) {
                  if (value == null) {
                    return 'أختر الموظف';
                  }
                  return null;
                },
              ),
              CustomFormField(
                controller: controller.amountController,
                label: 'المبلغ',
                validator: (value) {
                  if (value.toString().isEmpty) {
                    return 'أملأ الحقل';
                  }
                  return null;
                },
                formatType: FormatTypes.float,
              ),
              CustomFormField(
                controller: controller.descriptionController,
                label: 'الوصف',
                validator: (value) {
                  if (value.toString().isEmpty) {
                    return 'أملأ الحقل';
                  }
                  return null;
                },
              ),
            ],
          );
        }),
      ),
    );
  }
}
