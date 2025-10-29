import 'package:app_med/screens/client/client_configuration_screen.dart';
import 'package:app_med/screens/client/client_home_screen.dart';
import 'package:app_med/screens/client/client_notification_screen.dart';
import 'package:app_med/widgets/cards/appointment_card.dart';
import 'package:app_med/widgets/header/auth_black_app_bar.dart';
import 'package:app_med/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

class ClientCalendarScreen extends StatefulWidget {
  @override
  State<ClientCalendarScreen> createState() => _ClientCalendarScreenState();
}

class _ClientCalendarScreenState extends State<ClientCalendarScreen> {
  final Map<DateTime, List<Map<String, dynamic>>> _appointments = {
    DateTime.utc(2025, 5, 13): [
      {
        'doctorName': 'Dr. Leonardo Reisdoefer',
        'specialty': 'Dermatologista',
        'time': '2:00 PM',
        'address': 'Ipumirim, Rua Adilio Fontana',
        'avatar': 'assets/images/doctor.png',
      },
    ],
  };

  List<Map<String, dynamic>> _getAppointmentsForDay(DateTime day) {
    return _appointments[DateTime.utc(day.year, day.month, day.day)] ?? [];
  }

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

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
    final appointments = _selectedDay != null ? _getAppointmentsForDay(_selectedDay!) : [];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AuthBlackAppBar(
        title: 'Calendário',
        subtitle: 'Veja seus compromissos',
        avatarImage: 'assets/images/logo.png',
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

            // Título
            if (_selectedDay != null)
              Text(
                'Compromissos para ${_selectedDay!.day}/${_selectedDay!.month}',
                style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w600),
              ),
            const SizedBox(height: 10),

            // Lista de consultas ou mensagem
            if (appointments.isNotEmpty)
              ...appointments.map(
                (a) => AppointmentCard(
                  doctorName: a['doctorName'],
                  specialty: a['specialty'],
                  date: _selectedDay!,
                  time: a['time'],
                  address: a['address'],
                  avatarUrl: a['avatar'],
                ),
              ),
            if (appointments.isEmpty && _selectedDay != null)
              Text(
                'Nenhum compromisso neste dia.',
                style: GoogleFonts.inter(color: Colors.grey[700]),
              ),
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
