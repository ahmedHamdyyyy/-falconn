part of 'timer_bloc.dart';

// timer_state.dart
abstract class TimerState {
  final int remainingTime;
  final bool isRunning;

  TimerState(this.remainingTime, this.isRunning);
}

class TimerInitial extends TimerState {
  TimerInitial() : super(0, false);
}

class TimerRunning extends TimerState {
  TimerRunning(int remainingTime) : super(remainingTime, true);
}

class TimerStopped extends TimerState {
  TimerStopped() : super(0, false);
}
