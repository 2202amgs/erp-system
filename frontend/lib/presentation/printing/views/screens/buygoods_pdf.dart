// ignore_for_file: depend_on_referenced_packages
import 'package:frontend/app/core/constants/app_sizes.dart';
import 'package:frontend/presentation/printing/views/widgets/printing_head_item.dart';
import 'package:frontend/presentation/printing/views/widgets/printing_image.dart';
import 'package:frontend/presentation/printing/views/widgets/printing_table.dart';
import 'package:frontend/presentation/printing/views/widgets/printing_top_header.dart';
import 'package:frontend/presentation/single/controllers/single_typegoods_controller.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:pdf/widgets.dart';

Future<Widget> buyGoodsPdf() async {
  SingleTypeGoodsController controller = Get.find();
  final image = await printingImage();
  return SizedBox(
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                printingHeadItem(
                  'اسم الصنف',
                  controller.singleTypeGoodsModel!.typeGoods!.name.toString(),
                ),
                printingHeadItem(
                  'الكمية',
                  controller.singleTypeGoodsModel!.quantity.toString(),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                printingHeadItem(
                  'مـن',
                  Jiffy(controller.dateTimeRange.start).yMMMMEEEEd,
                ),
                printingHeadItem(
                  'إلى',
                  Jiffy(controller.dateTimeRange.end).yMMMMEEEEd,
                ),
              ],
            ),
            image
          ],
        ),
        SizedBox(height: AppSize.s1),
        printingTopHeader('مشتريات'),
        printingTable(
          columns: controller.columns.reversed
              .map((e) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppSize.s1),
                    child: Text(e),
                  ))
              .toList(),
          rows: [
            ...List.generate(
              controller.singleTypeGoodsModel!.buyGoods!.length,
              (index) => TableRow(
                children: controller
                    .cells(index)
                    .reversed
                    .map((e) => Text(e.toString()))
                    .toList(),
              ),
            ),
          ],
        ),
        SizedBox(height: AppSize.s2),
        printingTopHeader('مبيعات'),
        printingTable(
          columns: controller.columnsOfShipments.reversed
              .map((e) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppSize.s1),
                    child: Text(e),
                  ))
              .toList(),
          rows: [
            ...List.generate(
              controller.singleTypeGoodsModel!.shipments!.length,
              (index) => TableRow(
                children: controller
                    .cellsOfShipment(index)
                    .reversed
                    .map((e) => Text(e.toString()))
                    .toList(),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
