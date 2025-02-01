import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/led_bloc.dart';

class LedToggle extends StatefulWidget {
  const LedToggle({super.key});

  @override
  State<LedToggle> createState() => _LedToggleState();
}

class _LedToggleState extends State<LedToggle> {
  @override
  void initState() {
    BlocProvider.of<LedBloc>(context).add(GetLedsStateEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LedBloc, LedState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {

        if(state is TogglingLedState){
          return const Center(child: CircularProgressIndicator(),);
        }

        if(state is ToggledLedState) {
          bool isledOn = state.isOn;
          return Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 2,
                      spreadRadius: 1,
                      offset: Offset(0, 2)
                  )
                ]
            ),
            child: IconButton(
                onPressed: () {
                  BlocProvider.of<LedBloc>(context).add(ToggleLedEvent());
                },
                icon: Icon(
                  isledOn ? Icons.lightbulb : Icons.lightbulb_outline,
                  color: isledOn ? Colors.yellow : Colors.grey.shade400,
                )),
          );
        }
        return SizedBox();
      },
    );
  }
}
