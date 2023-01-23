import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:frontend/app/core/constants/app_arguments.dart';
import 'package:frontend/app/core/constants/app_routes.dart';
import 'package:frontend/app/core/constants/app_sizes.dart';
import 'package:frontend/app/core/utils/custom_dialog.dart';
import 'package:frontend/app/core/utils/no_data.dart';
import 'package:frontend/presentation/main/controllers/client_controller.dart';
import 'package:frontend/presentation/main/view/widgets/client/client_form.dart';
import 'package:frontend/presentation/main/view/widgets/client/client_taile.dart';
import 'package:get/get.dart';

class ClientBody extends StatelessWidget {
  const ClientBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GetBuilder<ClientController>(
        builder: (controller) {
          return Conditional.single(
            context: context,
            conditionBuilder: (context) => controller.clients.isEmpty,
            widgetBuilder: (context) => const NoData(),
            fallbackBuilder: (context) => ListView.separated(
              controller: ScrollController(initialScrollOffset: 0),
              shrinkWrap: true,
              itemCount: controller.clients.length,
              itemBuilder: (context, index) => ClientTile(
                client: controller.clients[index],
                onArchive: () {
                  if (index < controller.clients.length) {
                    controller.clientArchive(controller.clients[index]!);
                  }
                },
                onEdit: () {
                  controller.modelToController(controller.clients[index]);
                  CustomDialog().set(
                    context: context,
                    title: 'تعديل بيانات العميل',
                    confirm: () {
                      if (controller.formKey.currentState!.validate()) {
                        controller.clientUpdate(controller.clients[index]);
                      }
                    },
                    body: const ClientForm(),
                  );
                },
                onTap: () {
                  Get.toNamed(AppRoutes.client, arguments: {
                    AppArguments.clientId: controller.clients[index].id
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
