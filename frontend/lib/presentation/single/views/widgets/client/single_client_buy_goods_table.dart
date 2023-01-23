import 'package:flutter/material.dart';
import 'package:frontend/presentation/main/controllers/buygoods_controller.dart';
import 'package:frontend/app/core/utils/custom_dialog.dart';
import 'package:frontend/app/core/utils/custom_table.dart';
import 'package:frontend/app/core/utils/no_data.dart';
import 'package:frontend/presentation/main/view/widgets/buygoods/buygoods_form.dart';
import 'package:frontend/presentation/single/controllers/single_client_controller.dart';
import 'package:get/get.dart';

class SingleClientBuyGoodsTable extends StatelessWidget {
  SingleClientBuyGoodsTable({Key? key}) : super(key: key);
  final SingleClientController controller = Get.find();
  final BuyGoodsController _buyGoodsController = Get.find();

  @override
  Widget build(BuildContext context) {
    if (controller.singleClientModel!.buyGoods!.isEmpty) {
      return const NoData();
    }
    return SingleChildScrollView(
      child: Center(
        child: CustomDataTable(
          columns: controller.buyGoodsColumn(),
          rows: _listOfBuyGoods(context),
        ),
      ),
    );
  }

  // Generate List Of Buy Goods
  List<DataRow> _listOfBuyGoods(BuildContext context) {
    return [
      ...List.generate(
        controller.singleClientModel!.buyGoods!.length,
        (index) => DataRow(
          cells: controller
              .buyGoodsCells(
                  controller.singleClientModel!.buyGoods![index], index)
              .map((s) => DataCell(
                    Text(s),
                  ))
              .toList(),
          onLongPress: () => _onDelete(context, index),
          onSelectChanged: (value) => _onEdit(context, index),
        ),
      ),
    ];
  }

  // Delete Form Show
  void _onDelete(BuildContext context, int index) {
    CustomDialog().remove(
      context: context,
      title: "حذف الدفعة",
      confirm: () async {
        await _buyGoodsController
            .deleteBuyGoods(controller.singleClientModel!.buyGoods![index].id!);
        controller.getSingleClient();
      },
    );
  }

  // Edit Form Show
  void _onEdit(BuildContext context, int index) {
    _buyGoodsController
        .modelToController(controller.singleClientModel!.buyGoods![index]);
    CustomDialog().set(
      context: context,
      title: 'تعديل الدفعة',
      confirm: () async {
        await _buyGoodsController
            .buyGoodsUpdate(controller.singleClientModel!.buyGoods![index]);
        controller.getSingleClient();
      },
      body: BuyGoodsForm(),
    );
  }
}
