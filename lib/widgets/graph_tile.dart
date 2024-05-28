import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class GraphTile extends StatelessWidget {
  final List<int> valueList;
  const GraphTile({super.key, required this.valueList});

  @override
  Widget build(BuildContext context) {
    print(valueList.toString());
    return SizedBox(
      height: 200,
      child: LineChart(
        duration: const Duration(milliseconds: 20),
        LineChartData(
          lineBarsData: [
            LineChartBarData(
              dotData: const FlDotData(
                show: false,
                // checkToShowDot: (spot, barData) => spot.x % 20 == 0,
              ),
              spots: List<FlSpot>.generate(
                valueList.length,
                (index) => FlSpot(
                  index + .0,
                  valueList.elementAt(index).roundToDouble(),
                ),
              ),
            ),
          ],
          minY: 0,
          maxY: 10000,
          titlesData: const FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
        ),
      ),
    );
    ;
  }
}
