import 'package:flutter/material.dart';
import 'package:frontend/presentation/main/controllers/buygoods_controller.dart';
import 'package:frontend/app/core/constants/app_sizes.dart';
import 'package:frontend/app/core/shared/dropdown_lists.dart';
import 'package:frontend/app/core/utils/custom_form_field.dart';
import 'package:frontend/presentation/main/controllers/car_controller.dart';
import 'package:frontend/presentation/main/controllers/client_controller.dart';
import 'package:frontend/presentation/main/controllers/supplier_controller.dart';
import 'package:frontend/presentation/main/controllers/typegoods_contoller.dart';
import 'package:get/get.dart';

class BuyGoodsForm extends GetView<BuyGoodsController> {
  BuyGoodsForm({super.key});
  final CarController _carController = Get.find();
  final SupplierController _supplierController = Get.find();
  final ClientController _clientController = Get.find();
  final TypeGoodsController _typeGoodsController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Container(
        width: 400,
        padding: EdgeInsets.all(AppSize.s2),
        color: Theme.of(context).scaffoldBackgroundColor,
        child: GetBuilder<BuyGoodsController>(builder: (controller) {
          return Wrap(
            runSpacing: AppSize.s2,
            children: [
              DropdownButtonFormField(
                hint: const Text("المورد"),
                items: clientAndSupplierList(_clientController,
                    _supplierController, controller.supplierId,
                    isClient: false),
                onChanged: (value) {
                  controller.setSupplierId(value);
                },
                value: controller.supplierId,
                validator: (value) {
                  if (value == null) {
                    return 'أختر المورد';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField(
                hint: const Text('السيارة'),
                items: carList(_carController, controller.carId),
                onChanged: (value) {
                  controller.setCarId(value);
                },
                value: controller.carId,
              ),
              DropdownButtonFormField(
                hint: const Text("الصنف"),
                items:
                    typeGoodList(_typeGoodsController, controller.typeGoodsId),
                onChanged: (value) {
                  controller.setTypeGoodId(value);
                },
                value: controller.typeGoodsId,
                validator: (value) {
                  if (value == null) {
                    return 'أختر نوع البضاعة';
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
                controller: controller.quantityController,
                label: 'الكمية',
                validator: (value) {
                  if (value.toString().isEmpty) {
                    return 'أملأ الحقل';
                  }
                  return null;
                },
                formatType: FormatTypes.float,
              ),
              CustomFormField(
                controller: controller.poneNameController,
                label: 'اسم البون',
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
              ),
            ],
          );
        }),
      ),
    );
  }
}
