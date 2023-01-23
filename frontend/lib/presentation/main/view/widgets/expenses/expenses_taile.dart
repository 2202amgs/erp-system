import 'package:flutter/material.dart';
import 'package:frontend/app/core/utils/archive_button.dart';
import 'package:frontend/data/models/expenses_model.dart';

class ExpensesTaile extends StatelessWidget {
  final GestureTapCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onArchive;
  const ExpensesTaile({
    Key? key,
    required this.expenses,
    this.onTap,
    this.onEdit,
    this.onArchive,
  }) : super(key: key);

  final ExpensesModel expenses;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      tileColor: Theme.of(context).canvasColor,
      hoverColor: Theme.of(context).primaryColor,
      isThreeLine: true,
      title: Text(
        expenses.name.toString(),
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
          ArchiveButton(onArchive: onArchive, isArchive: expenses.archive!),
        ],
      ),
    );
  }
}
