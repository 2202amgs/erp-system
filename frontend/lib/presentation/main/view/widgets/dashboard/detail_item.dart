import 'package:flutter/material.dart';
import 'package:frontend/app/core/constants/app_sizes.dart';

class DetailItem extends StatelessWidget {
  final String text;
  final String icon;
  final num value;

  const DetailItem({
    Key? key,
    required this.text,
    required this.icon,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: AppSize.s4),
      padding: EdgeInsets.all(AppSize.s2),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).scaffoldBackgroundColor),
      ),
      child: Row(
        children: [
          Image.asset(icon, height: AppSize.s11, width: AppSize.s11),
          SizedBox(width: AppSize.s2),
          Text(
            text,
            style: Theme.of(context).textTheme.headline6,
          ),
          const Spacer(),
          Text(
            value.toString(),
            style: Theme.of(context).textTheme.headline6,
          ),
        ],
      ),
    );
  }
}
