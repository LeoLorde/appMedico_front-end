import 'package:app_med/screens/client/search_doctor/doctor_screen.dart';
import 'package:app_med/screens/client/client_home_screen.dart';
import 'package:app_med/screens/doctor/doctor_home_screen.dart';
import 'package:app_med/screens/shared/init_screen.dart';
import 'package:app_med/screens/client/client_notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget configApp({bool developing = false, bool testing = false}) {
  Widget startScreen;

  if (developing) {
    startScreen = ClientHomeScreen();
  } else if (testing) {
    startScreen = InitScreen();
  } else {
    startScreen = InitScreen();
  }

  return MaterialApp(
    home: startScreen,
    debugShowCheckedModeBanner: false,
    theme: ThemeData(textTheme: GoogleFonts.interTextTheme()),
  );
}
