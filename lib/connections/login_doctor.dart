import 'package:app_med/connections/save_fcm_token.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<Map> loginDoctor({required String email, required String senha}) async {
  final response = await http.post(
    Uri.parse("${dotenv.env['API_URL']}/doctor/login"),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({"senha": senha, "email": email}),
  );
  if (response.statusCode != 200) {
    return {"Error": "erro na consulta"};
  }
  final decoded = jsonDecode(response.body);
  print("CREATING FCM TOKEN");
  await createFCM(decoded["access_token"]);
  print("FCM TOKEN CREATED");
  return {"access_token": decoded["access_token"]};
}
