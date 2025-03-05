part of 'developer_mode_detection_bloc.dart';

@immutable
sealed class DeveloperModeDetectionState {}

class DeveloperModeDetectionInitial extends DeveloperModeDetectionState {}

class DeveloperModeEnabled extends DeveloperModeDetectionState {}

class DeveloperModeDisabled extends DeveloperModeDetectionState {
  final bool isJailbroken;

  DeveloperModeDisabled({required this.isJailbroken});
}

class DeveloperModeDetectionFailure extends DeveloperModeDetectionState {
  final String error;

  DeveloperModeDetectionFailure(this.error);
}

