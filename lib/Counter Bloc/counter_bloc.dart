import 'package:bloctuts1/Counter%20Bloc/counter_event.dart';
import 'package:bloctuts1/Counter%20Bloc/counter_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterInitialState()) {
    on<CounterIncrementEvent>((event, emit) { // bloc has the event and state
      emit(CounterIncrementState(state.counter + 1)); // state access the  current value  which is 0 via CounterIncrementState and emit increases value with 1
    });

    on<CounterDecrementEvent>((event, emit) { 
      emit(CounterDecrementState(state.counter - 1)); // state access the current value which is 0, via CounterDecrementState and  emit  decreases value with 1 so emit gets the changed value
    });
  }
}
