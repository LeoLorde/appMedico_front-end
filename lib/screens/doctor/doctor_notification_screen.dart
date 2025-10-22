import 'package:app_med/screens/client/client_calendar_screen.dart';
import 'package:app_med/screens/client/client_configuration_screen.dart';
import 'package:app_med/screens/client/client_home_screen.dart';
import 'package:app_med/screens/doctor/doctor_calendar_screen.dart';
import 'package:app_med/screens/doctor/doctor_configuration_screen.dart';
import 'package:app_med/screens/doctor/doctor_home_screen.dart';
import 'package:app_med/widgets/cards/client_notification_card.dart';
import 'package:app_med/widgets/cards/doctor_notification_card.dart';
import 'package:app_med/widgets/header/auth_black_app_bar.dart';
import 'package:app_med/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DoctorNotificationScreen extends StatefulWidget {
  @override
  State<DoctorNotificationScreen> createState() => _DoctorNotificationScreenState();
}

class _DoctorNotificationScreenState extends State<DoctorNotificationScreen> {
  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => DoctorHomeScreen()));
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => DoctorCalendarScreen()),
        );
        break;
      case 2:
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => DoctorConfigurationScreen()),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AuthBlackAppBar(
        title: 'Solicitações',
        subtitle: 'Solicitações de consulta',
        avatarImage: 'assets/images/logo.png',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
                children: [
                  const Text(
                    "05 solicitações pendentes",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  DoctorNotificationCard(
                    nome: "Ana Souza",
                    data: "Ter 15, 10:00 AM",
                    motivo: "Exame de rotina",
                    imageUrl: "assets/images/logo.png",
                    onAccept: () => {},
                    onReject: () => {},
                  ),
                  DoctorNotificationCard(
                    nome: "Ana Souza",
                    data: "Ter 15, 10:00 AM",
                    motivo: "Exame de rotina",
                    imageUrl: "assets/images/logo.png",
                    onAccept: () => {},
                    onReject: () => {},
                  ),
                  DoctorNotificationCard(
                    nome: "Ana Souza",
                    data: "Ter 15, 10:00 AM",
                    motivo: "Exame de rotina",
                    imageUrl: "assets/images/logo.png",
                    onAccept: () => {},
                    onReject: () => {},
                  ),
                  DoctorNotificationCard(
                    nome: "Ana Souza",
                    data: "Ter 15, 10:00 AM",
                    motivo: "Exame de rotina",
                    imageUrl: "assets/images/logo.png",
                    onAccept: () => {},
                    onReject: () => {},
                  ),
                  DoctorNotificationCard(
                    nome: "Ana Souza",
                    data: "Ter 15, 10:00 AM",
                    motivo: "Exame de rotina",
                    imageUrl: "assets/images/logo.png",
                    onAccept: () => {},
                    onReject: () => {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Navbar(
        selectedIndex: 2,
        onItemTapped: (index) => _onItemTapped(context, index),
      ),
    );
  }
}
