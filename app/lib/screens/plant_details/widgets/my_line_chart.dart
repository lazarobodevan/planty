import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../theme/typography_styles.dart';

class MyLineChart extends StatelessWidget {
  final String text;
  final Color lineColor;
  final Gradient? belowChartColor;
  final double minX;
  final double minY;
  final double maxX;
  final double maxY;
  final DateTime firstReadingTime;
  final Function? getXLabels;
  final List<FlSpot> spots;

  const MyLineChart(
      {super.key,
        required this.text,
        required this.lineColor,
        this.belowChartColor,
        required this.minX,
        required this.minY,
        required this.maxX,
        required this.maxY,
        this.getXLabels,
        required this.spots,
        required this.firstReadingTime});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          text,
          style: TypographyStyles.label1(),
        ),
        const SizedBox(
          height: 20,
        ),
        spots.isNotEmpty
            ? Container(
          height: 200,
          child: LineChart(

            LineChartData(
                minX: minX,
                maxX: maxX,
                minY: minY,
                maxY: maxY,
                baselineY: minY,
                lineTouchData: LineTouchData(
                    touchTooltipData: LineTouchTooltipData(
                      getTooltipItems: (List<LineBarSpot> touchedSpots) {
                        return touchedSpots.map((LineBarSpot touchedSpot) {
                          return LineTooltipItem(
                            '${touchedSpot.y}',
                            const TextStyle(
                              color: Colors.white, // Cor do texto do tooltip
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }).toList();
                      },
                    )),
                titlesData: FlTitlesData(
                  show: true,
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          if (value == meta.max) {
                            return const Text('');
                          } else if (value == meta.min) {
                            return const Text('');
                          }
                          return Text(value.toString());
                        }),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: false,
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        interval: 1,
                        getTitlesWidget: bottomTitleWidgets),
                  ),
                ),
                gridData: const FlGridData(
                  show: true,
                  drawVerticalLine: false,
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                      isCurved: true,
                      barWidth: 3,
                      color: lineColor,
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: belowChartColor ??
                            const LinearGradient(
                                begin: Alignment(0, 1),
                                colors: [
                                  Colors.transparent,
                                  Colors.transparent
                                ]),
                      ),
                      spots: spots)
                ]),
          ),
        )
            : const AspectRatio(
            aspectRatio: 2,
            child: Center(
              child: Text("Sem registros suficientes"),
            )),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    var style = TypographyStyles.paragraph4();
    DateTime time = firstReadingTime.add(Duration(hours: value.toInt()));
    String formattedTime = DateFormat('HH').format(time);
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child:
      Transform.rotate(angle: 1.2, child: Text(formattedTime, style: style)),
    );
  }
}
