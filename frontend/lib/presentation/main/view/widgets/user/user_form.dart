import 'package:flutter/material.dart';
import 'package:frontend/app/core/constants/app_sizes.dart';
import 'package:frontend/app/core/utils/custom_form_field.dart';
import 'package:frontend/presentation/main/controllers/user_controller.dart';
import 'package:get/get.dart';

class UserForm extends GetView<UserController> {
  const UserForm({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(
      builder: (controller) {
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
                  label: 'اسم الموظف',
                  validator: (value) {
                    if (value.toString().isEmpty) {
                      return 'أملأ الحقل';
                    }
                    return null;
                  },
                ),
                CustomFormField(
                  controller: controller.emailController,
                  label: 'البريد الإلكترونى',
                  validator: (value) {
                    if (value.toString().isEmpty) {
                      return 'أملأ الحقل';
                    }
                    return null;
                  },
                ),
                CustomFormField(
                  controller: controller.passwordController,
                  label: 'كلمة المرور',
                  validator: (value) {
                    if (value.toString().isNotEmpty &&
                        value.toString().length < 8) {
                      return 'كلمة مرور قصيرة';
                    }
                    return null;
                  },
                ),
                SwitchListTile(
                  title: Text(
                    'مدير',
                    style: Theme.of(context).textTheme.headline6!,
                  ),
                  value: controller.isAdmin,
                  onChanged: (value) {
                    controller.setIsAdmin(value);
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
