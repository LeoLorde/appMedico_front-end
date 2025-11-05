import 'package:app_med/connections/appointment/create_appointment.dart';
import 'package:app_med/connections/expedient/get_available_timestamps.dart';
import 'package:app_med/screens/client/confirmation_screen.dart';
import 'package:app_med/widgets/header/auth_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClientScheduleScreen extends StatefulWidget {
  String id;
  final String? initialValue;
  final Function(String?)? onChanged;

  ClientScheduleScreen({super.key, required this.id, this.initialValue, this.onChanged});

  @override
  State<ClientScheduleScreen> createState() => _ClientScheduleScreenState();
}

class _ClientScheduleScreenState extends State<ClientScheduleScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  String? _selectedTime;
  String? selectedPlan;

  final List<String> plans = [
    'Nenhum',
    'Unimed',
    'Bradesco Saúde',
    'Amil',
    'SulAmérica',
    'Prevent Senior',
    'Outro',
  ];

  @override
  void initState() {
    super.initState();
    selectedPlan = widget.initialValue ?? 'Nenhum';
    _availableTimesFuture = getAvailableTimestamps(id: widget.id);
  }

  late Future<List<String>> _availableTimesFuture;

  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _planController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AuthAppBar(title: 'Agendar', onBackTap: () => Navigator.pop(context)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- CARD DO DOUTOR ---
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage('assets/images/logo.png'),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dr. Leonardo Reisdoefer',
                        style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        'Dermatologista',
                        style: GoogleFonts.inter(fontSize: 14, color: Colors.grey[700]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),

            // --- TÍTULO CALENDÁRIO ---
            Text(
              'Selecionar Data',
              style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 10),

            // --- CALENDÁRIO ---
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TableCalendar(
                firstDay: DateTime.now(),
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

            // --- HORÁRIOS DISPONÍVEIS ---
            if (_selectedDay != null)
              FutureBuilder<List<String>>(
                future: _availableTimesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text(
                      'Erro ao carregar horários.',
                      style: GoogleFonts.inter(color: Colors.red),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Text(
                      'Nenhum horário disponível para este dia.',
                      style: GoogleFonts.inter(color: Colors.grey),
                    );
                  }

                  final times = snapshot.data!;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Horários disponíveis - Dia ${_selectedDay!.day}',
                        style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: times.map((time) {
                          final isSelected = _selectedTime == time;
                          return GestureDetector(
                            onTap: () => setState(() => _selectedTime = time),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                              decoration: BoxDecoration(
                                color: isSelected ? Colors.black : Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: Text(
                                time,
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500,
                                  color: isSelected ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  );
                },
              ),

            const SizedBox(height: 25),

            // --- MOTIVO DA VISITA ---
            Text(
              'Motivo da Visita',
              style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _reasonController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Descreva o motivo...',
                hintStyle: GoogleFonts.inter(color: Colors.grey),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            SizedBox(height: 25),
            Text(
              'Plano de saúde',
              style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: selectedPlan,
              decoration: InputDecoration(
                filled: true, // pra preencher o fundo
                fillColor: Colors.white, // fundo branco
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey, width: 1),
                ),
              ),
              icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black54),
              dropdownColor: Colors.white, // fundo branco do menu
              style: GoogleFonts.inter(fontSize: 14, color: Colors.black87),
              items: plans.map((String plan) {
                return DropdownMenuItem<String>(
                  value: plan,
                  child: Text(plan, style: GoogleFonts.inter(fontSize: 14)),
                );
              }).toList(),
              onChanged: (value) {
                setState(() => selectedPlan = value);
                if (widget.onChanged != null) widget.onChanged!(value);
              },
            ),

            const SizedBox(height: 25),

            // --- BOTÃO CONFIRMAR ---
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  final token = await prefs.get('access_token');
                  final timeParts = _selectedTime!.split(' ');
                  final hourMinute = timeParts[0].split(':');
                  int hour = int.parse(hourMinute[0]);
                  int minute = int.parse(hourMinute[1]);

                  if (timeParts[1] == 'PM' && hour != 12) hour += 12;
                  if (timeParts[1] == 'AM' && hour == 12) hour = 0;

                  final selectedDateTime = DateTime(
                    _selectedDay!.year,
                    _selectedDay!.month,
                    _selectedDay!.day,
                    hour,
                    minute,
                  );

                  await createAppointment(
                    client_id: token,
                    doctor_id: widget.id,
                    date: selectedDateTime,
                    motivo: _reasonController.text,
                    plano: "",
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ConfirmationScreen(
                        doctorName: 'doctorName',
                        specialty: 'specialty',
                        date: 'date',
                        time: 'time',
                        address: 'address',
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _selectedDay != null && _selectedTime != null
                      ? Colors.black
                      : Colors.grey.shade400,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: Text(
                  'Confirmar Pedido',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
