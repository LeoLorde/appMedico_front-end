import 'package:app_med/screens/client/client_home_screen.dart';
import 'package:app_med/screens/client/client_notification_screen.dart';
import 'package:app_med/widgets/navbar.dart';
import 'package:flutter/material.dart';

class ClientCalendarScreen extends StatefulWidget {
  @override
  State<ClientCalendarScreen> createState() => _ClientCalendarScreenState();
}

class _ClientCalendarScreenState extends State<ClientCalendarScreen> {
  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ClientHomeScreen()));
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => ClientCalendarScreen()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => ClientNotificationScreen()),
        );
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
