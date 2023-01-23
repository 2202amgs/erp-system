import 'package:flutter/material.dart';
import 'package:frontend/app/core/constants/app_sizes.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppSize.s10 / 4),
      height: AppSize.s15,
      child: TextField(
        decoration: InputDecoration(
          hintText: 'بحث....',
          hintStyle: Theme.of(context).textTheme.headline6,
          fillColor: Theme.of(context).canvasColor,
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(AppSize.s2),
          ),
          suffixIcon: InkWell(
            borderRadius: BorderRadius.circular(AppSize.s2),
            onTap: () {},
            child: Container(
              padding: EdgeInsets.all(AppSize.s1 * 0.75),
              margin: EdgeInsets.symmetric(horizontal: AppSize.s2 / 2),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(AppSize.s2 / 2),
              ),
              child: Icon(Icons.search, color: Theme.of(context).hintColor),
            ),
          ),
        ),
      ),
    );
  }
}
