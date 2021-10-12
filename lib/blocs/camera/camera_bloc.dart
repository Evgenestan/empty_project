import 'package:camera/camera.dart';
import 'package:empty_project/blocs/camera/camera_event.dart';
import 'package:empty_project/blocs/camera/camera_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utils/camera_utils.dart';

class CameraBloc extends Bloc<CameraEvent, CameraState> {
  CameraBloc() : super(CameraInitial());

  CameraController? _controller;

  bool isInitialized() => _controller?.value.isInitialized ?? false;

  @override
  Stream<CameraState> mapEventToState(
      CameraEvent event,
      ) async* {
    if (event is CameraInitialized)
      yield* _mapCameraInitializedToState(event);
    else if (event is CameraCaptured)
      yield* _mapCameraCapturedToState(event);
    else if (event is CameraStopped) {
      yield* _mapCameraStoppedToState(event);
    }
  }

  Stream<CameraState> _mapCameraInitializedToState(CameraInitialized event) async* {
    try {
      _controller = await CameraUtils.getCameraController();
      await _controller!.initialize();
      yield CameraReady(_controller);
    } on CameraException catch (error) {
      _controller?.dispose();
      yield CameraFailure(error: error.description!);
    } catch (error) {
      yield CameraFailure(error: error.toString());
    }
  }

  Stream<CameraState> _mapCameraCapturedToState(CameraCaptured event) async* {
    if(state is CameraReady){
      yield CameraCaptureInProgress();
      try {
        //scan qr code
      } on CameraException catch (error) {
        yield CameraCaptureFailure(error: error.description!);
      }
    }
  }

  Stream<CameraState> _mapCameraStoppedToState(CameraStopped event) async* {
    _controller?.dispose();
    print("==============================================================================");
    yield CameraInitial();
  }
}
