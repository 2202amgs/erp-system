import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:frontend/app/core/constants/app_arguments.dart';
import 'package:frontend/app/core/constants/app_routes.dart';
import 'package:frontend/app/core/constants/app_sizes.dart';
import 'package:frontend/app/core/utils/custom_dialog.dart';
import 'package:frontend/app/core/utils/no_data.dart';
import 'package:frontend/presentation/main/controllers/safe_controller.dart';
import 'package:frontend/presentation/main/view/widgets/safe/safe_form.dart';
import 'package:frontend/presentation/main/view/widgets/safe/safe_taile.dart';
import 'package:get/get.dart';

class SafeBody extends StatelessWidget {
  const SafeBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GetBuilder<SafeController>(
        builder: (controller) {
          return Conditional.single(
            context: context,
            conditionBuilder: (context) => controller.safes.isEmpty,
            widgetBuilder: (context) => const NoData(),
            fallbackBuilder: (context) => ListView.separated(
              controller: ScrollController(initialScrollOffset: 0),
              shrinkWrap: true,
              itemCount: controller.safes.length,
              itemBuilder: (context, index) => SafeTaile(
                safe: controller.safes[index],
                onArchive: () {
                  if (index < controller.safes.length) {
                    controller.safeArchive(controller.safes[index]);
                  }
                },
                onEdit: () {
                  controller.modelToController(controller.safes[index]);
                  CustomDialog().set(
                    context: context,
                    title: 'تعديل بيانات الخزنة',
                    confirm: () {
                      if (controller.formKey.currentState!.validate()) {
                        controller.safeUpdate(controller.safes[index]);
                      }
                    },
                    body: const SafeForm(),
                  );
                },
                onTap: () => Get.toNamed(
                  AppRoutes.bank,
                  arguments: {
                    AppArguments.bankId: controller.safes[index].id,
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
