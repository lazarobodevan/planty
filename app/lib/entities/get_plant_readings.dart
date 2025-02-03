import 'dart:convert';

import 'package:app/entities/plant_reading.dart';

class GetPlantReadings {
  final String plantId;
  final String sensorPort;
  final List<PlantReading> readings;

  GetPlantReadings({
    required this.plantId,
    required this.sensorPort,
    required this.readings,
  });

  GetPlantReadings copyWith({
    String? plantId,
    String? sensorPort,
    List<PlantReading>? readings,
  }) =>
      GetPlantReadings(
        plantId: plantId ?? this.plantId,
        sensorPort: sensorPort ?? this.sensorPort,
        readings: readings ?? this.readings,
      );

  factory GetPlantReadings.fromRawJson(String str) => GetPlantReadings.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetPlantReadings.fromJson(Map<String, dynamic> json) => GetPlantReadings(
    plantId: json["plantId"],
    sensorPort: json["sensorPort"],
    readings: List<PlantReading>.from(json["readings"].map((x) => PlantReading.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "plantId": plantId,
    "sensorPort": sensorPort,
    "readings": List<dynamic>.from(readings.map((x) => x.toJson())),
  };
}