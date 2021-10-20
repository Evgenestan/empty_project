import 'package:camera/camera.dart';
import 'package:empty_project/blocs/camera/camera_event.dart';
import 'package:empty_project/blocs/camera/camera_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/camera_utils.dart';

class CameraBloc extends Bloc<CameraEvent, CameraState> {
  CameraBloc() : super(CameraInitial());


  @override
  Stream<CameraState> mapEventToState(CameraEvent event) async* {
    if (event is CameraInitialized)
      yield* _mapCameraInitializedToState(event);
    else if (event is CameraCapturing)
      yield* _mapCameraCapturedToState(event);
    else if (event is CameraStopped) {
      yield* _mapCameraStoppedToState(event);
    }
  }

  Stream<CameraState> _mapCameraInitializedToState(CameraInitialized event) async* {
    try {
      yield CameraReady();
    } on CameraException catch (error) {
      yield CameraFailure(error: error.description!);
    } catch (error) {
      yield CameraFailure(error: error.toString());
    }
  }

  Stream<CameraState> _mapCameraCapturedToState(CameraCapturing event) async* {
    if (state is CameraReady) {
      yield CameraCaptureInProgress();
      try {
        //scan qr code
      } on CameraException catch (error) {
        yield CameraCaptureFailure(error: error.description!);
      }
    }
  }

  Stream<CameraState> _mapCameraStoppedToState(CameraStopped event) async* {
    yield CameraInitial();
  }
}
