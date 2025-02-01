import 'package:app/entities/create_plant_dto.dart';
import 'package:app/services/i_plant_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../entities/get_plant_dto.dart';

part 'plants_event.dart';
part 'plants_state.dart';

class PlantsBloc extends Bloc<PlantsEvent, PlantsState> {

  final IPlantService plantService;

  PlantsBloc({required this.plantService}) : super(PlantsInitial()) {
    on<PlantsEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<LoadPlantsEvent>((event, emit) async {
      try {
        emit(LoadingPlantsState());
        var plants = await plantService.getPlants();
        emit(LoadedPlantsState(plants: plants));
      }catch(e){
        debugPrint(e.toString());
        emit(LoadPlantsErrorState(message: e.toString()));
      }
    });

    on<CreatePlantEvent>((event, emit) async{
      try {
        emit(CreatingPlantState());
        _validateCreatePlant(event.plantDto);
        var createdPlant = await plantService.createPlant(event.plantDto);
        emit(CreatedPlantState(plantDto: createdPlant));
      }catch(e){
        emit(CreatePlantErrorState(message: e.toString()));
      }
    });
  }

  _validateCreatePlant(CreatePlantDto plantDto){
    if(plantDto.name.length < 3){
      throw Exception("Nome deve ter pelo menos 3 letras");
    }
    if(plantDto.sensorPort.isEmpty){
      throw Exception("Porta do sensor não deve ser nula");
    }
    if(plantDto.idealMoisturePercentage < 0 || plantDto.idealMoisturePercentage > 100){
      throw Exception("Umidade deve ser entre 0 e 100%");
    }
    if(plantDto.idealLightExposure < 0 || plantDto.idealLightExposure > 50000){
      throw Exception("Luminosidade deve ser entre 0 e 50000 lux");
    }
    if(plantDto.idealTemperatureCelsius < 0 || plantDto.idealTemperatureCelsius > 45){
      throw Exception("Temeperatura deve ser entre 0 e 45ºC");
    }
  }
}
