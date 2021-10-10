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

class _CameraScreenState extends State<CameraScreen> {

  void didChangeAppLifecycleState(AppLifecycleState state) {
    final bloc = BlocProvider.of<CameraBloc>(context);

    if (!bloc.isInitialized()) {
      return;
    }

    if (state == AppLifecycleState.inactive)
      bloc.add(CameraStopped());
    else if (state == AppLifecycleState.resumed) {
      bloc.add(CameraInitialized());
    }
  }


  @override
  Widget build(BuildContext context) => BlocConsumer<CameraBloc, CameraState>(
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
              ? CameraPreview(
              BlocProvider.of<CameraBloc>(context).getController())
              : const Center(
              child: CircularProgressIndicator()
          )
      )
  );
}

