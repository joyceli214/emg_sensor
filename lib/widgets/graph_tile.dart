import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class GraphTile extends StatelessWidget {
  final List<int> valueList;
  const GraphTile({super.key, required this.valueList});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: LineChart(
        duration: const Duration(milliseconds: 20),
        LineChartData(lineBarsData: [
          LineChartBarData(
              spots: List<FlSpot>.generate(
                  valueList.length,
                  (index) => FlSpot(
                      index.toDouble(), valueList.elementAt(index).toDouble())))
        ]
            // read about it in the LineChartData section
            ),
      ),
    );
    ;
  }
}
