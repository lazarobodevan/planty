class UpdatePlantDTO {
  final String? name;
  final String? description;
  final int? idealTemperatureCelsius;
  final int? idealLightExposure;
  final int? idealMoisturePercentage;
  final String? sensorPort;

  UpdatePlantDTO(
      {this.name,
      this.description,
      this.idealTemperatureCelsius,
      this.idealLightExposure,
      this.idealMoisturePercentage,
      this.sensorPort});

  UpdatePlantDTO copyWith({
    String? name,
    String? description,
    int? idealTemperatureCelsius,
    int? idealLightExposure,
    int? idealMoisturePercentage,
    String? sensorPort,
  }) {
    return UpdatePlantDTO(
      name: name ?? this.name,
      description: description ?? this.description,
      idealTemperatureCelsius:
          idealTemperatureCelsius ?? this.idealTemperatureCelsius,
      idealLightExposure: idealLightExposure ?? this.idealLightExposure,
      idealMoisturePercentage:
          idealMoisturePercentage ?? this.idealMoisturePercentage,
      sensorPort: sensorPort ?? this.sensorPort,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};

    if (name != null) {
      json["name"] = name;
    }
    if (description != null) {
      json["description"] = description;
    }
    if (idealTemperatureCelsius != null) {
      json["idealTemperatureCelsius"] = idealTemperatureCelsius;
    }
    if (idealLightExposure != null) {
      json["idealLightExposure"] = idealLightExposure;
    }
    if (idealMoisturePercentage != null) {
      json["idealMoisturePercentage"] = idealMoisturePercentage;
    }
    if (sensorPort != null) {
      json["sensorPort"] = sensorPort;
    }

    return json;
  }
}
