import 'dart:io';
import 'package:flutter/material.dart';
import 'package:frontend/app.dart';
import 'package:frontend/app/core/services/app_services.dart';
import 'package:jiffy/jiffy.dart';
import 'package:window_size/window_size.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('شركة عمار');
    // setWindowMaxSize(const Size(max_width, max_height));
    // setWindowMinSize(const Size(1280, 720));
  }
  await Jiffy.locale("ar");
  servicesInject();
  runApp(const App());
}
