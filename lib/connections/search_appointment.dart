import 'package:app_med/models/appointment_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<List<AppointmentModel>> getAppointmentByDoctor({required String id}) async {
  try {
    final response = await http.get(
      Uri.parse("${dotenv.env['API_URL']}/appointment/doc/$id"),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      return [];
    }

    final List<dynamic> data = json.decode(response.body);

    return data.map((item) => AppointmentModel.fromMap(item)).toList();
  } catch (e) {
    print("Erro ao buscar agendamentos: $e");
    return [];
  }
}
