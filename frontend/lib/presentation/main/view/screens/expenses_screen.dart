import 'package:flutter/material.dart';
import 'package:frontend/app/core/constants/app_sizes.dart';
import 'package:frontend/app/core/utils/responsive.dart';
import 'package:frontend/presentation/main/controllers/expenses_controller.dart';
import 'package:frontend/presentation/main/view/widgets/dashboard/header.dart';
import 'package:frontend/presentation/main/view/widgets/expenses/expenses_body.dart';
import 'package:frontend/presentation/main/view/widgets/expenses/expenses_toolbar.dart';
import 'package:get/get.dart';

class ExpensesScreen extends GetView<ExpensesController> {
  const ExpensesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(AppSize.s2),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: Responsive.isMobile(context)
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
          children: [
            const Header(
              title: 'المصروفات',
              toolBar: ExpensesToolBar(),
            ),
            SizedBox(height: AppSize.s5),
            const ExpensesBody(),
          ],
        ),
      ),
    );
  }
}
