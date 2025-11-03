import 'package:app_med/models/appointment_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> confirmAppointment({required String id, required String token}) async {
  try {
    print('aqui');
    final response = await http.put(
      Uri.parse("${dotenv.env['API_URL']}/appointment/confirm"),
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer ${token}'},
      body: jsonEncode({'app_id': id}),
    );
  } catch (e) {
    print("Erro ao buscar agendamentos: $e");
    return;
  }
}
