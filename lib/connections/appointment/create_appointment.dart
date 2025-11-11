import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<Map> createAppointment({
  required client_id,
  required doctor_id,
  required date,
  required motivo,
  required plano,
}) async {
  final response = await http.post(
    Uri.parse("${dotenv.env['API_URL']}/appointment/create"),
    headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer ${client_id}'},
    body: jsonEncode({
      "doctor_id": doctor_id,
      "data_marcada": date.toString(),
      "motivo": motivo,
      "plano_de_saude": plano,
    }),
  );

  if (response.statusCode != 201) {
    return {"Error": "${jsonDecode(response.body)}"};
  }
  final decoded = jsonDecode(response.body)["data"];
  return {"Message": "Deu boa", "appointment": decoded["appointment"], "doctor": decoded["doctor"]};
}
