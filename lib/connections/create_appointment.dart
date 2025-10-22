import 'package:app_med/models/endereco_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:uuid/uuid.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<Map> createAppointment({required client_id, required doctor_id, required date}) async {
  final response = await http.post(
    Uri.parse("${dotenv.env['API_URL']}/appointment/create"),
    headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer ${client_id}'},
    body: jsonEncode({"doctor_id": doctor_id, "data_marcada": date.toString()}),
  );

  if (response.statusCode != 201) {
    return {"Error": "${jsonDecode(response.body)}"};
  }

  return {"Message": "Deu boa", "appointment": ""};
}
