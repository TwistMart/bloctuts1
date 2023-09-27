import 'package:bloctuts1/Color%20Bloc/color_state.dart';
import 'package:bloctuts1/Counter%20Bloc/counter_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ColorBloc extends Bloc<CounterEvent, ColorState> {
  ColorBloc() : super(ColorInitialState()) {
    on<CounterIncrementEvent>((event, emit) {
      emit(ColorIncrementState(state.color=Colors.teal)); // takes the current color which is purple and gives it the given color
    });
    on<CounterDecrementEvent>((event, emit) {
      emit(ColorDecrementState(state.color=Colors.brown));
    });
  }
}
