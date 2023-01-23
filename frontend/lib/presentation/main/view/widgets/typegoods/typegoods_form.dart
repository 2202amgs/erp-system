import 'package:flutter/material.dart';
import 'package:frontend/app/core/constants/app_sizes.dart';
import 'package:frontend/app/core/utils/custom_form_field.dart';
import 'package:frontend/presentation/main/controllers/typegoods_contoller.dart';
import 'package:get/get.dart';

class TypeGoodsForm extends GetView<TypeGoodsController> {
  const TypeGoodsForm({super.key});

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
              controller: controller.nameController,
              label: 'اسم الصنف',
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
