import 'package:flutter/material.dart';
import 'package:frontend/app/core/utils/archive_button.dart';
import 'package:frontend/data/models/safe_model.dart';

class SafeTaile extends StatelessWidget {
  final GestureTapCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onArchive;
  const SafeTaile({
    Key? key,
    required this.safe,
    this.onTap,
    this.onEdit,
    this.onArchive,
  }) : super(key: key);

  final SafeModel safe;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      tileColor: Theme.of(context).canvasColor,
      hoverColor: Theme.of(context).primaryColor,
      isThreeLine: true,
      title: Text(
        safe.name!,
        style: Theme.of(context).textTheme.headline2,
      ),
      subtitle: Text(
        safe.account!.toString(),
        style: Theme.of(context).textTheme.subtitle1,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: onEdit,
            icon: const Icon(Icons.edit_note),
            color: Colors.amber,
          ),
          ArchiveButton(onArchive: onArchive, isArchive: safe.archive!),
        ],
      ),
    );
  }
}
