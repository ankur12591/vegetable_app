import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splash();
  }

  Future<Timer> splash() async {
    return Timer(Duration(seconds: 8), onDoneLoading);
  }

  onDoneLoading () {
    Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              child: Image.asset("assets/123.png"),
            ),

          ],
        ),
      ),
    );
  }
}









