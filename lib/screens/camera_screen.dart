import 'dart:async';

import 'package:camera/camera.dart';
import 'package:empty_project/blocs/camera/camera_bloc.dart';
import 'package:empty_project/blocs/camera/camera_event.dart';
import 'package:empty_project/blocs/camera/camera_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../mixins/CameraMixin.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> with WidgetsBindingObserver, CameraMixin {
  late final CameraBloc _cameraBloc;
  late final CameraController _cameraController;
  late final Timer _timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    _cameraBloc = CameraBloc();
    _cameraBloc.add(CameraInitialized());
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!(_cameraBloc.state is CameraReady)) {
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
        if (state is CameraReady) {
          _cameraController = state.controller!;
          _timer = Timer.periodic(const Duration(milliseconds: 1000), (Timer t) => getImage(_cameraController));
        } else if (state is CameraCaptureFailure) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      builder: (context, state) => Scaffold(
          body: (state is CameraReady || state is CameraCaptureInProgress)
              ? CameraPreview(_cameraController)
              : const Center(child: CircularProgressIndicator())));

  @override
  void onImage(XFile file) {
    if (_cameraBloc.state is CameraReady) {
      _cameraBloc.add(CameraCapturing());
    }
    else if (_cameraBloc.state is CameraCaptureInProgress) {
      (_cameraBloc.state as CameraCaptureInProgress).file = file;
    }
  }
}
