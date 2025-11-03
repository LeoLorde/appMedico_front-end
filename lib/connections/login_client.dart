import 'package:app_med/connections/save_fcm_token.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<Map> loginClient({required String email, required String senha}) async {
  final response = await http.post(
    Uri.parse("${dotenv.env['API_URL']}/client/login"),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({"senha": senha, "email": email}),
  );
  if (response.statusCode != 200) {
    return {"Error": "erro na consulta"};
  }
  final decoded = jsonDecode(response.body);
  await createFCM();
  return {"access_token": decoded["access_token"]};
}
