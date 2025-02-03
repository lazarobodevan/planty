import 'dart:async';

import 'package:app/entities/create_plant_dto.dart';
import 'package:app/entities/get_plant_dto.dart';
import 'package:app/entities/update_plant_dto.dart';
import 'package:app/services/i_plant_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'plant_editor_event.dart';
part 'plant_editor_state.dart';

class PlantEditorBloc extends Bloc<PlantEditorEvent, PlantEditorState> {

  final IPlantService plantService;

  PlantEditorBloc({required this.plantService}) : super(PlantEditorInitial()) {

    on<CreatePlantEvent>((event, emit) async {
      try{
        emit(SendingPlantState());
        _validateCreatePlant(event.plantDto);
        var createdPlant = await plantService.createPlant(event.plantDto);
        emit(CreatedPlantState(plantDto: createdPlant));
      }catch(e){
        emit(SendPlantErrorState(message: e.toString()));
      }
    });

    on<UpdatePlantEvent>((event,emit) async {
      try{
        emit(SendingPlantState());
        var updated = await plantService.updatePlant(event.plantId, event.plantDto);
        emit(UpdatedPlantState(plantDto: updated));
      }catch(e){
        emit(SendPlantErrorState(message: e.toString()));
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
