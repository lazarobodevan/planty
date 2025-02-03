import 'dart:async';

import 'package:app/entities/get_plant_readings.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../services/i_plant_readings_service.dart';

part 'plant_details_event.dart';
part 'plant_details_state.dart';

class PlantDetailsBloc extends Bloc<PlantDetailsEvent, PlantDetailsState> {

  final IPlantReadingsService readingsService;

  PlantDetailsBloc({required this.readingsService}) : super(PlantDetailsInitial()) {
    on<LoadPlantDetailsEvent>((event, emit) async {
      try{
        emit(LoadingPlantDetailsState());
        var readings = await readingsService.getPlantReadings(event.sensorId);
        emit(LoadedPlantDetailsState(plantReadings: readings));
      }catch(e){
        emit(LoadPlantDetailsErrorState(message: e.toString()));
      }
    });


  }
}
