part of 'plant_editor_bloc.dart';

abstract class PlantEditorState extends Equatable {
  const PlantEditorState();
}

class PlantEditorInitial extends PlantEditorState {
  @override
  List<Object> get props => [];
}

class SendingPlantState extends PlantEditorState{
  @override
  List<Object?> get props => [];

}

class CreatedPlantState extends PlantEditorState{

  final GetPlantDto plantDto;

  const CreatedPlantState({required this.plantDto});

  @override
  List<Object?> get props => [plantDto];
}

class UpdatedPlantState extends PlantEditorState{
  final GetPlantDto plantDto;

  const UpdatedPlantState({required this.plantDto});

  @override
  List<Object?> get props => [plantDto];

}

class SendPlantErrorState extends PlantEditorState{
  final String message;

  const SendPlantErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}