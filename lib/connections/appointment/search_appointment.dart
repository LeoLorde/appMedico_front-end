import 'package:app_med/models/appointment_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<List<AppointmentModel>> getAppointmentByDoctor({required String id}) async {
  try {
    final response = await http.get(
      Uri.parse("${dotenv.env['API_URL']}/appointment/doc"),
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer ${id}'},
    );

    if (response.statusCode != 200) {
      return [];
    }

    final List<dynamic> jsonData = json.decode(response.body)['data'];
    final data = jsonData.map((e) => e as Map<String, dynamic>).toList();

    return data.map((item) => AppointmentModel.fromMap(item)).toList();
  } catch (e) {
    print("Erro ao buscar agendamentos: $e");
    return [];
  }
}
