import 'dart:convert';

class PlantReading {
  final String id;
  final int moisture;
  final int light;
  final int temperatureCelsius;
  final DateTime createdAt;

  PlantReading({
    required this.id,
    required this.moisture,
    required this.light,
    required this.temperatureCelsius,
    required this.createdAt,
  });

  PlantReading copyWith({
    String? id,
    int? moisture,
    int? light,
    int? temperatureCelsius,
    DateTime? createdAt,
  }) =>
      PlantReading(
        id: id ?? this.id,
        moisture: moisture ?? this.moisture,
        light: light ?? this.light,
        temperatureCelsius: temperatureCelsius ?? this.temperatureCelsius,
        createdAt: createdAt ?? this.createdAt,
      );

  factory PlantReading.fromRawJson(String str) => PlantReading.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PlantReading.fromJson(Map<String, dynamic> json) => PlantReading(
    id: json["id"],
    moisture: json["moisture"],
    light: json["light"],
    temperatureCelsius: json["temperatureCelsius"],
    createdAt: DateTime.parse(json["createdAt"]).subtract(const Duration(hours: 3)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "moisture": moisture,
    "light": light,
    "temperatureCelsius": temperatureCelsius,
    "createdAt": createdAt.toIso8601String(),
  };
}
