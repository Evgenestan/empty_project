import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import 'widgets/cameraWidget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Scanner'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          onFABPressed(context);
        },
        child: const Icon(Icons.qr_code),
      ),
    );
  }

  Future<void> onFABPressed(BuildContext context) async {
    final camera = await _getCamera();
    Navigator.push(
        context,
        MaterialPageRoute<void>(
            builder: (context) => CameraWidget(camera: camera)));
  }

  Future<CameraDescription> _getCamera() async {
    final cameras = await availableCameras();
    return await cameras.first;
  }
}
