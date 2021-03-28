
import 'package:flutter/material.dart';
import 'package:vegetable_app/Screens/home5.dart';
//import 'package:vegetable_app/Screens/new.dart';
import 'package:vegetable_app/Screens/splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes:{
        '/home':(_) => HomeScreen(),
      },

      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
    );
  }
}




