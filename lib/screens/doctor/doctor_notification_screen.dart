import 'package:app_med/connections/confirm_appointment.dart';
import 'package:app_med/connections/pending_appointment.dart';
import 'package:app_med/connections/refused_appointment.dart';
import 'package:app_med/models/appointment_model.dart';
import 'package:flutter/material.dart';
import 'package:app_med/screens/doctor/doctor_calendar_screen.dart';
import 'package:app_med/screens/doctor/doctor_configuration_screen.dart';
import 'package:app_med/screens/doctor/doctor_home_screen.dart';
import 'package:app_med/widgets/cards/doctor_notification_card.dart';
import 'package:app_med/widgets/header/auth_black_app_bar.dart';
import 'package:app_med/widgets/navbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DoctorNotificationScreen extends StatefulWidget {
  @override
  State<DoctorNotificationScreen> createState() => _DoctorNotificationScreenState();
}

class _DoctorNotificationScreenState extends State<DoctorNotificationScreen> {
  String? token;
  late Future<List<AppointmentModel>> futureAppointments;

  @override
  void initState() {
    super.initState();
    _loadTokenAndFetchAppointments();
  }

  void _loadTokenAndFetchAppointments() async {
    final prefs = await SharedPreferences.getInstance();
    final storedToken = prefs.getString('access_token');
    setState(() {
      token = storedToken;
      futureAppointments = getAppointmentByDoctorPending(id: token ?? '');
    });
  }

  void _refreshAppointments() {
    setState(() {
      futureAppointments = getAppointmentByDoctorPending(id: token ?? '');
    });
  }

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
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (token == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AuthBlackAppBar(
        title: 'Solicitações',
        subtitle: 'Solicitações de consulta',
        avatarImage: 'assets/images/logo.png',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: FutureBuilder<List<AppointmentModel>>(
          future: futureAppointments,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return const Center(child: Text('Erro ao carregar solicitações'));
            }

            final notifications = snapshot.data ?? [];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${notifications.length} solicitações pendentes",
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: ListView.builder(
                    itemCount: notifications.length,
                    itemBuilder: (context, index) {
                      final notif = notifications[index];
                      print("----");
                      print(notif.dataMarcada);
                      print("----");
                      return DoctorNotificationCard(
                        nome: notif.isConfirmed ?? '',
                        data: notif.dataMarcada != null
                            ? '${notif.dataMarcada!.day.toString().padLeft(2, '0')}/${notif.dataMarcada!.month.toString().padLeft(2, '0')}, ${notif.dataMarcada!.hour.toString().padLeft(2, '0')}:${notif.dataMarcada!.minute.toString().padLeft(2, '0')}'
                            : '',
                        motivo: notif.motivo ?? '',
                        imageUrl: "assets/images/logo.png",
                        onAccept: () async {
                          final prefs = await SharedPreferences.getInstance();
                          final storedToken = prefs.getString('access_token') ?? "";
                          await confirmAppointment(id: notif.id!, token: storedToken);
                          _refreshAppointments(); // Atualiza lista sem recarregar a tela
                        },
                        onReject: () async {
                          final prefs = await SharedPreferences.getInstance();
                          final storedToken = prefs.getString('access_token') ?? "";
                          await refusedAppointment(id: notif.id!, token: storedToken);
                          _refreshAppointments(); // Atualiza lista sem recarregar a tela
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: Navbar(
        selectedIndex: 2,
        onItemTapped: (index) => _onItemTapped(context, index),
      ),
    );
  }
}
