import 'package:flutter/material.dart';
import 'package:frontend/app/core/constants/app_sizes.dart';

class ToolBarContainer extends StatelessWidget {
  final Widget child;
  const ToolBarContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.only(start: AppSize.s2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.s2),
        boxShadow: const [
          BoxShadow(blurRadius: 20, spreadRadius: 2),
        ],
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: child,
    );
  }
}
