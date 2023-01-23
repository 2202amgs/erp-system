import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExitButton extends StatelessWidget {
  const ExitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'خروج',
      child: IconButton(
        onPressed: () => Get.back(),
        icon: const Icon(Icons.cancel_sharp),
      ),
    );
  }
}
