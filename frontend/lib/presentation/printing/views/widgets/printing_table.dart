// ignore_for_file: depend_on_referenced_packages
import 'package:frontend/app/core/constants/app_colors.dart';
import 'package:pdf/widgets.dart';

Widget printingTable({
  required List<Widget> columns,
  required List<TableRow> rows,
  TableWidth width = TableWidth.max,
}) {
  return Table(
    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
    border: TableBorder.all(),
    tableWidth: width,
    children: [
      TableRow(
        decoration: BoxDecoration(
          color: AppColors.printing,
        ),
        children: columns,
      ),
      ...rows
    ],
  );
}
