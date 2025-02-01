part of 'led_bloc.dart';

abstract class LedState extends Equatable {
  const LedState();
}

class LedInitial extends LedState {
  @override
  List<Object> get props => [];
}

class TogglingLedState extends LedState{
  @override
  List<Object?> get props => [];

}

class ToggledLedState extends LedState{
  final bool isOn;

  const ToggledLedState({required this.isOn});

  @override
  List<Object?> get props => [isOn];

}

class ToggleLedErrorState extends LedState{
  final String message;

  const ToggleLedErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
