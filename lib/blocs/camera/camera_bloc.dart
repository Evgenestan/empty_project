import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'camera_utils.dart';

part 'camera_event.dart';
part 'camera_state.dart';

class CameraBloc extends Bloc<CameraEvent, CameraState> {
  CameraBloc({
    required this.cameraUtils,
    this.resolutionPreset = ResolutionPreset.low,
    this.cameraLensDirection = CameraLensDirection.back,
  }) : super(CameraInitial());

  final CameraUtils cameraUtils;
  final ResolutionPreset resolutionPreset;
  final CameraLensDirection cameraLensDirection;

  CameraController? _controller;

  CameraController getController() => _controller!;

  bool isInitialized() => _controller?.value.isInitialized ?? false;

  @override
  Stream<CameraState> mapEventToState(
    CameraEvent event,
  ) async* {
    if (event is CameraInitialized)
      yield* _mapCameraInitializedToState(event);
    else if (event is CameraStopped) yield* _mapCameraStoppedToState(event);
  }

  Stream<CameraState> _mapCameraInitializedToState(
      CameraInitialized event) async* {
    try {
      _controller = await cameraUtils.getCameraController(
          resolutionPreset, cameraLensDirection);
      await _controller!.initialize();
      yield CameraReady();
    } on CameraException catch (error) {
      _controller?.dispose();
      yield CameraFailure(error: error.description!);
    } catch (error) {
      yield CameraFailure(error: error.toString());
    }
  }

  Stream<CameraState> _mapCameraStoppedToState(CameraStopped event) async* {
    _controller?.dispose();
    yield CameraInitial();
  }

  @override
  Future<void> close() {
    _controller?.dispose();
    return super.close();
  }
}
