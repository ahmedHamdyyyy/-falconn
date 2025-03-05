part of 'developer_mode_detection_bloc.dart';

@immutable
sealed class DeveloperModeDetectionEvent {}

class CheckDeviceStatus extends DeveloperModeDetectionEvent {}