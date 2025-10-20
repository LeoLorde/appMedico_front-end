import 'package:app_med/screens/doctor_screen.dart';
import 'package:app_med/screens/home_screen.dart';
import 'package:app_med/screens/init_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget configApp({bool developing = false, bool testing = false}) {
  Widget startScreen;

  if (developing) {
    startScreen = HomeScreen();
  } else if (testing) {
    startScreen = InitScreen();
  } else {
    startScreen = DoctorScreen();
  }

  return MaterialApp(
    home: startScreen,
    debugShowCheckedModeBanner: false,
    theme: ThemeData(textTheme: GoogleFonts.interTextTheme()),
  );
}
