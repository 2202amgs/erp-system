import 'package:flutter/cupertino.dart';
import 'package:frontend/app/core/constants/app_sizes.dart';
import 'package:frontend/app/core/utils/responsive.dart';
import 'package:frontend/app/core/utils/toolbar_container.dart';

class CustomToolBar extends StatelessWidget {
  const CustomToolBar({Key? key, required this.children}) : super(key: key);
  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    return ToolBarContainer(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: AppSize.s1),
        width: double.infinity,
        child: Wrap(
          alignment: Responsive.isMobile(context)
              ? WrapAlignment.spaceBetween
              : WrapAlignment.spaceBetween,
          spacing: AppSize.s16,
          children: children,
        ),
      ),
    );
  }
}
