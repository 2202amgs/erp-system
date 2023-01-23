import 'package:flutter/material.dart';
import 'package:frontend/app/core/constants/app_sizes.dart';
import 'package:frontend/app/core/utils/custom_form_field.dart';
import 'package:frontend/presentation/main/controllers/polices_controller.dart';
import 'package:get/get.dart';

class PolicyForm extends StatelessWidget {
  const PolicyForm({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PolicyController>(
      builder: (controller) {
        return Form(
          key: controller.formKey,
          child: Container(
            width: 400,
            padding: EdgeInsets.all(AppSize.s2),
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Wrap(
              runSpacing: AppSize.s2,
              spacing: 10,
              alignment: WrapAlignment.spaceBetween,
              children: [
                CustomFormField(
                  controller: controller.accountController,
                  label: 'المبلغ',
                  formatType: FormatTypes.float,
                  validator: (value) {
                    if (value.toString().isEmpty) {
                      return 'أملأ الحقل';
                    }
                    return null;
                  },
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
            ),
          ),
        );
      },
    );
  }
}
