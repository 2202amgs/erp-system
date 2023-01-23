// ignore_for_file: depend_on_referenced_packages
import 'package:pdf/widgets.dart';
import 'package:pdf/pdf.dart';

Widget printingHeadItem(String title, String text) {
  return Row(
    children: [
      Text(text),
      Text(
        "$title: ",
        style: TextStyle(color: PdfColor.fromHex('#ff0000')),
      ),
    ],
  );
}
