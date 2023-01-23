import 'package:flutter/material.dart';
import 'package:frontend/app/core/constants/app_sizes.dart';

class HomeInnerNav extends StatelessWidget {
  const HomeInnerNav({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'عنوان',
              style: Theme.of(context).textTheme.headline6,
            ),
            ElevatedButton.icon(
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSize.s2 * 1.5,
                  vertical: AppSize.s2,
                ),
              ),
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text('إضافة'),
            ),
          ],
        ),
        SizedBox(height: AppSize.s3),
        GridView.builder(
          itemCount: 4,
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: AppSize.s1,
          ),
          itemBuilder: (context, index) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSize.s1),
              color: Theme.of(context).canvasColor,
            ),
          ),
        ),
      ],
    );
  }
}
