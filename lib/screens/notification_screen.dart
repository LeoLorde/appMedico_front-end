import 'package:app_med/screens/calendar_screen.dart';
import 'package:app_med/screens/home_screen.dart';
import 'package:app_med/widgets/cards/notification_card.dart';
import 'package:app_med/widgets/header/auth_black_app_bar.dart';
import 'package:app_med/widgets/navbar.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
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
        title: 'Notificações',
        subtitle: 'Fique ligado',
        avatarImage: 'assets/images/logo.png',
      ),
      body: ListView(
        children: [
          SizedBox(height: 30),
          NotificationCard(
            icon: Icons.ios_share_rounded,
            title: 'Lembrete de Agendamento',
            subtitle: 'Seu agendamento com o Dr. Leonardo Reisdoefer é amanhã às 2:00 PM',
            time: '2 horas atras',
          ),
          NotificationCard(
            icon: Icons.ios_share_rounded,
            title: 'Lembrete de Agendamento',
            subtitle: 'Seu agendamento com o Dr. Leonardo Reisdoefer é amanhã às 2:00 PM',
            time: '2 horas atras',
          ),
          NotificationCard(
            icon: Icons.ios_share_rounded,
            title: 'Lembrete de Agendamento',
            subtitle: 'Seu agendamento com o Dr. Leonardo Reisdoefer é amanhã às 2:00 PM',
            time: '2 horas atras',
          ),
          NotificationCard(
            icon: Icons.ios_share_rounded,
            title: 'Lembrete de Agendamento',
            subtitle: 'Seu agendamento com o Dr. Leonardo Reisdoefer é amanhã às 2:00 PM',
            time: '2 horas atras',
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
