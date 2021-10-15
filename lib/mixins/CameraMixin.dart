import 'package:camera/camera.dart';
import 'package:empty_project/blocs/camera/camera_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/camera/camera_bloc.dart';

mixin CameraMixin<T extends StatefulWidget> on State<T> {

  //late final CameraController? _cameraController;

  @override
  void initState() {
    super.initState();
    // if (T is CameraReady) {
    //   _cameraController = (T as CameraReady).controller;
    // }
  }

  Future<void> getImage(CameraController controller) async => onImage(await controller.takePicture());

  @override
  void dispose() {
    //_cameraController?.dispose();
    super.dispose();
  }

  void onImage(XFile file);
}