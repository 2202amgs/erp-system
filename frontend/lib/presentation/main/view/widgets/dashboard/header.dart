import 'package:flutter/material.dart';
import 'package:frontend/app/core/utils/custom_toolbar.dart';
import 'package:frontend/app/core/utils/responsive.dart';
import 'package:frontend/presentation/main/controllers/dashboard_controller.dart';
import 'package:frontend/presentation/main/view/widgets/dashboard/profile_card.dart';
import 'package:get/get.dart';

class Header extends StatelessWidget {
  final String title;
  final Widget toolBar;
  const Header({
    Key? key,
    required this.title,
    required this.toolBar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomToolBar(
      children: [
        TitleBar(title: title),
        // const Spacer(),
        toolBar,
        // const Expanded(
        //   child: SearchField(),
        // ),
        const ProfileCard(),
      ],
    );
  }
}

class TitleBar extends GetView<DashboardController> {
  const TitleBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (Responsive.isMobile(context))
          IconButton(
            onPressed: () {
              controller.formKey.currentState!.openDrawer();
            },
            icon: const Icon(Icons.menu),
          ),
        Text(
          title,
          style: Theme.of(context).textTheme.headline1,
        ),
      ],
    );
  }
}
