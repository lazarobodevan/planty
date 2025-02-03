part of 'plants_bloc.dart';

abstract class PlantsEvent extends Equatable {
  const PlantsEvent();
}

class LoadPlantsEvent extends PlantsEvent{
  @override
  List<Object?> get props => [];
}

class LoadPlantDetailsEvent extends PlantsEvent{
  final String plantId;

  const LoadPlantDetailsEvent({required this.plantId});

  @override
  List<Object?> get props => [plantId];
}
