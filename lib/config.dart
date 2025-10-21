import 'package:app_med/screens/client/doctor_screen.dart';
import 'package:app_med/screens/client/home_screen.dart';
import 'package:app_med/screens/shared/init_screen.dart';
import 'package:app_med/utils/notification_navigation.dart';
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
    navigatorKey: navigatorKey,
    home: startScreen,
    debugShowCheckedModeBanner: false,
    theme: ThemeData(textTheme: GoogleFonts.interTextTheme()),
  );
}
