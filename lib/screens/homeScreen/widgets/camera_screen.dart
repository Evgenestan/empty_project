import 'package:camera/camera.dart';
import 'package:empty_project/blocs/camera/camera_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final bloc = BlocProvider.of<CameraBloc>(context);

    // App state changed before we got the chance to initialize.
    if (!bloc.isInitialized()) return;
    if (state == AppLifecycleState.inactive)
      bloc.add(CameraStopped());
    else if (state == AppLifecycleState.resumed) bloc.add(CameraInitialized());
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<CameraBloc, CameraState>(
      builder: (_, state) => Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(title: const Text("QR Scanner")),
            body: state is CameraReady
                ? Container(
                    height: MediaQuery.of(context).size.height,
                    child: CameraPreview(
                        BlocProvider.of<CameraBloc>(context).getController()))
                : Center(
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.1,
                        height: MediaQuery.of(context).size.width * 0.1,
                        child: const CircularProgressIndicator()),
                  ),
            floatingActionButton: state is CameraReady
                //Действие с QR кодом по кнопке?
                ? FloatingActionButton(
                    onPressed: () => () {},
                    child: const Icon(Icons.qr_code_outlined))
                : Container(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          ));
}
