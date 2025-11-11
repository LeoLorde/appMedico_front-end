import 'package:app_med/models/appointment_model.dart';
import 'package:app_med/screens/doctor/doctor_calendar_screen.dart';
import 'package:app_med/screens/doctor/doctor_configuration_screen.dart';
import 'package:app_med/screens/doctor/doctor_notification_screen.dart';
import 'package:app_med/widgets/cards/schedule_card.dart';
import 'package:app_med/widgets/header/auth_black_app_bar.dart';
import 'package:app_med/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_med/connections/appointment/search_doc_appointment.dart';
import 'package:app_med/models/appointment_with_client.dart';
import 'package:app_med/connections/doctor/get_self_doctor.dart';
import 'package:intl/intl.dart';

class DoctorHomeScreen extends StatefulWidget {
  @override
  State<DoctorHomeScreen> createState() => _DoctorHomeScreenState();
}

class _DoctorHomeScreenState extends State<DoctorHomeScreen> {
  late Future<List<AppointmentWithClient>> futureAgendas;
  String? _username;

  @override
  void initState() {
    super.initState();
    _loadAgendas();
    _loadDoctorData();
  }

  Future<void> _loadDoctorData() async {
    final prefs = await SharedPreferences.getInstance();
    final storedToken = prefs.getString('access_token') ?? "";
    print(storedToken);
    try {
      final doctor = await getSelfDoctor(token: storedToken);
      print(doctor.toMap());
      setState(() {
        _username = doctor.username;
      });
    } catch (e) {
      print('Erro ao buscar dados do médico: $e');
      setState(() {
        _username = "Usuário";
      });
    }
  }

  Future<void> _loadAgendas() async {
    final prefs = await SharedPreferences.getInstance();
    final storedToken = prefs.getString('access_token') ?? "";
    setState(() {
      futureAgendas = fetchAgendas(storedToken);
    });
  }

  String _formatarData(dynamic dataMarcada) {
    try {
      if (dataMarcada == null) return 'Sem hora';
      DateTime data;

      if (dataMarcada is String) {
        data = DateTime.parse(dataMarcada);
      } else {
        return 'Sem hora';
      }
      return DateFormat('dd/MM - HH:mm', 'pt_BR').format(data);
    } catch (e) {
      print('Erro ao formatar data: $e');
      return 'Sem hora';
    }
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
        subtitle: _username ?? 'Carregando...',
        avatarImage: 'assets/images/user_icon.png',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: FutureBuilder<List<AppointmentWithClient>>(
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
                      final appt = item.appointment;
                      final client = item.client;
                      final horaFormatada = _formatarData(appt.dataMarcada.toString());

                      return ScheduleCard(
                        nome: client.username ?? 'Sem motivo',
                        tipo: appt.motivo ?? '',
                        hora: horaFormatada,
                        status: appt.isConfirmed.toString(),
                        imageUrl: "https://cdn-icons-png.flaticon.com/512/149/149071.png",
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
