import 'package:app/entities/create_plant_dto.dart';
import 'package:app/entities/get_plant_dto.dart';
import 'package:app/entities/update_plant_dto.dart';

abstract class IPlantService{

  Future<List<GetPlantDto>> getPlants();
  Future<GetPlantDto> createPlant(CreatePlantDto plantDto);
  Future<GetPlantDto> updatePlant(String plantId, UpdatePlantDTO plantDto);

}