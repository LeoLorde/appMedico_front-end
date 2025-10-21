import 'package:app_med/screens/client/calendar_screen.dart';
import 'package:app_med/screens/shared/notification_screen.dart';
import 'package:app_med/screens/client/search_doctor_screen.dart';
import 'package:app_med/widgets/header/home_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:app_med/widgets/navbar.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        break;
      case 1:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => CalendarScreen()));
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
