import 'package:app_med/screens/client/home_screen.dart';
import 'package:app_med/screens/shared/notification_screen.dart';
import 'package:app_med/widgets/navbar.dart';
import 'package:flutter/material.dart';

class CalendarScreen extends StatefulWidget {
  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
        break;
      case 1:
        break;
      case 2:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => NotificationScreen()));
        break;
      case 3:
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
