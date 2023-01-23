import 'package:flutter/material.dart';

class ArchiveButton extends StatelessWidget {
  const ArchiveButton({
    Key? key,
    required this.onArchive,
    required this.isArchive,
  }) : super(key: key);

  final VoidCallback? onArchive;
  final bool isArchive;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: isArchive ? 'إستعادة' : 'أرشف',
      child: IconButton(
        onPressed: onArchive,
        icon: isArchive
            ? const Icon(Icons.repeat_rounded, color: Colors.green)
            : const Icon(Icons.archive),
        color: Colors.red,
      ),
    );
  }
}
