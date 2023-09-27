abstract class CounterState {
  int counter = 0;
  CounterState({required this.counter});
}

class CounterInitialState extends CounterState {
  CounterInitialState() : super(counter: 0);  // access the counter value by use of super
}

class CounterIncrementState extends CounterState {
  CounterIncrementState(int increasedCounter)
      : super(counter: increasedCounter);
}

class CounterDecrementState extends CounterState {
  CounterDecrementState(int decrementCounter)
      : super(counter: decrementCounter);
}
