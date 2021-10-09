part of 'camera_bloc.dart';

abstract class CameraState extends Equatable {
  const CameraState();

  @override
  List<Object> get props => [];
}

class CameraInitial extends CameraState {}

class CameraReady extends CameraState {}

class CameraFailure extends CameraState {
  const CameraFailure({this.error = "CameraFailure"});

  final String error;

  @override
  List<Object> get props => [error];
}
