part of 'led_bloc.dart';

abstract class LedEvent extends Equatable {
  const LedEvent();
}

class ToggleLedEvent extends LedEvent{
  @override
  List<Object?> get props => [];
}

class GetLedsStateEvent extends LedEvent{
  @override
  List<Object?> get props => [];

}
