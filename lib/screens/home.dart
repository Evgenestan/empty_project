import 'package:camera/camera.dart';
import 'package:empty_project/screens/scan.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("QR scanner"),
          centerTitle: true,
        ),
        body: Center(
          child: ElevatedButton(
            child: Text("Scan"),
            onPressed: () {
              onScanButtonPressed(context);
            },
          ),
        ));
  }

  Future<void> onScanButtonPressed(BuildContext context) async {
    final camera = await _getCamera();

    Navigator.push(
        context,
        MaterialPageRoute<void>(builder: (context) => ScanScreen(camera: camera))
    );
  }

  Future<CameraDescription> _getCamera() async {
    WidgetsFlutterBinding.ensureInitialized();
    final cameras = await availableCameras();

    print(cameras);

    return await cameras.first;
  }
}
