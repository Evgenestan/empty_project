

import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';

abstract class CameraState extends Equatable {
  const CameraState();

  @override
  List<Object> get props => [];
}

class CameraInitial extends CameraState {}

class CameraReady extends CameraState {
}

class CameraFailure extends CameraState {
  const CameraFailure({this.error = "CameraFailure"});

  final String error;

  @override
  List<Object> get props => [error];
}

class CameraCaptureInProgress extends CameraState {
  CameraCaptureInProgress();

  XFile? file = null;
}

class CameraCaptureSuccess extends CameraState {
  const CameraCaptureSuccess(this.url);

  final String url;
}

class CameraCaptureFailure extends CameraState {
  const CameraCaptureFailure({this.error = "CameraFailure"});

  final String error;

  @override
  List<Object> get props => [error];
}