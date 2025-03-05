// import 'package:falcon/core/core_exports.dart';
//
// // Add this to your _startTimer method or wherever you initialize the timer.
// void _startTimer(int duration) {
//   int remainingTime = duration;
//   _saveRemainingTime(remainingTime); // Save the initial duration
//   _timer = Timer.periodic(Duration(seconds: 1), (timer) {
//     if (remainingTime > 0) {
//       remainingTime--;
//       _saveRemainingTime(remainingTime); // Save the remaining time each second
//       add(UpdateTimer(remainingTime));
//     } else {
//       add(StopTimer());
//     }
//   });
// }
//
// void _saveRemainingTime(int remainingTime) async {
//   final prefs = await SharedPreferences.getInstance();
//   prefs.setInt('remainingTime', remainingTime);
// }
//
// // Load the saved time when initializing the Bloc
// TimerBloc() : super(TimerInitial()) {
// _loadRemainingTime();
// }
//
// void _loadRemainingTime() async {
// final prefs = await SharedPreferences.getInstance();
// int remainingTime = prefs.getInt('remainingTime') ?? 0;
// if (remainingTime > 0) {
// add(StartTimer(remainingTime));
// }
// }
