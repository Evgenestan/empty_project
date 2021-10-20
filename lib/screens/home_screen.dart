import 'package:empty_project/screens/camera_screen.dart';
import 'package:flutter/material.dart';

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
            child: const Text("Scan"),
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
