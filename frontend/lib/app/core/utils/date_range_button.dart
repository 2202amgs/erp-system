import 'package:flutter/material.dart';

class DateRangeButton extends StatelessWidget {
  const DateRangeButton({Key? key, this.onPressed}) : super(key: key);
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'تحديد المدة',
      child: IconButton(
        onPressed: onPressed,
        icon: const Icon(
          Icons.date_range_rounded,
        ),
      ),
    );
  }
}
