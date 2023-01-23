import 'package:flutter/material.dart';
import 'package:frontend/app/core/utils/archive_button.dart';
import 'package:frontend/data/models/typegoods_model.dart';

class TypeGoodsTaile extends StatelessWidget {
  final GestureTapCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onArchive;
  const TypeGoodsTaile({
    Key? key,
    required this.typeGoods,
    this.onTap,
    this.onEdit,
    this.onArchive,
  }) : super(key: key);

  final TypeGoodsModel typeGoods;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      tileColor: Theme.of(context).canvasColor,
      hoverColor: Theme.of(context).scaffoldBackgroundColor,
      isThreeLine: true,
      title: Text(
        typeGoods.name!,
        style: Theme.of(context).textTheme.headline2,
      ),
      subtitle: const Text(''),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: onEdit,
            icon: const Icon(Icons.edit_note),
            color: Colors.amber,
          ),
          ArchiveButton(onArchive: onArchive, isArchive: typeGoods.archive!),
        ],
      ),
    );
  }
}
