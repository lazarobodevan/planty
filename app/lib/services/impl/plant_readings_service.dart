import 'package:app/entities/get_plant_dto.dart';
import 'package:app/entities/get_plant_readings.dart';
import 'package:app/environment.dart';
import 'package:app/services/i_plant_readings_service.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class PlantReadingsService implements IPlantReadingsService {
  @override
  Future<GetPlantReadings> getPlantReadings(String sensorId) async {
    try {
      var response = await get(Uri.parse(
          "${Environment.apiUrl}/plantReading/sensorId=$sensorId"));
      if(response.statusCode == 200){
        return GetPlantReadings.fromRawJson(response.body);
      }
      throw new Exception("Falha ao buscar leituras: ${response.body}");
    } catch (e) {
      throw Exception("Falha ao buscar leituras: ${e.toString()}");
    }
  }
}
