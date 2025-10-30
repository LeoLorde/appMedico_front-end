import 'package:app_med/models/client_model.dart';
import 'package:app_med/models/doctor_model.dart';
import 'package:app_med/screens/client/client_home_screen.dart';
import 'package:app_med/screens/client/edit_client_profile.dart';
import 'package:app_med/screens/doctor/doctor_login/finish_profile_screen.dart';
import 'package:app_med/screens/doctor/edit_doctor_profile.dart';
import 'package:app_med/screens/shared/init_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget configApp({bool developing = false, bool testing = false}) {
  Widget startScreen;

  if (developing) {
    startScreen = ClientHomeScreen();
  } else if (testing) {
    startScreen = InitScreen();
  } else {
    startScreen = ClientHomeScreen();
  }

  return MaterialApp(
    home: startScreen,
    debugShowCheckedModeBanner: false,
    theme: ThemeData(textTheme: GoogleFonts.interTextTheme()),
  );
}
