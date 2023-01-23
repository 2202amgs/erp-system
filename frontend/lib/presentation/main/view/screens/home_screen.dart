import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:frontend/app/core/constants/app_sizes.dart';
import 'package:frontend/app/core/utils/responsive.dart';
import 'package:frontend/presentation/main/view/widgets/dashboard/chart_container.dart';
import 'package:frontend/presentation/main/view/widgets/dashboard/header.dart';
import 'package:frontend/presentation/main/view/widgets/dashboard/home_inner_nav.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<PieChartSectionData> chartSelctionData = [
      PieChartSectionData(
        color: Theme.of(context).primaryColor,
        value: 1,
        showTitle: false,
      ),
      PieChartSectionData(
        color: Colors.amber,
        value: 1,
        showTitle: false,
      ),
      PieChartSectionData(
        color: Colors.red,
        value: 1,
        showTitle: false,
      ),
      PieChartSectionData(
        color: Colors.blueGrey,
        value: 1,
        showTitle: false,
      ),
    ];
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(AppSize.s2),
        child: Column(
          children: [
            const Header(
              title: 'الرئيسية',
              toolBar: SizedBox(),
            ),
            SizedBox(height: AppSize.s2),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Container(
                    padding: EdgeInsets.all(AppSize.s2),
                    height: 500,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSize.s2),
                    ),
                    child: Column(
                      children: [
                        const HomeInnerNav(),
                        SizedBox(height: AppSize.s2),
                        Container(
                          height: 100,
                          decoration: BoxDecoration(
                            color: Theme.of(context).canvasColor,
                            borderRadius: BorderRadius.circular(AppSize.s1),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(width: AppSize.s2),
                if (!Responsive.isMobile(context))
                  Expanded(
                    flex: 2,
                    child: ChartContainer(chartSelctionData: chartSelctionData),
                  ),
              ],
            ),
            if (Responsive.isMobile(context))
              ChartContainer(chartSelctionData: chartSelctionData),
          ],
        ),
      ),
    );
  }
}
