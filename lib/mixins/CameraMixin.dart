import 'dart:async';
import 'package:camera/camera.dart';
import 'package:empty_project/utils/camera_utils.dart';
import 'package:flutter/cupertino.dart';

mixin CameraMixin<T extends StatefulWidget>  on State<T> implements WidgetsBindingObserver {

  @protected
  abstract CameraController? cameraController;

  @override
  void initState() {
    super.initState();
    initCameraController();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive) {
      endImageStream();
    } else if (state == AppLifecycleState.resumed) {
      startImageStream();
    }
  }

  Future<void> initCameraController() async {
    cameraController = await CameraUtils.getCameraController();
    await cameraController?.initialize();
    if (mounted) {
      setState(() {

      });
    }
    startImageStream();
  }

  void startImageStream() {
    cameraController?.startImageStream((image) => onImage(image));
  }

  void endImageStream() {
    cameraController?.stopImageStream();
  }

  void onImage(CameraImage image);

  @override
  void dispose() {
    endImageStream();
    super.dispose();
  }
}