import 'package:flutter/material.dart';
import 'package:frontend/app/core/utils/archive_button.dart';
import 'package:frontend/data/models/bank_model.dart';

class BankTaile extends StatelessWidget {
  final GestureTapCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onArchive;
  const BankTaile({
    Key? key,
    required this.bank,
    this.onTap,
    this.onEdit,
    this.onArchive,
  }) : super(key: key);

  final BankModel bank;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      tileColor: Theme.of(context).canvasColor,
      hoverColor: Theme.of(context).scaffoldBackgroundColor,
      isThreeLine: true,
      title: Text(
        bank.name ?? '',
        style: Theme.of(context).textTheme.headline2,
      ),
      subtitle: Text(
        bank.accountNumber!.toString(),
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
          ArchiveButton(onArchive: onArchive, isArchive: bank.archive!),
        ],
      ),
    );
  }
}
