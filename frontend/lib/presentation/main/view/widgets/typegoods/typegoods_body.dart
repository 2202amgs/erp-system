import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:frontend/app/core/constants/app_arguments.dart';
import 'package:frontend/app/core/constants/app_routes.dart';
import 'package:frontend/app/core/constants/app_sizes.dart';
import 'package:frontend/app/core/utils/custom_dialog.dart';
import 'package:frontend/app/core/utils/no_data.dart';
import 'package:frontend/presentation/main/controllers/typegoods_contoller.dart';
import 'package:frontend/presentation/main/view/widgets/typegoods/typegoods_form.dart';
import 'package:frontend/presentation/main/view/widgets/typegoods/typegoods_taile.dart';
import 'package:get/get.dart';

class TypeGoodsBody extends StatelessWidget {
  const TypeGoodsBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GetBuilder<TypeGoodsController>(
        builder: (controller) {
          return Conditional.single(
            context: context,
            conditionBuilder: (context) => controller.typeGoods.isEmpty,
            widgetBuilder: (context) => const NoData(),
            fallbackBuilder: (context) => ListView.separated(
              controller: ScrollController(initialScrollOffset: 0),
              shrinkWrap: true,
              itemCount: controller.typeGoods.length,
              itemBuilder: (context, index) => TypeGoodsTaile(
                typeGoods: controller.typeGoods[index],
                onArchive: () {
                  if (index < controller.typeGoods.length) {
                    controller.typeGoodsArchive(controller.typeGoods[index]);
                  }
                },
                onEdit: () {
                  controller.modelToController(controller.typeGoods[index]);
                  CustomDialog().set(
                    context: context,
                    title: 'تعديل بيانات الصنف',
                    confirm: () {
                      if (controller.formKey.currentState!.validate()) {
                        controller.typeGoodsUpdate(controller.typeGoods[index]);
                      }
                    },
                    body: const TypeGoodsForm(),
                  );
                },
                onTap: () => Get.toNamed(
                  AppRoutes.typeGoods,
                  arguments: {
                    AppArguments.typeGoodsId: controller.typeGoods[index].id,
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
