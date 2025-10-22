import 'package:app_med/screens/client/client_calendar_screen.dart';
import 'package:app_med/screens/client/client_configuration_screen.dart';
import 'package:app_med/screens/client/client_notification_screen.dart';
import 'package:app_med/screens/client/search_doctor/search_doctor_screen.dart';
import 'package:app_med/widgets/header/home_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:app_med/widgets/navbar.dart';

class ClientHomeScreen extends StatefulWidget {
  @override
  State<ClientHomeScreen> createState() => _ClientHomeScreenState();
}

class _ClientHomeScreenState extends State<ClientHomeScreen> {
  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
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
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => ClientConfigurationScreen()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: HomeAppBar(
        greeting: 'Bom dia!',
        userName: 'Maurício Reisdoefer',
        avatarImage: 'assets/images/logo.png',
        onSearchTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => SearchDoctorScreen()));
        },
      ),
      bottomNavigationBar: Navbar(
        selectedIndex: 0,
        onItemTapped: (index) => _onItemTapped(context, index),
      ),
    );
  }
}
