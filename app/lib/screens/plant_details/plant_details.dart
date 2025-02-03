import 'package:app/entities/get_plant_dto.dart';
import 'package:app/entities/update_plant_dto.dart';
import 'package:app/screens/plant_details/widgets/my_line_chart.dart';
import 'package:app/screens/plant_editor/plant_editor.dart';
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
  void onUpdate(GetPlantDto plantDto) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PlantEditor(
          plant: plantDto,
        ),
      ),
    );
  }

  void onDelete(String plantId) {}

  void showDeleteDialog(String plantId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Deseja realmente excluir?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "Cancelar",
              style: TypographyStyles.label3(),
            ),
          ),
          TextButton(
            onPressed: () {
              onDelete(plantId);
              Navigator.of(context).pop();
            },
            child: Text(
              "Excluir",
              style: TypographyStyles.label3().copyWith(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    BlocProvider.of<PlantDetailsBloc>(context)
        .add(LoadPlantDetailsEvent(sensorId: widget.sensorId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PlantDetailsBloc, PlantDetailsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is LoadPlantDetailsErrorState) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Text(state.message),
            ),
          );
        }

        if (state is LoadingPlantDetailsState) {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        if (state is LoadedPlantDetailsState) {
          final firstReadingTime = state.plantReadings.readings.first.createdAt;

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

          return Scaffold(
            appBar: AppBar(
              title: Text(
                state.plantReadings.plantName,
                style: TypographyStyles.headline3(),
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      onDelete(state.plantReadings.plantId);
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    )),
                IconButton(
                    onPressed: () {
                      onUpdate(GetPlantDto(
                          id: state.plantReadings.plantId,
                          name: state.plantReadings.plantName,
                          description: state.plantReadings.description,
                          idealMoisturePercentage:
                              state.plantReadings.idealMoisturePercentage,
                          currentMoisturePercentage: 0,
                          idealLightExposure:
                              state.plantReadings.idealLightExposure,
                          currentLightExposure: 0,
                          idealTemperatureCelsius:
                              state.plantReadings.idealTemperatureCelsius,
                          currentTemperatureCelsius: 0,
                          sensorPort: state.plantReadings.sensorPort));
                    },
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.orange,
                    )),
              ],
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 26),
              child: Column(
                spacing: 20,
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
                      idealValue: state.plantReadings.idealMoisturePercentage
                          .toDouble(),
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
                    idealValue:
                        state.plantReadings.idealTemperatureCelsius.toDouble(),
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
                      idealValue:
                          state.plantReadings.idealLightExposure.toDouble(),
                    ),
                  )
                ],
              ),
            ),
          );
        }
        return SizedBox();
      },
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
