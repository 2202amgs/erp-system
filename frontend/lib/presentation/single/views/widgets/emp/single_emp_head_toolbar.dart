import 'package:flutter/material.dart';
import 'package:frontend/app/core/constants/object_types.dart';
import 'package:frontend/app/core/utils/custom_toolbar.dart';
import 'package:frontend/app/core/utils/date_range_button.dart';
import 'package:frontend/app/core/utils/date_range_title.dart';
import 'package:frontend/app/core/utils/exit_button.dart';
import 'package:frontend/app/core/utils/printing_button.dart';
import 'package:frontend/presentation/main/view/widgets/empmoney/empmoney_add_button.dart';
import 'package:frontend/presentation/main/view/widgets/transfer/transfer_add_button.dart';
import 'package:frontend/presentation/printing/views/screens/emp_pdf.dart';
import 'package:frontend/presentation/printing/views/screens/printing_screen.dart';
import 'package:frontend/presentation/single/controllers/single_emp_controller.dart';
import 'package:get/get.dart';

class SingleEmpToolBar extends StatelessWidget {
  SingleEmpToolBar({
    Key? key,
  }) : super(key: key);

  final SingleEmpController controller = Get.find();
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
                  await controller.getSingleEmp();
                }).ignore();
              },
            ),
            TransferAddBotton(
              senderType: ObjectTypes.bank,
              receiverId: controller.empId,
              receiverType: ObjectTypes.emp,
              onFinish: () async {
                await controller.getSingleEmp();
              },
            ),
            EmpMoneyAddBotton(
              onFinish: () async {
                await controller.getSingleEmp();
              },
            ),
            PrintingButton(
              onPressed: () {
                Get.to(
                  PrintingScreen(controller.singleEmpModel!.user!.name!,
                      page: empPdf()),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
