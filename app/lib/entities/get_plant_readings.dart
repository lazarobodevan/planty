import 'dart:convert';

import 'package:app/entities/plant_reading.dart';

class GetPlantReadings {
  final String plantId;
  final String plantName;
  final String description;
  final String sensorPort;
  final int idealMoisturePercentage;
  final int idealTemperatureCelsius;
  final int idealLightExposure;
  final List<PlantReading> readings;

  GetPlantReadings({
    required this.plantId,
    required this.plantName,
    required this.sensorPort,
    required this.idealMoisturePercentage,
    required this.idealTemperatureCelsius,
    required this.idealLightExposure,
    required this.readings,
    required this.description
  });

  GetPlantReadings copyWith({
    String? plantId,
    String? plantName,
    String? description,
    String? sensorPort,
    int? idealMoisturePercentage,
    int? idealTemperatureCelsius,
    int? idealLightExposure,
    List<PlantReading>? readings,
  }) =>
      GetPlantReadings(
        plantId: plantId ?? this.plantId,
        plantName: plantName ?? this.plantName,
        description: description ?? this.description,
        sensorPort: sensorPort ?? this.sensorPort,
        idealMoisturePercentage: idealMoisturePercentage ?? this.idealMoisturePercentage,
        idealTemperatureCelsius: idealTemperatureCelsius ?? this.idealTemperatureCelsius,
        idealLightExposure: idealLightExposure ?? this.idealLightExposure,
        readings: readings ?? this.readings,
      );

  factory GetPlantReadings.fromRawJson(String str) => GetPlantReadings.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetPlantReadings.fromJson(Map<String, dynamic> json) => GetPlantReadings(
    plantId: json["plantId"],
    plantName: json["plantName"],
    description: json["description"],
    sensorPort: json["sensorPort"],
    idealMoisturePercentage: json["idealMoisturePercentage"],
    idealTemperatureCelsius: json["idealTemperatureCelsius"],
    idealLightExposure: json["idealLightExposure"],
    readings: List<PlantReading>.from(json["readings"].map((x) => PlantReading.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "plantId": plantId,
    "plantName": plantName,
    "sensorPort": sensorPort,
    "idealMoisturePercentage": idealMoisturePercentage,
    "idealTemperatureCelsius": idealTemperatureCelsius,
    "idealLightExposure": idealLightExposure,
    "readings": List<dynamic>.from(readings.map((x) => x.toJson())),
  };
}

