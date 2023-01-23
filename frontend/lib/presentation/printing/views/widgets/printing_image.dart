// ignore_for_file: depend_on_referenced_packages
import 'package:frontend/app/core/constants/app_assets.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

Future<Widget> printingImage() async {
  final image = await imageFromAssetBundle(AppAssets.ammarIcon);
  return Image(
    image,
    width: 60,
    height: 60,
  );
}
