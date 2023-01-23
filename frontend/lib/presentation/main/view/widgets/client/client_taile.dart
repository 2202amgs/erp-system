import 'package:flutter/material.dart';
import 'package:frontend/app/core/utils/archive_button.dart';
import 'package:frontend/data/models/client_model.dart';

class ClientTile extends StatelessWidget {
  final GestureTapCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onArchive;
  const ClientTile({
    Key? key,
    required this.client,
    this.onTap,
    this.onEdit,
    this.onArchive,
  }) : super(key: key);

  final ClientModel client;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      tileColor: Theme.of(context).canvasColor,
      hoverColor: Theme.of(context).primaryColor,
      isThreeLine: true,
      title: Text(
        client.clientName!,
        style: Theme.of(context).textTheme.headline2,
      ),
      subtitle: Text(
        client.ponName!,
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
          ArchiveButton(onArchive: onArchive, isArchive: client.archive!)
        ],
      ),
    );
  }
}
