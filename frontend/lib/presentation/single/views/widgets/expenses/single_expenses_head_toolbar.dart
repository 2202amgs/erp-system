import 'package:flutter/material.dart';
import 'package:frontend/app/core/constants/object_types.dart';
import 'package:frontend/app/core/utils/custom_toolbar.dart';
import 'package:frontend/app/core/utils/date_range_button.dart';
import 'package:frontend/app/core/utils/date_range_title.dart';
import 'package:frontend/app/core/utils/exit_button.dart';
import 'package:frontend/app/core/utils/printing_button.dart';
import 'package:frontend/presentation/main/view/widgets/transfer/transfer_add_button.dart';
import 'package:frontend/presentation/single/controllers/single_expenses_controller.dart';
import 'package:get/get.dart';

class SingleExpensesToolBar extends StatelessWidget {
  SingleExpensesToolBar({
    Key? key,
  }) : super(key: key);

  final SingleExpensesController controller = Get.find();
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
                  await controller.getSingleExpenses();
                }).ignore();
              },
            ),
            TransferAddBotton(
              senderType: ObjectTypes.bank,
              receiverId: controller.expensesId,
              receiverType: ObjectTypes.expenses,
              onFinish: () async {
                await controller.getSingleExpenses();
              },
            ),
            PrintingButton(
              onPressed: () {
                // Get.to(
                //   PrintingScreen(
                //     'client',
                //     page: exp(),
                //   ),
                // );
              },
            ),
          ],
        ),
      ],
    );
  }
}
