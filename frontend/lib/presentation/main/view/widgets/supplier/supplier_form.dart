import 'package:flutter/material.dart';
import 'package:frontend/app/core/constants/app_sizes.dart';
import 'package:frontend/app/core/utils/custom_form_field.dart';
import 'package:frontend/presentation/main/controllers/supplier_controller.dart';
import 'package:get/get.dart';

class SupplierForm extends GetView<SupplierController> {
  const SupplierForm({super.key});

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
              controller: controller.clientNameController,
              label: 'اسم المورد',
              validator: (value) {
                if (value.toString().isEmpty) {
                  return 'أملأ الحقل';
                }
                return null;
              },
            ),
            CustomFormField(
              controller: controller.ponNameController,
              label: 'اسم البون',
              validator: (value) {
                if (value.toString().isEmpty) {
                  return 'أملأ الحقل';
                }
                return null;
              },
            ),
            CustomFormField(
              controller: controller.phoneController,
              label: 'رقم الهاتف',
              formatType: FormatTypes.int,
            ),
          ],
        ),
      ),
    );
  }
}
