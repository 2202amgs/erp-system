import 'package:flutter/material.dart';

class PrintingButton extends StatelessWidget {
  const PrintingButton({Key? key, this.onPressed}) : super(key: key);
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'طباعة',
      child: IconButton(
        onPressed: onPressed,
        icon: const Icon(
          Icons.print,
        ),
      ),
    );
  }
}
