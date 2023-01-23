import 'package:flutter/material.dart';
import 'package:frontend/app/core/constants/app_sizes.dart';
import 'package:frontend/app/core/utils/head_item.dart';
import 'package:frontend/presentation/single/controllers/single_typegoods_controller.dart';
import 'package:get/get.dart';

class SingleTypeGoodsHeadContainer extends StatelessWidget {
  SingleTypeGoodsHeadContainer({
    Key? key,
  }) : super(key: key);

  final SingleTypeGoodsController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSize.s2),
      color: Theme.of(context).canvasColor,
      width: double.infinity,
      child: Wrap(
        textDirection: TextDirection.rtl,
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.end,
        runAlignment: WrapAlignment.spaceBetween,
        children: [
          HeadIem(
            title: 'اسم الصنف',
            value: controller.singleTypeGoodsModel!.typeGoods!.name!,
          ),
          HeadIem(
            title: 'الكمية',
            value: controller.singleTypeGoodsModel!.quantity.toString(),
          ),
        ],
      ),
    );
  }
}
