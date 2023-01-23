import 'package:flutter/material.dart';
import 'package:frontend/app/core/constants/app_sizes.dart';
import 'package:frontend/app/core/utils/archive_button.dart';
import 'package:frontend/data/models/car_model.dart';

class CarTaile extends StatelessWidget {
  final GestureTapCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onArchive;
  const CarTaile({
    Key? key,
    required this.car,
    this.onTap,
    this.onEdit,
    this.onArchive,
  }) : super(key: key);

  final CarModel car;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      tileColor: Theme.of(context).canvasColor,
      hoverColor: Theme.of(context).primaryColor,
      isThreeLine: true,
      leading: Container(
        padding: EdgeInsets.symmetric(vertical: AppSize.s4),
        width: 60,
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(AppSize.s1),
        ),
        child: Text(
          car.sailon! ? 'سايلون' : 'فرش',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: AppSize.s3,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      title: Text(
        car.driverName!,
        style: Theme.of(context).textTheme.headline2,
      ),
      subtitle: Text(
        car.ownerName!,
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
          ArchiveButton(onArchive: onArchive, isArchive: car.archive!),
        ],
      ),
    );
  }
}
