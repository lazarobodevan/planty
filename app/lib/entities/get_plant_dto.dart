
import 'dart:convert';

List<GetPlantDto> getPlantDtoFromJson(String str) => List<GetPlantDto>.from(json.decode(str).map((x) => GetPlantDto.fromJson(x)));

String getPlantDtoToJson(List<GetPlantDto> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetPlantDto {
  final String id;
  final String name;
  final String description;
  final int idealMoisturePercentage;
  final int currentMoisturePercentage;
  final int idealLightExposure;
  final int currentLightExposure;
  final int idealTemperatureCelsius;
  final double currentTemperatureCelsius;
  final String sensorPort;

  GetPlantDto({
    required this.id,
    required this.name,
    required this.description,
    required this.idealMoisturePercentage,
    required this.currentMoisturePercentage,
    required this.idealLightExposure,
    required this.currentLightExposure,
    required this.idealTemperatureCelsius,
    required this.currentTemperatureCelsius,
    required this.sensorPort,
  });

  GetPlantDto copyWith({
    String? id,
    String? name,
    String? description,
    int? idealMoisturePercentage,
    int? currentMoisturePercentage,
    int? idealLightExposure,
    int? currentLightExposure,
    int? idealTemperatureCelsius,
    double? currentTemperatureCelsius,
    String? sensorPort,
  }) =>
      GetPlantDto(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        idealMoisturePercentage: idealMoisturePercentage ?? this.idealMoisturePercentage,
        currentMoisturePercentage: currentMoisturePercentage ?? this.currentMoisturePercentage,
        idealLightExposure: idealLightExposure ?? this.idealLightExposure,
        currentLightExposure: currentLightExposure ?? this.currentLightExposure,
        idealTemperatureCelsius: idealTemperatureCelsius ?? this.idealTemperatureCelsius,
        currentTemperatureCelsius: currentTemperatureCelsius ?? this.currentTemperatureCelsius,
        sensorPort: sensorPort ?? this.sensorPort,
      );

  factory GetPlantDto.fromJson(Map<String, dynamic> json) => GetPlantDto(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    idealMoisturePercentage: json["idealMoisturePercentage"],
    currentMoisturePercentage: json["currentMoisturePercentage"],
    idealLightExposure: json["idealLightExposure"],
    currentLightExposure: json["currentLightExposure"],
    idealTemperatureCelsius: json["idealTemperatureCelsius"],
    currentTemperatureCelsius: json["currentTemperatureCelsius"]?.toDouble(),
    sensorPort: json["sensorPort"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "idealMoisturePercentage": idealMoisturePercentage,
    "currentMoisturePercentage": currentMoisturePercentage,
    "idealLightExposure": idealLightExposure,
    "currentLightExposure": currentLightExposure,
    "idealTemperatureCelsius": idealTemperatureCelsius,
    "currentTemperatureCelsius": currentTemperatureCelsius,
    "sensorPort": sensorPort,
  };
}
