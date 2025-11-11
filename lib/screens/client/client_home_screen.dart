import 'package:app_med/connections/appointment/client_appointment.dart';
import 'package:app_med/connections/client/get_self_client.dart';
import 'package:app_med/models/appointment_model.dart';
import 'package:app_med/screens/client/client_calendar_screen.dart';
import 'package:app_med/screens/client/client_configuration_screen.dart';
import 'package:app_med/screens/client/client_notification_screen.dart';
import 'package:app_med/screens/client/search_doctor/search_doctor_screen.dart';
import 'package:app_med/widgets/cards/doctor_card.dart';
import 'package:app_med/widgets/header/home_app_bar.dart';
import 'package:app_med/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClientHomeScreen extends StatefulWidget {
  @override
  State<ClientHomeScreen> createState() => _ClientHomeScreenState();
}

class _ClientHomeScreenState extends State<ClientHomeScreen> {
  String? _username;

  @override
  void initState() {
    super.initState();
    _loadClientData();
  }

  Future<void> _loadClientData() async {
    final prefs = await SharedPreferences.getInstance();
    final storedToken = prefs.getString('access_token') ?? "";

    try {
      final client = await getSelfClient(token: storedToken);
      setState(() {
        _username = client.username;
      });
    } catch (e) {
      print('Erro ao buscar dados do cliente: $e');
      setState(() {
        _username = "Usuário";
      });
    }
  }

  Future<List<AppointmentModel>> fetchAppointments() async {
    final prefs = await SharedPreferences.getInstance();
    final storedToken = prefs.getString('access_token') ?? "";
    return await getAppointmentByClient(token: storedToken);
  }

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
        userName: _username ?? "Carregando...",
        avatarImage: 'assets/images/user_icon.png',
        onSearchTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => SearchDoctorScreen()));
        },
      ),
      body: FutureBuilder<List<AppointmentModel>>(
        future: fetchAppointments(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar consultas'));
          }

          final appointments = snapshot.data ?? [];
          if (appointments.isEmpty) {
            return const Center(child: Text('Nenhuma consulta marcada ainda.'));
          }

          return ListView.builder(
            itemCount: appointments.length,
            itemBuilder: (context, index) {
              final appt = appointments[index];
              return DoctorCard(
                doctor: appt.doctor!,
                imageUrl: 'assets/images/logo.png',
                hour:
                    '${appt.dataMarcada?.hour.toString().padLeft(2, '0')}:${appt.dataMarcada?.minute.toString().padLeft(2, '0')}',
                day: '${appt.dataMarcada?.day}/${appt.dataMarcada?.month}',
              );
            },
          );
        },
      ),
      bottomNavigationBar: Navbar(
        selectedIndex: 0,
        onItemTapped: (index) => _onItemTapped(context, index),
      ),
    );
  }
}
