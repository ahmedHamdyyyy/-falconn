part of 'timer_bloc.dart';

// timer_event.dart
abstract class TimerEvent {}

class StartTimer extends TimerEvent {
  final int duration;

  StartTimer(this.duration);
}

class UpdateTimer extends TimerEvent {
  final int remainingTime;

  UpdateTimer(this.remainingTime);
}

class StopTimer extends TimerEvent {}
