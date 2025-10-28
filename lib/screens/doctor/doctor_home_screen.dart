import 'package:app_med/models/appointment_model.dart';
import 'package:app_med/screens/doctor/doctor_calendar_screen.dart';
import 'package:app_med/screens/doctor/doctor_configuration_screen.dart';
import 'package:app_med/screens/doctor/doctor_notification_screen.dart';
import 'package:app_med/widgets/cards/schedule_card.dart';
import 'package:app_med/widgets/header/auth_black_app_bar.dart';
import 'package:app_med/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_med/connections/search_doc_appointment.dart';

class DoctorHomeScreen extends StatefulWidget {
  @override
  State<DoctorHomeScreen> createState() => _DoctorHomeScreenState();
}

class _DoctorHomeScreenState extends State<DoctorHomeScreen> {
  late Future<List<AppointmentModel>> futureAgendas;

  @override
  void initState() {
    super.initState();
    _loadAgendas(); // 👈 chama a função async aqui
  }

  Future<void> _loadAgendas() async {
    final prefs = await SharedPreferences.getInstance();
    final storedToken = prefs.getString('access_token') ?? "";
    setState(() {
      futureAgendas = fetchAgendas(storedToken);
    });
  }

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
        child: FutureBuilder<List<AppointmentModel>>(
          future: futureAgendas,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return const Center(child: Text('Erro ao carregar agendas'));
            }

            final agendas = snapshot.data ?? [];

            if (agendas.isEmpty) {
              return const Center(child: Text('Nenhuma agenda para hoje'));
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Agendas Hoje",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: ListView.builder(
                    itemCount: agendas.length,
                    itemBuilder: (context, index) {
                      final item = agendas[index];
                      final data = item.toMap();

                      return ScheduleCard(
                        nome: data["motivo"] ?? '',
                        tipo: data["client_id"] ?? '',
                        hora: data["data_marcada"]?.toString() ?? '',
                        status: data["is_confirmed"]?.toString() ?? '',
                        imageUrl: "assets/images/logo.png",
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
        selectedIndex: 0,
        onItemTapped: (index) => _onItemTapped(context, index),
      ),
    );
  }
}
