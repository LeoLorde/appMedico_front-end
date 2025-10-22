import 'package:app_med/screens/doctor/doctor_calendar_screen.dart';
import 'package:app_med/screens/doctor/doctor_configuration_screen.dart';
import 'package:app_med/screens/doctor/doctor_notification_screen.dart';
import 'package:app_med/widgets/cards/schedule_card.dart';
import 'package:app_med/widgets/header/auth_black_app_bar.dart';
import 'package:app_med/widgets/header/home_app_bar.dart';
import 'package:app_med/widgets/navbar.dart';
import 'package:flutter/material.dart';

class DoctorHomeScreen extends StatefulWidget {
  @override
  State<DoctorHomeScreen> createState() => _DoctorHomeScreenState();
}

class _DoctorHomeScreenState extends State<DoctorHomeScreen> {
  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => DoctorCalendarScreen()),
        );
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

  final agendas = [
    {
      "nome": "Maurício Reisdoefer",
      "tipo": "Consulta",
      "hora": "6:00 AM",
      "status": "confirmada",
      "foto": "https://i.pravatar.cc/150?img=3",
    },
    {
      "nome": "Maurício Reisdoefer",
      "tipo": "Consulta",
      "hora": "7:00 AM",
      "status": "confirmada",
      "foto": "https://i.pravatar.cc/150?img=4",
    },
    {
      "nome": "Maurício Reisdoefer",
      "tipo": "Consulta",
      "hora": "11:30 AM",
      "status": "pendente",
      "foto": "https://i.pravatar.cc/150?img=5",
    },
    {
      "nome": "Maurício Reisdoefer",
      "tipo": "Consulta",
      "hora": "11:30 AM",
      "status": "pendente",
      "foto": "https://i.pravatar.cc/150?img=6",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AuthBlackAppBar(
        title: 'Bom dia!',
        subtitle: 'Luísio de Azevedo',
        avatarImage: 'assets/images/logo.png',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Agendas Hoje", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: agendas.length,
                itemBuilder: (context, index) {
                  final item = agendas[index];
                  return ScheduleCard(
                    nome: item["nome"]!,
                    tipo: item["tipo"]!,
                    hora: item["hora"]!,
                    status: item["status"]!,
                    imageUrl: item["foto"]!,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Navbar(
        selectedIndex: 0,
        onItemTapped: (index) => _onItemTapped(context, index),
      ),
    );
  }
}
