import 'package:app_med/screens/client/calendar_screen.dart';
import 'package:app_med/screens/client/home_screen.dart';

import 'package:app_med/widgets/header/auth_black_app_bar.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConfigurationScreen extends StatefulWidget {
  @override
  State<ConfigurationScreen> createState() => _ConfigurationScreenState();
}

class _ConfigurationScreenState extends State<ConfigurationScreen> {
  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
        break;
      case 1:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => CalendarScreen()));
        break;
      case 2:
        break;
      case 3:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AuthBlackAppBar(
        title: 'Configurações',
        subtitle: 'Gerencie sua conta',
        avatarImage: 'assets/images/logo.png',
      ),
      body: Column(
        children: [
          CircleAvatar(radius: 35, backgroundImage: AssetImage('assests/images/logo.png')),
          const SizedBox(height: 10),
          Text(
            'Mauricio Reisdoefer',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          Text(
            'paciente@gmal.com',
            style: GoogleFonts.inter(fontSize: 13, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}
