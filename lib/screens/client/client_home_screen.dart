import 'package:app_med/connections/client_appointment.dart';
import 'package:app_med/models/appointment_model.dart';
import 'package:app_med/models/doctor_model.dart';
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
  Future<List<AppointmentModel>> fetchAppointments() async {
    final prefs = await SharedPreferences.getInstance();
    final storedToken = prefs.getString('access_token') ?? "";
    return await getAppointmentByClient(id: storedToken);
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
        userName: 'Maurício Reisdoefer',
        avatarImage: 'assets/images/logo.png',
        onSearchTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => SearchDoctorScreen()));
        },
      ),
      body: FutureBuilder<List<AppointmentModel>>(
        future: fetchAppointments(),
        builder: (context, snapshot) {
          // 🔄 Enquanto carrega
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar consultas 😅'));
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
                doctor: DoctorModel(), // tu pode passar o modelo real do doutor depois
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
