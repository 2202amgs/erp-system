import 'package:flutter/material.dart';
import 'package:frontend/presentation/main/controllers/buygoods_controller.dart';
import 'package:frontend/app/core/utils/custom_dialog.dart';
import 'package:frontend/presentation/main/view/widgets/buygoods/buygoods_form.dart';
import 'package:get/get.dart';

class BuyGoodsAddBotton extends GetView<BuyGoodsController> {
  const BuyGoodsAddBotton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'شراء كمية',
      child: IconButton(
        onPressed: () {
          controller.clearControllers();
          CustomDialog().set(
            context: context,
            title: 'شراء كمية جديدة',
            confirm: () async {
              if (controller.formKey.currentState!.validate()) {
                await controller.createBuyGoods(DateTime.now());
              }
            },
            body: BuyGoodsForm(),
          );
        },
        icon: const Icon(Icons.attach_money_outlined),
      ),
    );
  }
}
