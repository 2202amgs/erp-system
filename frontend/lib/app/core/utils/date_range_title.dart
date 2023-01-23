import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class DateRangeTitle extends StatelessWidget {
  const DateRangeTitle({Key? key, required this.timeRange}) : super(key: key);
  final DateTimeRange timeRange;
  @override
  Widget build(BuildContext context) {
    return Text(
      '${Jiffy(timeRange.start).yMMMMd} - ${Jiffy(timeRange.end).yMMMMd}',
      style: Theme.of(context).textTheme.headline2,
    );
  }
}
