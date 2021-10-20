import 'dart:async';

import 'package:camera/camera.dart';
import 'package:empty_project/blocs/camera/camera_bloc.dart';
import 'package:empty_project/blocs/camera/camera_event.dart';
import 'package:empty_project/blocs/camera/camera_state.dart';
import 'package:empty_project/utils/snackbar_utils.dart';
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

  @override
  CameraController? cameraController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    _cameraBloc = CameraBloc();
    _cameraBloc.add(CameraInitialized());
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!cameraController!.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
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
        } else if (state is CameraCaptureFailure) {
          SnackBarUtils.showSnackBar(state.error, context);
        }
      },
      builder: (context, state) => Scaffold(
          body: (state is CameraReady || state is CameraCaptureInProgress)
              ? CameraPreview(cameraController!)
              : const Center(child: CircularProgressIndicator())));

  @override
  void onImage(CameraImage image) {
    // TODO: implement onImage
  }



  // void setTimer() {
  //   _timer = Timer.periodic(const Duration(milliseconds: 1000), (Timer t) => getImage(_cameraController));
  // }
}
