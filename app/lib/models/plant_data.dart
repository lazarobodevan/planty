class PlantData {
  final String name;
  final int minTemperature;
  final int maxTemperature;
  final int minMoisture;
  final int maxMoisture;

  PlantData(
      {required this.name,
      required this.minTemperature,
      required this.maxTemperature,
      required this.minMoisture,
      required this.maxMoisture});

  factory PlantData.fromJson(Map<String, dynamic> json) {
    return PlantData(
      name: json['name'],
      minTemperature: json['minTemperature'].toInt(),
      maxTemperature: json['maxTemperature'].toInt(),
      minMoisture: json['minMoisture'].toInt(),
      maxMoisture: json['maxMoisture'].toInt(),
    );
  }
}
