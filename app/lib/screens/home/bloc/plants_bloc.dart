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
      } catch (e) {
        debugPrint(e.toString());
        emit(LoadPlantsErrorState(message: e.toString()));
      }
    });
  }

}
