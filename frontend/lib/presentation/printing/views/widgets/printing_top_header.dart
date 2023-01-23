// ignore_for_file: depend_on_referenced_packages
import 'package:pdf/widgets.dart';

Widget printingTopHeader(String text) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(border: Border.all()),
    child: Text(text),
  );
}
