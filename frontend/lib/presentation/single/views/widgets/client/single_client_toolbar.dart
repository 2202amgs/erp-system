import 'package:flutter/material.dart';
import 'package:frontend/app/core/constants/object_types.dart';
import 'package:frontend/app/core/utils/custom_toolbar.dart';
import 'package:frontend/app/core/utils/date_range_button.dart';
import 'package:frontend/app/core/utils/date_range_title.dart';
import 'package:frontend/app/core/utils/exit_button.dart';
import 'package:frontend/app/core/utils/printing_button.dart';
import 'package:frontend/presentation/main/view/widgets/transfer/transfer_add_button.dart';
import 'package:frontend/presentation/printing/views/screens/client_pdf.dart';
import 'package:frontend/presentation/printing/views/screens/printing_screen.dart';
import 'package:frontend/presentation/single/controllers/single_client_controller.dart';
import 'package:get/get.dart';

class SingleClientToolBar extends StatelessWidget {
  SingleClientToolBar({
    Key? key,
  }) : super(key: key);
  final SingleClientController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    bool client = controller.singleClientModel!.client!.isClient!;
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
                ).then((value) {
                  if (value != null) {
                    controller.dateTimeRange = value;
                  }
                  controller.getSingleClient();
                }).ignore();
              },
            ),
            TransferAddBotton(
              senderId: client ? controller.clientId : null,
              senderType: client ? ObjectTypes.client : null,
              receiverId: client ? null : controller.clientId,
              receiverType: client ? null : ObjectTypes.client,
              onFinish: () {
                controller.getSingleClient();
              },
            ),
            PrintingButton(
              onPressed: () {
                Get.to(
                  PrintingScreen(
                    controller.singleClientModel!.client!.clientName!,
                    page: clientPdf(),
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
