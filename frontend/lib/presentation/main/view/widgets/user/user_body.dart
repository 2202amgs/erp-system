import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:frontend/app/core/constants/app_arguments.dart';
import 'package:frontend/app/core/constants/app_routes.dart';
import 'package:frontend/app/core/constants/app_sizes.dart';
import 'package:frontend/app/core/utils/custom_dialog.dart';
import 'package:frontend/app/core/utils/no_data.dart';
import 'package:frontend/presentation/main/controllers/user_controller.dart';
import 'package:frontend/presentation/main/view/widgets/user/user_form.dart';
import 'package:frontend/presentation/main/view/widgets/user/user_taile.dart';
import 'package:get/get.dart';

class UserBody extends GetView<UserController> {
  const UserBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GetBuilder<UserController>(builder: (controller) {
        return Conditional.single(
          context: context,
          conditionBuilder: (context) => controller.users.isEmpty,
          widgetBuilder: (context) => const NoData(),
          fallbackBuilder: _userTailList,
        );
      }),
    );
  }

  Widget _userTailList(BuildContext context) {
    return ListView.separated(
      controller: ScrollController(initialScrollOffset: 0),
      shrinkWrap: true,
      itemCount: controller.users.length,
      itemBuilder: (context, index) => UserTaile(
        user: controller.users[index],
        onArchive: () {
          if (index < controller.users.length) {
            controller.userArchive(controller.users[index]);
          }
        },
        onEdit: () {
          controller.modelToController(controller.users[index]);
          CustomDialog().set(
            context: context,
            title: 'تعديل بيانات الموظف',
            confirm: () {
              if (controller.formKey.currentState!.validate()) {
                controller.userUpdate(controller.users[index]);
              }
            },
            body: const UserForm(),
          );
        },
        onTap: () {
          Get.toNamed(
            AppRoutes.user,
            arguments: {AppArguments.empId: controller.users[index].id},
          );
        },
      ),
      separatorBuilder: (context, index) => SizedBox(height: AppSize.s2),
    );
  }
}
