import 'package:flutter/material.dart';
import 'package:frontend/app/core/constants/app_colors.dart';
import 'package:frontend/app/core/constants/app_sizes.dart';
import 'package:get/get.dart';

class CustomDialog {
  void remove({
    required BuildContext context,
    required String title,
    required void Function()? confirm,
  }) {
    Get.defaultDialog(
      contentPadding: EdgeInsets.all(AppSize.s2),
      backgroundColor: AppColors.background,
      middleText: 'إذا ضغطت على زر الموافقة ستفقد البيانات إلى الأبد؟',
      title: title,
      confirmTextColor: Colors.white,
      confirm: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          backgroundColor: Colors.red,
        ),
        onPressed: confirm,
        child: Text(
          'حذف',
          style: Theme.of(context)
              .textTheme
              .headline1!
              .copyWith(color: Colors.white),
        ),
      ),
    );
  }

  void set({
    required BuildContext context,
    required String title,
    required void Function()? confirm,
    required Widget body,
  }) {
    Get.defaultDialog(
      contentPadding: EdgeInsets.all(AppSize.s2),
      backgroundColor: AppColors.background,
      content: Expanded(
        child: SingleChildScrollView(child: body),
      ),
      confirm: ElevatedButton(
        autofocus: true,
        style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50)),
        onPressed: confirm,
        child: Text(
          'حفظ',
          style: Theme.of(context)
              .textTheme
              .headline1!
              .copyWith(color: Colors.white),
        ),
      ),
      title: title,
    );
  }

  void logOut({
    required BuildContext context,
    required String title,
    required void Function()? confirm,
  }) {
    Get.defaultDialog(
      contentPadding: EdgeInsets.all(AppSize.s2),
      backgroundColor: AppColors.background,
      content: const Text('هل تريد تسجيل الخروج؟'),
      confirm: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          backgroundColor: Colors.red,
        ),
        onPressed: confirm,
        child: Text(
          'خروج',
          style: Theme.of(context)
              .textTheme
              .headline1!
              .copyWith(color: Colors.white),
        ),
      ),
      title: title,
    );
  }
}
