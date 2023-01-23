import 'package:flutter/cupertino.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:frontend/app/core/constants/app_arguments.dart';
import 'package:frontend/app/core/constants/app_routes.dart';
import 'package:frontend/app/core/constants/app_sizes.dart';
import 'package:frontend/app/core/utils/custom_dialog.dart';
import 'package:frontend/app/core/utils/no_data.dart';
import 'package:frontend/presentation/main/controllers/expenses_controller.dart';
import 'package:frontend/presentation/main/view/widgets/expenses/expenses_form.dart';
import 'package:frontend/presentation/main/view/widgets/expenses/expenses_taile.dart';
import 'package:get/get.dart';

class ExpensesBody extends StatelessWidget {
  const ExpensesBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GetBuilder<ExpensesController>(
        builder: (controller) {
          return Conditional.single(
            context: context,
            conditionBuilder: (context) => controller.expenses.isEmpty,
            widgetBuilder: (context) => const NoData(),
            fallbackBuilder: (context) => ListView.separated(
              controller: ScrollController(initialScrollOffset: 0),
              shrinkWrap: true,
              itemCount: controller.expenses.length,
              itemBuilder: (context, index) => ExpensesTaile(
                expenses: controller.expenses[index],
                onArchive: () {
                  if (index < controller.expenses.length) {
                    controller.expensesArchive(controller.expenses[index]);
                  }
                },
                onEdit: () {
                  controller.modelToController(controller.expenses[index]);
                  CustomDialog().set(
                    context: context,
                    title: 'تعديل بيانات السيارة',
                    confirm: () {
                      if (controller.formKey.currentState!.validate()) {
                        controller.expensesUpdate(controller.expenses[index]);
                      }
                    },
                    body: const ExpensesForm(),
                  );
                },
                onTap: () => Get.toNamed(
                  AppRoutes.expenses,
                  arguments: {
                    AppArguments.expensesId: controller.expenses[index].id,
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
