import 'package:MovieProject/screen/home_screen.dart';
import 'package:MovieProject/screen/parallax_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WiGa',
      home: ParallaxScreen(),
    );
  }
}
