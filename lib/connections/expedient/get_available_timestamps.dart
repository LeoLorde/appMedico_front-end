import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<List<String>> getAvailableTimestamps({required String id, required String date}) async {
  try {
    final response = await http.post(
      Uri.parse("${dotenv.env['API_URL']}/expediente/available"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'id': id, "date": date}),
    );

    final decoded = jsonDecode(response.body);
    final List<String> horarios = [];

    for (final item in decoded["Horarios"]) {
      horarios.add(item.toString());
    }

    return horarios;
  } catch (e) {
    print("Erro ao buscar agendamentos: $e");
    return [];
  }
}
