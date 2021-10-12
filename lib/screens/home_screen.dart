import 'package:empty_project/blocs/camera/camera_bloc.dart';
import 'package:empty_project/blocs/camera/camera_event.dart';
import 'package:empty_project/screens/camera_screen.dart';
import 'package:empty_project/utils/camera_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
              /*Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                      builder: (_) => BlocProvider(
                            create: (_) => CameraBloc(),
                            child: const CameraScreen(),
                          )
                  )
              );*/
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (_) => const CameraScreen()
                )
              );
            },
          ),
        )
    );
  }
}
