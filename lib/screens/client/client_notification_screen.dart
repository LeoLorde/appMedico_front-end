import 'package:app_med/screens/client/client_calendar_screen.dart';
import 'package:app_med/screens/client/client_configuration_screen.dart';
import 'package:app_med/screens/client/client_home_screen.dart';
import 'package:app_med/widgets/cards/client_notification_card.dart';
import 'package:app_med/widgets/header/auth_black_app_bar.dart';
import 'package:app_med/widgets/navbar.dart';
import 'package:flutter/material.dart';

class ClientNotificationScreen extends StatefulWidget {
  @override
  State<ClientNotificationScreen> createState() => _ClientNotificationScreenState();
}

class _ClientNotificationScreenState extends State<ClientNotificationScreen> {
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
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => ClientConfigurationScreen()),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AuthBlackAppBar(
        title: 'Notificações',
        subtitle: 'Fique ligado',
        avatarImage: 'assets/images/logo.png',
      ),
      body: ListView(
        children: [
          NotificationCard(
            icon: Icons.ios_share_outlined,
            title: 'Lembrete de Agendamento',
            subtitle: 'Seu agendamento com o Dr. Leonardo Reisdoefer é amanhã às 2:00 PM',
            time: '2 horas atrás',
          ),
          NotificationCard(
            icon: Icons.ios_share_outlined,
            title: 'Lembrete de Agendamento',
            subtitle: 'Seu agendamento com o Dr. Leonardo Reisdoefer é amanhã às 2:00 PM',
            time: '2 horas atrás',
          ),
          NotificationCard(
            icon: Icons.ios_share_outlined,
            title: 'Lembrete de Agendamento',
            subtitle: 'Seu agendamento com o Dr. Leonardo Reisdoefer é amanhã às 2:00 PM',
            time: '2 horas atrás',
          ),
          NotificationCard(
            icon: Icons.ios_share_outlined,
            title: 'Lembrete de Agendamento',
            subtitle: 'Seu agendamento com o Dr. Leonardo Reisdoefer é amanhã às 2:00 PM',
            time: '2 horas atrás',
          ),
          NotificationCard(
            icon: Icons.ios_share_outlined,
            title: 'Lembrete de Agendamento',
            subtitle: 'Seu agendamento com o Dr. Leonardo Reisdoefer é amanhã às 2:00 PM',
            time: '2 horas atrás',
          ),
        ],
      ),
      bottomNavigationBar: Navbar(
        selectedIndex: 2,
        onItemTapped: (index) => _onItemTapped(context, index),
      ),
    );
  }
}
