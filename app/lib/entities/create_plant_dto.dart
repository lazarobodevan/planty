
import 'dart:convert';

CreatePlantDto createPlantDtoFromJson(String str) => CreatePlantDto.fromJson(json.decode(str));

String createPlantDtoToJson(CreatePlantDto data) => json.encode(data.toJson());

class CreatePlantDto {
  final String name;
  final String description;
  final int idealMoisturePercentage;
  final int idealLightExposure;
  final int idealTemperatureCelsius;
  final String sensorPort;

  CreatePlantDto({
    required this.name,
    required this.description,
    required this.idealMoisturePercentage,
    required this.idealLightExposure,
    required this.idealTemperatureCelsius,
    required this.sensorPort,
  });

  CreatePlantDto copyWith({
    String? name,
    String? description,
    int? idealMoisturePercentage,
    int? idealLightExposure,
    int? idealTemperatureCelsius,
    String? sensorPort,
  }) =>
      CreatePlantDto(
        name: name ?? this.name,
        description: description ?? this.description,
        idealMoisturePercentage: idealMoisturePercentage ?? this.idealMoisturePercentage,
        idealLightExposure: idealLightExposure ?? this.idealLightExposure,
        idealTemperatureCelsius: idealTemperatureCelsius ?? this.idealTemperatureCelsius,
        sensorPort: sensorPort ?? this.sensorPort,
      );

  factory CreatePlantDto.fromJson(Map<String, dynamic> json) => CreatePlantDto(
    name: json["name"],
    description: json["description"],
    idealMoisturePercentage: json["idealMoisturePercentage"],
    idealLightExposure: json["idealLightExposure"],
    idealTemperatureCelsius: json["idealTemperatureCelsius"],
    sensorPort: json["sensorPort"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "description": description,
    "idealMoisturePercentage": idealMoisturePercentage,
    "idealLightExposure": idealLightExposure,
    "idealTemperatureCelsius": idealTemperatureCelsius,
    "sensorPort": sensorPort,
  };
}
