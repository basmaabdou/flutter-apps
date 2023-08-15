abstract class CounterStates{}

class CounterInitalStates extends CounterStates{}

class CounterMinusStates extends CounterStates{
  final int counter;

  CounterMinusStates(this.counter);
}

class CounterPlusStates extends CounterStates{}