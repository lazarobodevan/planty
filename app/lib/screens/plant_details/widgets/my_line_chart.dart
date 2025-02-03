import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../theme/typography_styles.dart';

class MyLineChart extends StatefulWidget {
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
  final String? tooltipUnit;
  final bool isLux;
  final double idealValue;

  const MyLineChart(
      {Key? key,
      required this.text,
      required this.lineColor,
      this.belowChartColor,
      required this.minX,
      required this.minY,
      required this.maxX,
      required this.maxY,
      this.getXLabels,
      required this.spots,
      required this.firstReadingTime,
      this.tooltipUnit,
      this.isLux = false,
      required this.idealValue})
      : super(key: key);

  @override
  _MyLineChartState createState() => _MyLineChartState();
}

class _MyLineChartState extends State<MyLineChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _animation;
  final ValueNotifier<int> _visibleSpotsCount = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );

    _animation =
        IntTween(begin: 0, end: widget.spots.length).animate(_controller)
          ..addListener(() {
            _visibleSpotsCount.value = _animation.value;
          });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _visibleSpotsCount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          widget.text,
          style: TypographyStyles.label1(),
        ),
        widget.spots.isNotEmpty
            ? Container(
                height: 200,
                child: ValueListenableBuilder<int>(
                  valueListenable: _visibleSpotsCount,
                  builder: (context, visibleSpotsCount, child) {
                    return LineChart(
                      LineChartData(
                        minX: widget.minX,
                        maxX: widget.maxX,
                        minY: widget.minY,
                        maxY: widget.maxY,
                        baselineY: widget.minY,
                        lineTouchData: LineTouchData(
                          touchTooltipData: LineTouchTooltipData(
                            getTooltipItems: (List<LineBarSpot> touchedSpots) {
                              return touchedSpots
                                  .map((LineBarSpot touchedSpot) {
                                return LineTooltipItem(
                                  '${touchedSpot.y.toStringAsFixed(0)}${widget.tooltipUnit ?? ""}',
                                  const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              }).toList();
                            },
                          ),
                        ),
                        titlesData: FlTitlesData(
                          show: true,
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 50,
                              getTitlesWidget: (double value, TitleMeta meta) {
                                if (widget.isLux) {
                                  if (value == meta.max) {
                                    return const Text('');
                                  }

                                  if (value >= 20000) return Text('20000');
                                  if (value >= 10000) return Text('10000');
                                  if (value >= 2000) return Text('2000');
                                  if (value >= 500) return Text('500');
                                  if (value >= 0) return Text('0');
                                }
                                if (value == meta.max) {
                                  return const Text('');
                                } else if (value == meta.min) {
                                  return const Text('');
                                }
                                return Text(value.toStringAsFixed(0));
                              },
                            ),
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
                              getTitlesWidget: bottomTitleWidgets,
                            ),
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
                            color: widget.lineColor,
                            belowBarData: BarAreaData(
                              show: true,
                              gradient: widget.belowChartColor ??
                                  const LinearGradient(
                                    begin: Alignment(0, 1),
                                    colors: [
                                      Colors.transparent,
                                      Colors.transparent,
                                    ],
                                  ),
                            ),
                            spots: widget.spots.sublist(0, visibleSpotsCount),
                          ),
                        ],
                        extraLinesData: ExtraLinesData(
                          horizontalLines: [
                            HorizontalLine(
                              y: widget.idealValue,
                              color: Colors.deepPurpleAccent,
                              strokeWidth: 2,
                              dashArray: [10, 5],

                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            : const AspectRatio(
                aspectRatio: 2,
                child: Center(
                  child: Text("Sem registros suficientes"),
                ),
              ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    var style = TypographyStyles.paragraph4();
    DateTime time = widget.firstReadingTime.add(Duration(hours: value.toInt()));
    String formattedTime = DateFormat('HH').format(time);
    return SideTitleWidget(
      meta: meta,
      angle: 1.2,
      space: 0,
      child: Transform.translate(
          offset: Offset(5, 10), child: Text(formattedTime, style: style)),
    );
  }
}
