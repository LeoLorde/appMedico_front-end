import 'package:app_med/models/appointment_model.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:app_med/models/client_model.dart';
import 'package:app_med/models/appointment_with_client.dart';

Future<List<AppointmentWithClient>> fetchAgendas(String token) async {
  try {
    final response = await http.get(
      Uri.parse("${dotenv.env['API_URL']}/appointment/doc"),
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
    );

    if (response.statusCode != 200) {
      debugPrint('Erro: ${response.statusCode}');
      return [];
    }

    final body = json.decode(response.body);
    final List<dynamic> jsonData = body['data'];

    return jsonData.map((item) {
      final appointment = AppointmentModel.fromMap(item['appointment']);
      final client = ClientModel.fromMap(item['client']);
      return AppointmentWithClient(appointment: appointment, client: client);
    }).toList();
  } catch (e) {
    debugPrint("Erro ao buscar agendamentos: $e");
    return [];
  }
}
