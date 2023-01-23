import 'package:flutter/material.dart';
import 'package:frontend/app/core/constants/app_sizes.dart';
import 'package:frontend/app/core/constants/object_types.dart';
import 'package:frontend/app/core/shared/dropdown_lists.dart';
import 'package:frontend/app/core/utils/custom_form_field.dart';
import 'package:frontend/presentation/main/controllers/bank_controller.dart';
import 'package:frontend/presentation/main/controllers/car_controller.dart';
import 'package:frontend/presentation/main/controllers/client_controller.dart';
import 'package:frontend/presentation/main/controllers/expenses_controller.dart';
import 'package:frontend/presentation/main/controllers/safe_controller.dart';
import 'package:frontend/presentation/main/controllers/supplier_controller.dart';
import 'package:frontend/presentation/main/controllers/transfer_controller.dart';
import 'package:frontend/presentation/main/controllers/user_controller.dart';
import 'package:get/get.dart';

class TransferForm extends GetView<TransferController> {
  TransferForm({super.key});
  final BankController _bankController = Get.find();
  final SafeController _safeController = Get.find();
  final CarController _carController = Get.find();
  final ClientController _clientController = Get.find();
  final SupplierController _supplierController = Get.find();
  final UserController _userController = Get.find();
  final ExpensesController _expensesController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Container(
        width: 400,
        padding: EdgeInsets.all(AppSize.s2),
        color: Theme.of(context).scaffoldBackgroundColor,
        child: GetBuilder<TransferController>(builder: (controller) {
          return Wrap(
            runSpacing: AppSize.s2,
            children: [
              DropdownButtonFormField(
                items: ObjectTypes.list
                    .map((e) => DropdownMenuItem(
                          value: e.value,
                          child: Text(e.child),
                        ))
                    .toList(),
                onChanged: (value) {
                  controller.setSenderType(value!);
                },
                hint: const Text(
                  'نوع المرسل',
                ),
                value: controller.senderType,
                validator: (value) {
                  if (value == null) {
                    return 'أختر نوع المرسل';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField(
                items: _dropdownMenuItem(
                    controller.senderType, controller.senderId),
                onChanged: (value) {
                  controller.setSenderId(value!);
                },
                hint: const Text('المرسل'),
                value: controller.senderId,
                validator: (value) {
                  if (value == null) {
                    return 'أختر المرسل';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField(
                items: ObjectTypes.list
                    .map((e) => DropdownMenuItem(
                          value: e.value,
                          child: Text(e.child),
                        ))
                    .toList(),
                onChanged: (value) {
                  controller.setReceiverType(value!);
                },
                hint: const Text('نوع المرسل إليه'),
                value: controller.receiverType,
                validator: (value) {
                  if (value == null) {
                    return 'أختر نوع المرسل إليه';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField(
                items: _dropdownMenuItem(
                    controller.receiverType, controller.receiverId),
                hint: const Text('المرسل االيه'),
                onChanged: (value) {
                  controller.setReceiverId(value!);
                },
                value: controller.receiverId,
                validator: (value) {
                  if (value == null) {
                    return 'أختر المرسل إليه';
                  } else if (value == controller.senderId) {
                    return "لا يمكن الإرسال الإستقبال من نفس الكيان";
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

  List<DropdownMenuItem> _dropdownMenuItem(String? type, String? id) {
    switch (type) {
      case ObjectTypes.car:
        return carList(_carController, id);
      case ObjectTypes.loco:
        return locoList(_carController, id);
      case ObjectTypes.client:
        return clientAndSupplierList(
            _clientController, _supplierController, id);
      case ObjectTypes.emp:
        return userList(_userController, id);
      case ObjectTypes.expenses:
        return expensesList(_expensesController, id);
      default:
        return safeAndBankList(_bankController, _safeController, id);
    }
  }
}
