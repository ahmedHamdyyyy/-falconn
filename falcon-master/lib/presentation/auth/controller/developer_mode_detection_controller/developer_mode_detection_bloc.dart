
import 'package:falcon/core/core_exports.dart';
part 'developer_mode_detection_event.dart';
part 'developer_mode_detection_state.dart';

class DeveloperModeDetectionBloc extends Bloc<DeveloperModeDetectionEvent, DeveloperModeDetectionState> {
  DeveloperModeDetectionBloc() : super(DeveloperModeDetectionInitial()) {
    on<CheckDeviceStatus>(_onCheckDeviceStatus);
  }

  Future<void> _onCheckDeviceStatus(
      CheckDeviceStatus event, Emitter<DeveloperModeDetectionState> emit) async {
    try {
      bool jailbroken = await FlutterJailbreakDetection.jailbroken;
      bool developerMode = await FlutterJailbreakDetection.developerMode;

      if (developerMode) {
        emit(DeveloperModeEnabled());
      } else {
        emit(DeveloperModeDisabled(isJailbroken: jailbroken));
      }
    } catch (e) {
      emit(DeveloperModeDetectionFailure('Failed to check device status.'));
    }
  }
}