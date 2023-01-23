import 'package:flutter/material.dart';

class DrawerListTile extends StatelessWidget {
  final String title;
  final String icon;
  final VoidCallback? onTap;
  final bool selected;
  const DrawerListTile({
    Key? key,
    required this.title,
    required this.icon,
    this.onTap,
    required this.selected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      horizontalTitleGap: 0.0,
      leading: Image.asset(
        icon,
        width: 25,
        height: 25,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline2,
      ),
      hoverColor: Theme.of(context).scaffoldBackgroundColor,
      selected: selected,
      selectedTileColor: Theme.of(context).scaffoldBackgroundColor,
    );
  }
}
