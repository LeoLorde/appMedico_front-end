import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<Map> createFCM() async {
  final messaging = FirebaseMessaging.instance;
  final token = await messaging.getToken();

  final response = await http.post(
    Uri.parse("${dotenv.env['API_URL']}/fcm/create"),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({"fcm_token": token ?? "", "device_info": ""}),
  );

  if (response.statusCode != 201) {
    return {"Error": "${jsonDecode(response.body)}"};
  }

  return {"Message": "Deu boa"};
}
