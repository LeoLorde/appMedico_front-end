import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<Map> createExpediente({
  required String horario_fim,
  required String horario_inicio,
  required List<String> dias_trabalho,
}) async {
  final response = await http.post(
    Uri.parse("${dotenv.env['API_URL']}/expediente/create"),
    headers: {'Content-Type': 'application/json'},
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
