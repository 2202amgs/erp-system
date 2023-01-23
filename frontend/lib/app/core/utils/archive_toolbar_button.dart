import 'package:flutter/material.dart';

class ArchiveToolBarButton extends StatelessWidget {
  const ArchiveToolBarButton({
    Key? key,
    required this.isArchive,
    this.onPressed,
  }) : super(key: key);
  final bool isArchive;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: isArchive ? 'الخروج للقائمة' : 'أذهب الى الأرشيف',
      child: IconButton(
        onPressed: onPressed,
        icon: isArchive
            ? const Icon(Icons.send_and_archive_sharp)
            : const Icon(Icons.archive),
      ),
    );
  }
}
