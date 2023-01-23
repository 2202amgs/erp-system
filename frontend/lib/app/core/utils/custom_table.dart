import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:frontend/app/core/constants/app_sizes.dart';

class CustomDataTable extends StatelessWidget {
  const CustomDataTable({Key? key, required this.columns, required this.rows})
      : super(key: key);
  final List<DataColumn> columns;
  final List<DataRow> rows;
  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
        },
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columnSpacing: 20,
          // border: TableBorder.all(color: Colors.white, width: .1),
          showCheckboxColumn: false,
          headingRowColor:
              MaterialStatePropertyAll(Theme.of(context).hintColor),
          dataTextStyle: Theme.of(context).textTheme.subtitle1,
          headingTextStyle: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(fontSize: AppSize.s3),
          showBottomBorder: true,
          columns: columns,
          rows: rows,
        ),
      ),
    );
  }
}
