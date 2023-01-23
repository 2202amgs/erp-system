// ignore_for_file: depend_on_referenced_packages
import 'package:frontend/app/core/constants/app_sizes.dart';
import 'package:frontend/presentation/main/controllers/shipments_controller.dart';
import 'package:frontend/presentation/printing/views/widgets/printing_head_item.dart';
import 'package:frontend/presentation/printing/views/widgets/printing_image.dart';
import 'package:frontend/presentation/printing/views/widgets/printing_table.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:pdf/widgets.dart';

Future<Widget> dailyPdf() async {
  ShipmentsController controller = Get.find();
  final image = await printingImage();
  return SizedBox(
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                printingHeadItem(
                    'اليوم', Jiffy(controller.dateTime).yMMMMEEEEd.toString()),
              ],
            ),
            image
          ],
        ),
        SizedBox(height: AppSize.s1),
        printingTable(
          columns: controller
              .column()
              .reversed
              .map((e) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppSize.s1),
                    child: Text(e),
                  ))
              .toList(),
          rows: [
            ...List.generate(
              controller.shipments.length,
              (index) => TableRow(
                children: controller
                    .cells(index)
                    .reversed
                    .map((e) => Text(e))
                    .toList(),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
