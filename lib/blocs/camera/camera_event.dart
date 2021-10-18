

import 'package:equatable/equatable.dart';

abstract class CameraEvent extends Equatable {
  const CameraEvent();

  @override
  List<Object> get props => [];
}

class CameraInitialized extends CameraEvent{}

class CameraStopped extends CameraEvent{}

class CameraCapturing extends CameraEvent{}