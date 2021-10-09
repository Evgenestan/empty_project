import 'package:flutter/material.dart';
import 'screens/homeScreen/home_screen.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Basis',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen());
  }
}
