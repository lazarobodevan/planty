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
    BlocProvider.of<PlantDetailsBloc>(context).add(LoadPlantDetailsEvent(sensorId: widget.sensorId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Planta",
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

          if(state is LoadPlantDetailsErrorState){
            return Center(child: Text(state.message),);
          }

          if(state is LoadedPlantDetailsState) {

            // Obtendo a leitura mais antiga
            final firstReadingTime = state.plantReadings.readings.first.createdAt;

            // Pegando o tempo atual
            final now = DateTime.now();

            List<FlSpot> spots = state.plantReadings.readings.map((reading) {
              // Calculando a diferença em horas desde a leitura mais antiga
              double xValue = reading.createdAt.difference(firstReadingTime).inHours.toDouble();
              return FlSpot(xValue, reading.moisture.toDouble());
            }).toList();

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  MyLineChart(
                    text: "Umidade",
                    lineColor: Colors.blue,
                    minX: 0, // Definindo minX como 0
                    minY: 0, // Definindo minY como 0
                    maxX: 24,
                    maxY: 100, // Definindo maxY como 100%
                    spots: spots,
                    firstReadingTime: state.plantReadings.readings.first.createdAt,
                  ),
                ],
              ),
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
