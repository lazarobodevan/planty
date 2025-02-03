part of 'plant_details_bloc.dart';

abstract class PlantDetailsState extends Equatable {
  const PlantDetailsState();
}

class PlantDetailsInitial extends PlantDetailsState {
  @override
  List<Object> get props => [];
}

class LoadingPlantDetailsState extends PlantDetailsState {
  @override
  List<Object> get props => [];
}

class LoadedPlantDetailsState extends PlantDetailsState {
  final GetPlantReadings plantReadings;

  const LoadedPlantDetailsState({required this.plantReadings});

  @override
  List<Object> get props => [plantReadings];
}

class LoadPlantDetailsErrorState extends PlantDetailsState {
  final String message;

  const LoadPlantDetailsErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
