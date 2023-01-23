import 'package:flutter/material.dart';
import 'package:frontend/presentation/single/controllers/single_car_controller.dart';
import 'package:get/get.dart';

class TotalSection extends StatelessWidget {
  TotalSection({
    Key? key,
  }) : super(key: key);
  final SingleCarController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: Table(
        border: TableBorder.all(
          color: Theme.of(context).highlightColor,
        ),
        children: controller
            .getTotalList()
            .map((e) => _row(context, e['title'], e['value'].toString()))
            .toList(),
      ),
    );
  }

  TableRow _row(context, String title, String value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            value,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
      ],
    );
  }
}
