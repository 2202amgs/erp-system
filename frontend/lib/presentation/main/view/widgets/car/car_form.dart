import 'package:flutter/material.dart';
import 'package:frontend/app/core/constants/app_sizes.dart';
import 'package:frontend/app/core/utils/custom_form_field.dart';
import 'package:frontend/presentation/main/controllers/car_controller.dart';
import 'package:get/get.dart';

class CarForm extends GetView<CarController> {
  const CarForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: GetBuilder<CarController>(
        builder: (controller) {
          return Container(
            width: 400,
            padding: EdgeInsets.all(AppSize.s2),
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Wrap(
              runSpacing: AppSize.s2,
              children: [
                CustomFormField(
                  controller: controller.ownerNameController,
                  label: 'اسم المالك',
                  validator: (value) {
                    if (value.toString().isEmpty) {
                      return 'أملأ الحقل';
                    }
                    return null;
                  },
                ),
                CustomFormField(
                  controller: controller.driverNameController,
                  label: 'اسم السائق',
                  validator: (value) {
                    if (value.toString().isEmpty) {
                      return 'أملأ الحقل';
                    }
                    return null;
                  },
                ),
                CustomFormField(
                  controller: controller.carNumberController,
                  label: 'رقم السيارة',
                  validator: (value) {
                    if (value.toString().isEmpty) {
                      return 'أملأ الحقل';
                    }
                    return null;
                  },
                  formatType: FormatTypes.int,
                ),
                CustomFormField(
                  controller: controller.locoNumberController,
                  label: 'رقم المقطورة',
                  validator: (value) {
                    if (value.toString().isEmpty) {
                      return 'أملأ الحقل';
                    }
                    return null;
                  },
                  formatType: FormatTypes.int,
                ),
                CustomFormField(
                  controller: controller.phoneController,
                  label: 'رقم الهاتف',
                  formatType: FormatTypes.int,
                ),
                if (controller.sailon)
                  CustomFormField(
                    controller: controller.carRatio,
                    label: 'نسبة الرأس',
                    formatType: FormatTypes.float,
                    validator: (value) {
                      String v = value.toString();
                      if (v.isEmpty || int.parse(v) > 100 || int.parse(v) < 0) {
                        return 'أدخل رقم بين 0 و 100';
                      }
                      return null;
                    },
                  ),
                SwitchListTile(
                  title: Text(
                    'سايلون',
                    style: Theme.of(context).textTheme.headline2!,
                  ),
                  value: controller.sailon,
                  onChanged: (value) {
                    controller.setSailon(value);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
