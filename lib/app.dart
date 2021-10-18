import 'package:empty_project/screens/home_screen.dart';
import 'package:flutter/material.dart';

class App extends MaterialApp{
  App({Key? key}) : super(key: key, debugShowCheckedModeBanner:false, theme: ThemeData.dark(), home: const HomeScreen());
}
