import 'dart:async';
import 'package:empty_project/blocs/camera/camera_bloc.dart';
import 'package:empty_project/blocs/camera/camera_utils.dart';
import 'package:empty_project/screens/homeScreen/widgets/camera_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _openCameraPreview(context);
        },
        child: const Icon(Icons.qr_code),
      ),
    );
  }

  Future<void> _openCameraPreview(BuildContext context) async {
    Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (_) => BlocProvider(
            create: (_) => CameraBloc(cameraUtils: CameraUtils())
              ..add(CameraInitialized()),
            child: CameraScreen(),
          ),
        ));
  }
}
