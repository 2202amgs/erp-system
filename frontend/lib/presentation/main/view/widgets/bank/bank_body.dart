import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:frontend/app/core/constants/app_arguments.dart';
import 'package:frontend/app/core/constants/app_routes.dart';
import 'package:frontend/app/core/constants/app_sizes.dart';
import 'package:frontend/app/core/utils/custom_dialog.dart';
import 'package:frontend/app/core/utils/no_data.dart';
import 'package:frontend/presentation/main/controllers/bank_controller.dart';
import 'package:frontend/presentation/main/view/widgets/bank/bank_form.dart';
import 'package:frontend/presentation/main/view/widgets/bank/bank_taile.dart';
import 'package:get/get.dart';

class BankBody extends StatelessWidget {
  const BankBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GetBuilder<BankController>(
        builder: (controller) {
          return Conditional.single(
            context: context,
            conditionBuilder: (context) => controller.banks.isEmpty,
            widgetBuilder: (context) => const NoData(),
            fallbackBuilder: (context) => ListView.separated(
              controller: ScrollController(initialScrollOffset: 0),
              shrinkWrap: true,
              itemCount: controller.banks.length,
              itemBuilder: (context, index) => BankTaile(
                bank: controller.banks[index],
                onArchive: () {
                  if (index < controller.banks.length) {
                    controller.bankArchive(controller.banks[index]);
                  }
                },
                onEdit: () {
                  controller.modelToController(controller.banks[index]);
                  CustomDialog().set(
                    context: context,
                    title: 'تعديل بيانات البنك',
                    confirm: () {
                      if (controller.formKey.currentState!.validate()) {
                        controller.bankUpdate(controller.banks[index]);
                      }
                    },
                    body: const BankForm(),
                  );
                },
                onTap: () => Get.toNamed(
                  AppRoutes.bank,
                  arguments: {
                    AppArguments.bankId: controller.banks[index].id,
                  },
                ),
              ),
              separatorBuilder: (context, index) =>
                  SizedBox(height: AppSize.s2),
            ),
          );
        },
      ),
    );
  }
}
