part of 'plants_bloc.dart';

abstract class PlantsState extends Equatable {
  const PlantsState();
}

class PlantsInitial extends PlantsState {
  @override
  List<Object> get props => [];
}

class LoadingPlantsState extends PlantsState{
  @override
  List<Object?> get props => [];

}

class LoadedPlantsState extends PlantsState{
  final List<GetPlantDto> plants;

  const LoadedPlantsState({required this.plants});

  @override
  List<Object?> get props => [plants];

}

class LoadPlantsErrorState extends PlantsState{
  final String message;

  const LoadPlantsErrorState({required this.message});

  @override
  List<Object?> get props => [message];

}

class CreatingPlantState extends PlantsState{
  @override
  List<Object?> get props => [];

}

class CreatedPlantState extends PlantsState{
  final GetPlantDto plantDto;

  const CreatedPlantState({required this.plantDto});

  @override
  List<Object?> get props => [plantDto];

}

class CreatePlantErrorState extends PlantsState{
  final String message;

  const CreatePlantErrorState({required this.message});

  @override
  List<Object?> get props => [message];

}