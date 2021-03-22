import 'package:flutter/material.dart';
import 'package:vegetable_app/Screens/home.dart';
import 'package:vegetable_app/Screens/splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes:{
        '/home':(_) => Vegetable(),
      },
    );
  }
}
