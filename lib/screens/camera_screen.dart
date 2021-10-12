import 'package:camera/camera.dart';
import 'package:empty_project/blocs/camera/camera_bloc.dart';
import 'package:empty_project/blocs/camera/camera_event.dart';
import 'package:empty_project/blocs/camera/camera_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> with WidgetsBindingObserver {

  late final CameraBloc _cameraBloc;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    _cameraBloc = CameraBloc();
    _cameraBloc.add(CameraInitialized());
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_cameraBloc.state != CameraReady) {
      return;
    }

    if (state == AppLifecycleState.paused) {
      _cameraBloc.add(CameraStopped());
    } else if (state == AppLifecycleState.resumed) {
      _cameraBloc.add(CameraInitialized());
    }
  }

  @override
  Widget build(BuildContext context) => BlocConsumer<CameraBloc, CameraState>(
    bloc: _cameraBloc,
      listener: (context, state) {
        if (state is CameraCaptureSuccess) {
          //move to documentation from QR
        } else if (state is CameraCaptureFailure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      builder: (context, state) => Scaffold(
          body: state is CameraReady
              ? CameraPreview(state.controller!)
              : const Center(
              child: CircularProgressIndicator()
          )
      )
  );
}

