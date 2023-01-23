// ignore_for_file: depend_on_referenced_packages
import 'package:frontend/app/core/constants/app_sizes.dart';
import 'package:frontend/presentation/printing/views/widgets/printing_head_item.dart';
import 'package:frontend/presentation/printing/views/widgets/printing_image.dart';
import 'package:frontend/presentation/printing/views/widgets/printing_table.dart';
import 'package:frontend/presentation/printing/views/widgets/printing_top_header.dart';
import 'package:frontend/presentation/single/controllers/single_emp_controller.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:pdf/widgets.dart';

Future<Widget> empPdf() async {
  SingleEmpController controller = Get.find();
  final image = await printingImage();
  return SizedBox(
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            printingHeadItem(
              'الرصيد',
              controller.singleEmpModel!.account.toString(),
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
            printingHeadItem(
              'اسم الموظف',
              controller.singleEmpModel!.user!.name!,
            ),
            image
          ],
        ),
        SizedBox(height: AppSize.s1),
        printingTopHeader('المستحقان'),
        printingTable(
          columns: controller.columns.reversed
              .map((e) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppSize.s1),
                    child: Text(e),
                  ))
              .toList(),
          rows: [
            ...List.generate(
              controller.singleEmpModel!.empMoney!.length,
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
        printingTopHeader('الدفعات'),
        printingTable(
          columns: controller.comlumnOfTransfer.reversed
              .map((e) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppSize.s1),
                    child: Text(e),
                  ))
              .toList(),
          rows: [
            ...List.generate(
              controller.singleEmpModel!.transfers!.length,
              (index) => TableRow(
                children: controller
                    .cellsOfTransfer(index)
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
