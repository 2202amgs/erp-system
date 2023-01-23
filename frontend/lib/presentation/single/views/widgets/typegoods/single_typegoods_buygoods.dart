import 'package:flutter/material.dart';
import 'package:frontend/presentation/main/controllers/buygoods_controller.dart';
import 'package:frontend/app/core/utils/custom_dialog.dart';
import 'package:frontend/app/core/utils/custom_table.dart';
import 'package:frontend/data/models/single_type_goods_model.dart';
import 'package:frontend/presentation/main/view/widgets/buygoods/buygoods_form.dart';
import 'package:frontend/presentation/single/controllers/single_typegoods_controller.dart';
import 'package:get/get.dart';

class SingleTypeGoodsBuyGoodsTable extends StatelessWidget {
  SingleTypeGoodsBuyGoodsTable({Key? key}) : super(key: key);
  final SingleTypeGoodsController controller = Get.find();
  final BuyGoodsController buyGoodsController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('مشتريات', style: Theme.of(context).textTheme.headline2),
        CustomDataTable(
          columns: _listOfColumn(),
          rows: _listOfBuyGoods(context),
        ),
      ],
    );
  }

  // Generate List Of BuyGoods
  List<DataRow> _listOfBuyGoods(BuildContext context) {
    SingleTypeGoodsModel scm = controller.singleTypeGoodsModel!;
    return [
      ...List.generate(
        scm.buyGoods!.length,
        (index) => DataRow(
          cells: _listofCells(index),
          onLongPress: () => _onDelete(context, index),
          onSelectChanged: (value) => _onEdit(context, index),
        ),
      ),
    ];
  }

  // Delete Form Show
  void _onDelete(BuildContext context, int index) {
    SingleTypeGoodsModel scm = controller.singleTypeGoodsModel!;
    CustomDialog().remove(
      context: context,
      title: "حذف الدفعة",
      confirm: () async {
        await buyGoodsController.deleteBuyGoods(scm.buyGoods![index].id!);
        controller.getSingleTypeGoods();
      },
    );
  }

  // Edit Form Show
  void _onEdit(BuildContext context, int index) {
    SingleTypeGoodsModel scm = controller.singleTypeGoodsModel!;
    buyGoodsController.modelToController(scm.buyGoods![index]);
    CustomDialog().set(
      context: context,
      title: 'تعديل الدفعة',
      confirm: () async {
        await buyGoodsController.buyGoodsUpdate(scm.buyGoods![index]);
        controller.getSingleTypeGoods();
      },
      body: BuyGoodsForm(),
    );
  }

  // column generated
  List<DataColumn> _listOfColumn() {
    return controller.columns.map((e) => DataColumn(label: Text(e))).toList();
  }

  // cells generated
  List<DataCell> _listofCells(int index) {
    return controller
        .cells(index)
        .map((s) => DataCell(Text(s.toString())))
        .toList();
  }
}
