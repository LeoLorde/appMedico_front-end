import 'package:app_med/screens/doctor/doctor_configuration_screen.dart';
import 'package:app_med/screens/doctor/doctor_home_screen.dart';
import 'package:app_med/screens/doctor/doctor_notification_screen.dart';
import 'package:app_med/widgets/navbar.dart';
import 'package:flutter/material.dart';

class DoctorCalendarScreen extends StatefulWidget {
  @override
  State<DoctorCalendarScreen> createState() => _DoctorCalendarScreenState();
}

class _DoctorCalendarScreenState extends State<DoctorCalendarScreen> {
  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => DoctorHomeScreen()));
        break;
      case 1:
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => DoctorNotificationScreen()),
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => DoctorConfigurationScreen()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Navbar(
        selectedIndex: 1,
        onItemTapped: (index) => _onItemTapped(context, index),
      ),
    );
  }
}
