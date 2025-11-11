import 'package:app_med/connections/appointment/search_appointment_by_day.dart';
import 'package:app_med/models/appointment_model.dart';
import 'package:app_med/screens/client/client_configuration_screen.dart';
import 'package:app_med/screens/client/client_home_screen.dart';
import 'package:app_med/screens/client/client_notification_screen.dart';
import 'package:app_med/widgets/cards/appointment_card.dart';
import 'package:app_med/widgets/header/auth_black_app_bar.dart';
import 'package:app_med/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class ClientCalendarScreen extends StatefulWidget {
  @override
  State<ClientCalendarScreen> createState() => _ClientCalendarScreenState();
}

class _ClientCalendarScreenState extends State<ClientCalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  String? _token;
  Future<List<AppointmentModel>>? _appointmentsFuture;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _loadTokenAndFetchAppointments(_selectedDay!);
  }

  Future<void> _loadTokenAndFetchAppointments(DateTime day) async {
    final prefs = await SharedPreferences.getInstance();
    final storedToken = prefs.getString('access_token');

    if (storedToken == null) {
      print("⚠️ Nenhum token encontrado — talvez o usuário não esteja logado?");
      return;
    }

    setState(() {
      _token = storedToken;
    });

    _fetchAppointmentsForDay(day);
  }

  void _fetchAppointmentsForDay(DateTime day) {
    if (_token == null) return;

    final formattedDay = DateFormat('yyyy-MM-dd').format(day);
    setState(() {
      _appointmentsFuture = getAppointmentByDay(day: formattedDay, id: _token!);
    });
  }

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ClientHomeScreen()));
        break;
      case 1:
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
      appBar: AuthBlackAppBar(
        title: 'Calendário',
        subtitle: 'Veja seus compromissos',
        avatarImage: 'assets/images/user_icon.png',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TableCalendar(
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                  _fetchAppointmentsForDay(selectedDay);
                },
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextStyle: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 15),
                ),
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: GoogleFonts.inter(fontWeight: FontWeight.w500),
                  weekendStyle: GoogleFonts.inter(fontWeight: FontWeight.w500),
                ),
                calendarStyle: CalendarStyle(
                  selectedDecoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                  todayDecoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    shape: BoxShape.circle,
                  ),
                  defaultTextStyle: GoogleFonts.inter(),
                  weekendTextStyle: GoogleFonts.inter(),
                ),
              ),
            ),
            const SizedBox(height: 25),

            if (_selectedDay != null)
              Text(
                'Compromissos para ${_selectedDay!.day}/${_selectedDay!.month}',
                style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w600),
              ),
            const SizedBox(height: 10),

            // 🧠 FutureBuilder para exibir as consultas
            if (_appointmentsFuture != null)
              FutureBuilder<List<AppointmentModel>>(
                future: _appointmentsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text(
                      'Erro ao carregar compromissos 😥',
                      style: GoogleFonts.inter(color: Colors.red),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Text(
                      'Nenhum compromisso neste dia.',
                      style: GoogleFonts.inter(color: Colors.grey[700]),
                    );
                  } else {
                    final appointments = snapshot.data!;
                    return Column(
                      children: appointments.map((a) {
                        return AppointmentCard(
                          doctorName: "Dr. ${a.doctorId}",
                          specialty: a.motivo ?? 'Consulta',
                          date: a.dataMarcada ?? _selectedDay!,
                          time: DateFormat('HH:mm').format(a.dataMarcada ?? DateTime.now()),
                          address: a.planoDeSaude ?? "Endereço não informado",
                          avatarUrl: 'assets/images/doctor.png',
                        );
                      }).toList(),
                    );
                  }
                },
              )
            else
              const Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
      bottomNavigationBar: Navbar(
        selectedIndex: 1,
        onItemTapped: (index) => _onItemTapped(context, index),
      ),
    );
  }
}
