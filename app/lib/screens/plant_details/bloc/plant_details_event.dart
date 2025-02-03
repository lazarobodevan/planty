part of 'plant_details_bloc.dart';

abstract class PlantDetailsEvent extends Equatable {
  const PlantDetailsEvent();
}

class LoadPlantDetailsEvent extends PlantDetailsEvent{
  final String sensorId;

  const LoadPlantDetailsEvent({required this.sensorId});

  @override
  List<Object?> get props => [sensorId];


}

class DeletePlantEvent extends PlantDetailsEvent{

  final String plantId;

  const DeletePlantEvent({required this.plantId});

  @override
  List<Object?> get props => [plantId];

}