import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map> loginClient({required String email, required String senha}) async {
  final response = await http.post(
    Uri.parse("http://192.168.0.8:5000/client/login"),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({"senha": senha, "email": email}),
  );
  if (response.statusCode != 201) {
    return {"Error": "erro na consulta"};
  }
  final decoded = jsonDecode(response.body);
  return {"access_token": decoded["access_token"]};
}
