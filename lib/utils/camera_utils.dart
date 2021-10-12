import 'package:camera/camera.dart';

class CameraUtils {
  static Future<CameraController> getCameraController() async {
    final cameras = await availableCameras();
    final camera = cameras
        .firstWhere((camera) => camera.lensDirection == CameraLensDirection.back);

    return CameraController(camera, ResolutionPreset.medium);
  }
}