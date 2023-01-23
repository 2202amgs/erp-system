import 'package:flutter/material.dart';
import 'package:frontend/app/core/utils/custom_dialog.dart';
import 'package:frontend/presentation/main/controllers/transfer_controller.dart';
import 'package:frontend/presentation/main/view/widgets/transfer/transfer_form.dart';

import 'package:get/get.dart';

class TransferAddBotton extends GetView<TransferController> {
  const TransferAddBotton({
    Key? key,
    this.onFinish,
    this.senderId,
    this.senderType,
    this.receiverId,
    this.receiverType,
  }) : super(key: key);
  final void Function()? onFinish;
  final String? senderId;
  final String? senderType;
  final String? receiverId;
  final String? receiverType;
  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'تحويل نقدى',
      child: IconButton(
        onPressed: () {
          controller.clearControllers();
          _setData();
          CustomDialog().set(
            context: context,
            title: 'إضافة حوالة جديدة',
            confirm: () async {
              if (controller.formKey.currentState!.validate()) {
                await controller.createTransfer(DateTime.now());
                if (onFinish != null) onFinish!();
              }
            },
            body: TransferForm(),
          );
        },
        icon: const Icon(Icons.low_priority_sharp),
      ),
    );
  }

  void _setData() {
    controller.senderId = senderId;
    controller.senderType = senderType;
    controller.receiverId = receiverId;
    controller.receiverType = receiverType;
  }
}
