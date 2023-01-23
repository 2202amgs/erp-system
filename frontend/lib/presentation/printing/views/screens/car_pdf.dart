// ignore_for_file: depend_on_referenced_packages
import 'package:frontend/app/core/constants/app_colors.dart';
import 'package:frontend/app/core/constants/app_sizes.dart';
import 'package:frontend/app/core/types/car_table_type.dart';
import 'package:frontend/data/models/shipment_model.dart';
import 'package:frontend/presentation/printing/views/widgets/printing_head_item.dart';
import 'package:frontend/presentation/printing/views/widgets/printing_image.dart';
import 'package:frontend/presentation/printing/views/widgets/printing_table.dart';
import 'package:frontend/presentation/single/controllers/single_car_controller.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:pdf/widgets.dart';
import 'package:pdf/pdf.dart';

Future<Widget> carPdf() async {
  SingleCarController controller = Get.find();

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
              children: getAccountBar(),
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                printingHeadItem(
                  'اسم مالك السيارة',
                  controller.singleCarModel?.car?.ownerName ?? '',
                ),
                printingHeadItem(
                  'اسم سائق السيارة',
                  controller.singleCarModel?.car?.driverName ?? '',
                ),
              ],
            ),
            image
          ],
        ),
        SizedBox(height: AppSize.s1),
        printingTable(
          columns: controller.columns.reversed
              .map((e) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppSize.s1),
                    child: Text(e),
                  ))
              .toList(),
          rows: [
            ...List.generate(
              controller.singleCarModel!.shipments.length,
              (index) => TableRow(
                children: _carPdfCell(
                        index, controller.singleCarModel!.shipments[index])
                    .reversed
                    .map((e) => Text(e.toString()))
                    .toList(),
              ),
            ),
            footer(),
          ],
        ),
        SizedBox(height: AppSize.s2),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            totalBar(),
            listOfAdvances(),
          ],
        ),
      ],
    ),
  );
}

List<Widget> getAccountBar() {
  List list;
  SingleCarController controller = Get.find();
  switch (controller.tableType) {
    case CarTableType.forCar:
      list = [
        {
          "title": 'رصيد السيارة السابق',
          "value": controller.singleCarModel!.data!.oldTotalForCar,
        }
      ];
      break;
    case CarTableType.forLoco:
      list = [
        {
          "title": 'رصيد المقطورة السابق',
          "value": controller.singleCarModel!.data!.oldTotalForLoco,
        }
      ];
      break;
    case CarTableType.sailon:
      list = [
        {
          "title": 'رصيد السيارة السابق',
          "value": controller.singleCarModel!.data!.oldTotalForCar,
        },
        {
          "title": 'رصيد المقطورة السابق',
          "value": controller.singleCarModel!.data!.oldTotalForLoco,
        },
        {
          "title": 'إجمالى الرصيد السابق',
          "value": controller.singleCarModel!.data!.oldTotal,
        }
      ];
      break;
    default:
      list = [
        {
          "title": 'رصيد سابق',
          "value": controller.singleCarModel!.data!.oldTotal,
        }
      ];
  }
  return list
      .map((e) => printingHeadItem(e['title'], e['value'].toString()))
      .toList();
}

List _carPdfCell(int index, ShipmentModel s) {
  SingleCarController controller = Get.find();
  num nolon = s.nolon!;
  if (controller.tableType != CarTableType.forCar) {
    nolon = s.nolon! * s.carRatio! / 100;
  } else if (controller.tableType == CarTableType.forLoco) {
    nolon = s.nolon! * (100 - s.carRatio!) / 100;
  }
  return [
    (index + 1),
    s.date.toString().substring(0, 10),
    s.clientName,
    s.driverName,
    s.factory,
    s.side,
    s.poneName,
    s.quantity,
    nolon.toStringAsFixed(2),
    s.tip,
    s.t3t,
    s.total,
    if (controller.tableType != CarTableType.forLoco) s.custody,
    if (controller.tableType == CarTableType.noramal) s.differenceNolon,
    s.carPureTotal.toString(),
    if (controller.tableType == CarTableType.forCar ||
        controller.tableType == CarTableType.sailon)
      s.carTotal,
    if (controller.tableType == CarTableType.forLoco ||
        controller.tableType == CarTableType.sailon)
      s.locoTotal
  ];
}

// footer data row
TableRow footer() {
  SingleCarController controller = Get.find();
  return TableRow(
    decoration: const BoxDecoration(
      color: PdfColor(0.8, 0.8, 0.8, 0.8),
    ),
    children: [
      '----',
      'الإجــمــالــى',
      '----',
      '----',
      '----',
      '----',
      '----',
      '----',
      '----',
      '----',
      '----',
      controller.singleCarModel!.data!.total,
      if (controller.tableType != CarTableType.forLoco)
        controller.singleCarModel!.data!.totalCustody,
      if (controller.tableType == CarTableType.noramal)
        controller.singleCarModel!.data!.totalDifferenceNolon,
      controller.singleCarModel!.data!.totalNewShipment,
      if (controller.tableType == CarTableType.forCar ||
          controller.tableType == CarTableType.sailon)
        controller.singleCarModel!.data!.totalNewShipmentForCar,
      if (controller.tableType == CarTableType.forLoco ||
          controller.tableType == CarTableType.sailon)
        controller.singleCarModel!.data!.totalNewShipmentForLoco,
    ].reversed.map((e) => Text(e.toString())).toList(),
  );
}

// total bar section
Widget totalBar() {
  SingleCarController controller = Get.find();

  return Table(
    border: TableBorder.all(),
    tableWidth: TableWidth.min,
    children: controller
        .getTotalList()
        .map((e) => TableRow(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSize.s1),
                  child: Text(e['value'].toString()),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSize.s1),
                  child: Text(e['title']),
                ),
              ],
            ))
        .toList(),
  );
}

// generate list advance
Widget listOfAdvances() {
  SingleCarController controller = Get.find();
  return printingTable(
    columns: controller.columnsOfAdvance.reversed
        .map((e) => Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSize.s1),
              child: Text(e),
            ))
        .toList(),
    rows: [
      ...controller
          .getTransfers()
          .map(
            (transfer) => TableRow(
                children: [
              transfer.amount!.toString(),
              transfer.description!,
              transfer.date!.substring(0, 10),
            ]
                    .map((e) => Padding(
                          padding: EdgeInsets.symmetric(horizontal: AppSize.s1),
                          child: Text(e),
                        ))
                    .toList()),
          )
          .toList(),
      TableRow(
        decoration: BoxDecoration(color: AppColors.printing),
        children: [
          Text(controller.totalAdvance.toString()),
          Text('='),
          Text('الإجمالى'),
        ],
      ),
    ],
  );
}
