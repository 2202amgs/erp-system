import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CustomChart extends StatelessWidget {
  const CustomChart({
    Key? key,
    required this.chartSelctionData,
  }) : super(key: key);

  final List<PieChartSectionData> chartSelctionData;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: 200,
          child: PieChart(
            PieChartData(
              sections: chartSelctionData,
            ),
          ),
        ),
        Positioned.fill(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '%29.1',
                style: Theme.of(context).textTheme.headline1,
              ),
              Text(
                'of 128GB',
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
