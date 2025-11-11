import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Map> createExpediente({
  required String horario_fim,
  required String horario_inicio,
  required List<String> dias_trabalho,
}) async {
  final prefs = await SharedPreferences.getInstance();
  final acess_token = prefs.getString('access_token');
  final response = await http.post(
    Uri.parse("${dotenv.env['API_URL']}/expediente/create"),
    headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer ${acess_token}'},
    body: jsonEncode({
      "horario_inicio": horario_inicio,
      "horario_fim": horario_fim,
      "dias_trabalho": dias_trabalho,
    }),
  );
  if (response.statusCode != 200) {
    return {"Error": "erro na consulta"};
  }
  return {"message": "foi"};
}
