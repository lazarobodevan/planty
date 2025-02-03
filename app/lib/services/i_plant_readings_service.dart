import '../entities/get_plant_readings.dart';

abstract class IPlantReadingsService{
  Future<GetPlantReadings> getPlantReadings(String sensorId);
}