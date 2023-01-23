// ignore_for_file: depend_on_referenced_packages
import 'package:frontend/app/core/constants/app_sizes.dart';
import 'package:frontend/presentation/printing/views/widgets/printing_head_item.dart';
import 'package:frontend/presentation/printing/views/widgets/printing_image.dart';
import 'package:frontend/presentation/printing/views/widgets/printing_table.dart';
import 'package:frontend/presentation/single/controllers/single_client_controller.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:pdf/widgets.dart';

Future<Widget> clientPdf() async {
  SingleClientController controller = Get.find();
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
                    'مـن', Jiffy(controller.dateTimeRange.start).yMMMMEEEEd),
                printingHeadItem(
                    'إلى', Jiffy(controller.dateTimeRange.end).yMMMMEEEEd),
              ],
            ),
            image
          ],
        ),
        SizedBox(height: AppSize.s1),
        printingTable(
          columns: controller.column.reversed
              .map((e) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppSize.s1),
                    child: Text(e),
                  ))
              .toList(),
          rows: [],
        ),
      ],
    ),
  );
}

// rows() {
//   SingleClientController controller = Get.find();
//   List rows = [
//     ...controller.singleClientModel!.shipments!,
//     ...controller.singleClientModel!.buyGoods!,
//     ...controller.singleClientModel!.transfers!,
//   ]..sort((a, b) => DateTime.parse(a.date!).compareTo(DateTime.parse(b.date!)));
// }
