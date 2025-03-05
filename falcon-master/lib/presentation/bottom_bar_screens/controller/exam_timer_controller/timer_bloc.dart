import 'dart:async';
import 'package:falcon/core/core_exports.dart';
part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  Timer? _timer;
  DateTime? _startTime;
  int _duration = 0;

  TimerBloc() : super(TimerInitial()) {
    _loadRemainingTime();

    on<StartTimer>((event, emit) {
      _duration = event.duration;
      _timer?.cancel();
      _startTime = DateTime.now();
      _startTimer(_duration, emit);
      emit(TimerRunning(_duration));
    });

    on<UpdateTimer>((event, emit) {
      emit(TimerRunning(event.remainingTime));
    });

    on<StopTimer>((event, emit) {
      _timer?.cancel();
      emit(TimerStopped());
    });
  }

  void _startTimer(int duration, Emitter<TimerState> emit) {
    int remainingTime = duration;
    _saveStartTime(); // Save the start time

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingTime > 0) {
        remainingTime--;
        _saveRemainingTime(remainingTime); // Save the remaining time each second
        add(UpdateTimer(remainingTime));
      } else {
        add(StopTimer());
      }
    });
  }

  Future<void> _saveRemainingTime(int remainingTime) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('remainingTime', remainingTime); // Save remaining time
  }

  Future<void> _saveStartTime() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('startTime', DateTime.now().toIso8601String()); // Save start time
  }

  Future<void> _loadRemainingTime() async {
    final prefs = await SharedPreferences.getInstance();
    String? startTimeString = prefs.getString('startTime');
    int savedRemainingTime = prefs.getInt('remainingTime') ?? 0;

    if (startTimeString != null) {
      DateTime startTime = DateTime.parse(startTimeString);
      Duration elapsed = DateTime.now().difference(startTime);
      int elapsedSeconds = elapsed.inSeconds;

      int remainingTime = savedRemainingTime - elapsedSeconds;
      if (remainingTime > 0) {
        add(StartTimer(remainingTime)); // Start timer with adjusted remaining time
      } else {
        add(StopTimer()); // Time's up
      }
    } else {
      add(StartTimer(savedRemainingTime)); // Start timer with saved remaining time
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel(); // Cancel timer when Bloc is closed
    return super.close();
  }
}
