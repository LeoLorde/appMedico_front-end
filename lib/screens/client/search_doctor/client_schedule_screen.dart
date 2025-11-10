import 'package:app_med/connections/appointment/create_appointment.dart';
import 'package:app_med/connections/expedient/get_available_timestamps.dart';
import 'package:app_med/models/doctor_model.dart';
import 'package:app_med/screens/client/confirmation_screen.dart';
import 'package:app_med/widgets/header/auth_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_med/connections/doctor/search_doctor.dart';

class ClientScheduleScreen extends StatefulWidget {
  final String id;
  final String? initialValue;
  final Function(String?)? onChanged;

  const ClientScheduleScreen({super.key, required this.id, this.initialValue, this.onChanged});

  @override
  State<ClientScheduleScreen> createState() => _ClientScheduleScreenState();
}

class _ClientScheduleScreenState extends State<ClientScheduleScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  String? _selectedTime;
  String? selectedPlan;
  DoctorModel? doctor;

  late Future<List<String>> _availableTimesFuture;

  final List<String> plans = [
    'Nenhum',
    'Unimed',
    'Bradesco Saúde',
    'Amil',
    'SulAmérica',
    'Prevent Senior',
    'Outro',
  ];

  final TextEditingController _reasonController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedPlan = widget.initialValue ?? 'Nenhum';
    // inicia vazio até o usuário selecionar um dia
    _availableTimesFuture = Future.value([]);

    _loadDoctor();
  }

  Future<void> _loadDoctor() async {
    final fetchedDoctor = await getDoctorById(id: widget.id);
    setState(() {
      doctor = fetchedDoctor;
    });
  }

  // função auxiliar pra formatar a data como yyyy-MM-dd
  String _formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  // quando o usuário clica em um dia no calendário
  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
      _selectedTime = null;
      // chama o endpoint pra buscar horários desse dia
      _availableTimesFuture = getAvailableTimestamps(id: widget.id, date: _formatDate(selectedDay));
    });
  }

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
                        doctor?.username ?? 'Carregando...',
                        style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        doctor?.especialidade ?? 'Carregando...',
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
                onDaySelected: _onDaySelected,
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

            const SizedBox(height: 25),

            // --- PLANO DE SAÚDE ---
            Text(
              'Plano de saúde',
              style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: selectedPlan,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
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
              dropdownColor: Colors.white,
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
                onPressed: _selectedDay != null && _selectedTime != null
                    ? () async {
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        final token = await prefs.get('access_token');

                        final timeParts = _selectedTime!.split(':');
                        int hour = int.parse(timeParts[0]);
                        int minute = int.parse(timeParts[1].split(':')[0]);
                        final selectedDateTime = DateTime(
                          _selectedDay!.year,
                          _selectedDay!.month,
                          _selectedDay!.day,
                          hour,
                          minute,
                        );

                        final response = await createAppointment(
                          client_id: token,
                          doctor_id: widget.id,
                          date: selectedDateTime,
                          motivo: _reasonController.text,
                          plano: selectedPlan ?? "",
                        );
                        print(response["appointment"]);
                        final List<String> date_time = response["appointment"]["data_marcada"]
                            .split('T');

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ConfirmationScreen(
                              doctorName: response["doctor"]["username"],
                              specialty: response["doctor"]["especialidade"],
                              date: date_time[0],
                              time: date_time[1],
                              address: 'address',
                            ),
                          ),
                        );
                      }
                    : null,
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
