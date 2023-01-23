import 'package:flutter/material.dart';
import 'package:frontend/app/core/constants/object_types.dart';
import 'package:frontend/app/core/utils/custom_toolbar.dart';
import 'package:frontend/app/core/utils/date_range_button.dart';
import 'package:frontend/app/core/utils/date_range_title.dart';
import 'package:frontend/app/core/utils/exit_button.dart';
import 'package:frontend/app/core/utils/printing_button.dart';
import 'package:frontend/presentation/main/view/widgets/transfer/transfer_add_button.dart';
import 'package:frontend/presentation/printing/views/screens/car_pdf.dart';
import 'package:frontend/presentation/printing/views/screens/printing_screen.dart';
import 'package:frontend/presentation/single/controllers/single_car_controller.dart';
import 'package:get/get.dart';

class SingleCarToolBar extends StatelessWidget {
  SingleCarToolBar({Key? key}) : super(key: key);
  final SingleCarController controller = Get.put(SingleCarController());

  @override
  Widget build(BuildContext context) {
    return CustomToolBar(
      children: [
        const ExitButton(),
        DateRangeTitle(timeRange: controller.dateTimeRange),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            DateRangeButton(
              onPressed: () async {
                showDateRangePicker(
                  context: context,
                  initialEntryMode: DatePickerEntryMode.input,
                  firstDate: DateTime(2022),
                  lastDate: DateTime.now(),
                  initialDateRange: controller.dateTimeRange,
                ).then((value) async {
                  if (value != null) {
                    controller.dateTimeRange = value;
                  }
                  await controller.getSingleCar();
                }).ignore();
              },
            ),
            TransferAddBotton(
              senderType: ObjectTypes.bank,
              receiverType: ObjectTypes.car,
              receiverId: controller.carId,
            ),
            PrintingButton(
              onPressed: () {
                Get.to(
                  PrintingScreen(
                    'client',
                    page: carPdf(),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
