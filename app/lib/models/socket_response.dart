import 'dart:convert';

import 'package:app/models/plant_data.dart';

class SocketResponse {
  final double lux;
  final double temperature;
  final double moisture;
  final bool moistureInRange;
  final PlantData plantData;




  // Construtor para criar um objeto SensorData a partir de um Map
  factory SocketResponse.fromJson(Map<String, dynamic> json) {
    return SocketResponse(
      lux: json['lux'].toDouble(),
      moisture:  json['moisture'].toDouble(),
      temperature: json['temp'].toDouble(),
      moistureInRange: json['moistureInRange'],
      plantData: PlantData.fromJson(json['plantData']),
    );
  }

  SocketResponse({required this.lux, required this.temperature, required this.moisture, required this.moistureInRange, required this.plantData});

}
