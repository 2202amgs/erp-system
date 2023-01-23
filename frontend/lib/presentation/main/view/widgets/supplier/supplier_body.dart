import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:frontend/app/core/constants/app_arguments.dart';
import 'package:frontend/app/core/constants/app_routes.dart';
import 'package:frontend/app/core/constants/app_sizes.dart';
import 'package:frontend/app/core/utils/custom_dialog.dart';
import 'package:frontend/app/core/utils/no_data.dart';
import 'package:frontend/presentation/main/controllers/supplier_controller.dart';
import 'package:frontend/presentation/main/view/widgets/client/client_form.dart';
import 'package:frontend/presentation/main/view/widgets/client/client_taile.dart';
import 'package:get/get.dart';

class SupplierBody extends StatelessWidget {
  const SupplierBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GetBuilder<SupplierController>(
        builder: (controller) {
          return Conditional.single(
            context: context,
            conditionBuilder: (context) => controller.suppliers.isEmpty,
            widgetBuilder: (context) => const NoData(),
            fallbackBuilder: (context) => ListView.separated(
              controller: ScrollController(initialScrollOffset: 0),
              shrinkWrap: true,
              itemCount: controller.suppliers.length,
              itemBuilder: (context, index) => ClientTile(
                client: controller.suppliers[index],
                onArchive: () {
                  if (index < controller.suppliers.length) {
                    controller.supplierArchive(controller.suppliers[index]!);
                  }
                },
                onEdit: () {
                  controller.modelToController(controller.suppliers[index]);
                  CustomDialog().set(
                    context: context,
                    title: 'تعديل بيانات المورد',
                    confirm: () {
                      if (controller.formKey.currentState!.validate()) {
                        controller.supplierUpdate(controller.suppliers[index]);
                      }
                    },
                    body: const ClientForm(),
                  );
                },
                onTap: () {
                  Get.toNamed(AppRoutes.supplier, arguments: {
                    AppArguments.clientId: controller.suppliers[index].id
                  });
                },
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
