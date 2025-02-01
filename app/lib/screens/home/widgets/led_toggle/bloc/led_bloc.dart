import 'dart:async';

import 'package:app/services/i_led_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'led_event.dart';
part 'led_state.dart';

class LedBloc extends Bloc<LedEvent, LedState> {

  bool isLedsOn = true;
  final ILedService ledService;

  LedBloc({required this.ledService}) : super(LedInitial()) {
    on<LedEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<GetLedsStateEvent>((event, emit) async {
      try{
        emit(TogglingLedState());
        bool state = await ledService.getLedState();
        isLedsOn = state;
        emit(ToggledLedState(isOn: state));
      }catch(e){
        debugPrint(e.toString());
        emit(ToggleLedErrorState(message: e.toString()));
      }
    });

    on<ToggleLedEvent>((event, emit) async {
      try{
        emit(TogglingLedState());
        await ledService.toggleLed();
        isLedsOn = !isLedsOn;
        emit(ToggledLedState(isOn: isLedsOn));
      }catch(e){
        debugPrint(e.toString());
        emit(ToggleLedErrorState(message: e.toString()));
      }
    });
  }
}
