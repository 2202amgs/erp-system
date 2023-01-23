import 'package:flutter/material.dart';
import 'package:frontend/app/core/constants/app_colors.dart';
import 'package:frontend/app/core/constants/app_sizes.dart';
import 'package:get/get.dart';

class NoData extends StatelessWidget {
  const NoData({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            iconSize: AppSize.s16,
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.cloud_off,
              // size: AppSize.s16,
              color: AppColors.headText,
            ),
          ),
          Text(
            'لاتوجد بيانات',
            style: Theme.of(context).textTheme.headline1,
          ),
        ],
      ),
    );
  }
}
