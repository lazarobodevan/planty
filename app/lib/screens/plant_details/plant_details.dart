import 'package:app/screens/plant_details/widgets/my_line_chart.dart';
import 'package:app/theme/typography_styles.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/plant_details_bloc.dart';

class PlantDetails extends StatefulWidget {
  final String sensorId;

  const PlantDetails({required this.sensorId, super.key});

  @override
  State<PlantDetails> createState() => _PlantDetailsState();
}

class _PlantDetailsState extends State<PlantDetails> {
  @override
  void initState() {
    BlocProvider.of<PlantDetailsBloc>(context)
        .add(LoadPlantDetailsEvent(sensorId: widget.sensorId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Detalhes",
          style: TypographyStyles.headline3(),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.edit,
                color: Colors.orange,
              )),
        ],
      ),
      body: BlocConsumer<PlantDetailsBloc, PlantDetailsState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is LoadPlantDetailsErrorState) {
            return Center(
              child: Text(state.message),
            );
          }

          if (state is LoadingPlantDetailsState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is LoadedPlantDetailsState) {
            final firstReadingTime =
                state.plantReadings.readings.first.createdAt;

            List<FlSpot> moistureSpots =
                state.plantReadings.readings.asMap().entries.map((reading) {
              double xValue = reading.value.createdAt
                      .difference(firstReadingTime)
                      .inMinutes
                      .toDouble() /
                  60;
              return FlSpot(
                  xValue.ceilToDouble(), reading.value.moisture.toDouble());
            }).toList();

            List<FlSpot> luxSpots =
                state.plantReadings.readings.asMap().entries.map((reading) {
              double xValue = reading.value.createdAt
                      .difference(firstReadingTime)
                      .inMinutes
                      .toDouble() /
                  60;
              return FlSpot(
                  xValue.ceilToDouble(), reading.value.light.toDouble());
            }).toList();

            List<FlSpot> tempSpots =
                state.plantReadings.readings.asMap().entries.map((reading) {
              double xValue = reading.value.createdAt
                      .difference(firstReadingTime)
                      .inMinutes
                      .toDouble() /
                  60;
              return FlSpot(xValue.ceilToDouble(),
                  reading.value.temperatureCelsius.toDouble());
            }).toList();

            return SingleChildScrollView(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 26),
              child: Column(
                spacing: 40,
                children: [
                  _buildChartCard(
                    MyLineChart(
                      key: UniqueKey(),
                      text: "Umidade",
                      lineColor: Colors.blue,
                      minX: 0,
                      minY: 0,
                      maxX: 24,
                      maxY: 100,
                      spots: moistureSpots,
                      firstReadingTime:
                          state.plantReadings.readings.first.createdAt,
                      tooltipUnit: "%",
                      idealValue: state.plantReadings.,
                    ),
                  ),
                  _buildChartCard(MyLineChart(
                    key: UniqueKey(),
                    text: "Temperatura",
                    lineColor: Colors.red,
                    minX: 0,
                    // Definindo minX como 0
                    minY: 0,
                    // Definindo minY como 0
                    maxX: 24,
                    maxY: 45,
                    // Definindo maxY como 100%
                    spots: tempSpots,
                    firstReadingTime:
                        state.plantReadings.readings.first.createdAt,
                    tooltipUnit: "ºC",
                  )),
                  _buildChartCard(
                    MyLineChart(
                      key: UniqueKey(),
                      text: "Luminosidade",
                      lineColor: Colors.yellow,
                      minX: 0,
                      minY: 0,
                      maxX: 24,
                      maxY: state.plantReadings.readings
                              .map((reading) => reading.light)
                              .reduce((a, b) => a > b ? a : b)
                              .toDouble() +
                          500,
                      spots: luxSpots,
                      firstReadingTime:
                          state.plantReadings.readings.first.createdAt,
                      tooltipUnit: " Lux",
                      isLux: true,
                    ),
                  )
                ],
              ),
            );
          }
          return SizedBox();
        },
      ),
    );
  }

  Widget _buildChartCard(Widget child) {
    return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                spreadRadius: 2,
                blurRadius: 6,
              )
            ]),
        child: child);
  }
}
