part of 'plant_editor_bloc.dart';

abstract class PlantEditorEvent extends Equatable {
  const PlantEditorEvent();
}

class CreatePlantEvent extends PlantEditorEvent{

  final CreatePlantDto plantDto;

  const CreatePlantEvent({required this.plantDto});

  @override
  List<Object?> get props => [plantDto];

}

class UpdatePlantEvent extends PlantEditorEvent{

  final String plantId;
  final UpdatePlantDTO plantDto;


  const UpdatePlantEvent({required this.plantId, required this.plantDto});

  @override
  List<Object?> get props => [plantId, plantDto];

}