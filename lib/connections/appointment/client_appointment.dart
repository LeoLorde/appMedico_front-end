import 'package:app_med/models/appointment_model.dart';
import 'package:app_med/models/doctor_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<List<AppointmentModel>> getAppointmentByClient({required String token}) async {
  List<AppointmentModel> appointments = [];

  try {
    final response = await http.get(
      Uri.parse("${dotenv.env['API_URL']}/appointment/client"),
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
    );
    if (response.statusCode != 200) {
      print("Erro HTTP: ${response.statusCode}");
      return [];
    }
    final decoded = json.decode(response.body);

    if (decoded == null || decoded['data'] == null) {
      print("Nenhum dado encontrado no corpo da resposta");
      return [];
    }

    final List<dynamic> dataList = decoded['data'];

    for (var item in dataList) {
      final appointmentMap = item['appointment'];
      final doctorMap = item['doctor'];

      if (appointmentMap == null || doctorMap == null) {
        continue;
      }

      try {
        print("AQUI");
        final appointment = AppointmentModel.fromMap(appointmentMap!);
        print(appointment);
        final doctor = DoctorModel.fromMap(doctorMap!);
        print(doctor);
        appointment.doctor = doctor;

        appointments.add(appointment);
      } catch (e) {}
    }

    print("✅ Total de agendamentos carregados: ${appointments.length}");
    return appointments;
  } catch (e, stack) {
    print("❌ Erro ao buscar agendamentos: $e");
    print(stack);
    return [];
  }
}
