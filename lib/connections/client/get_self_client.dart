import 'package:app_med/models/client_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<ClientModel> getSelfClient({required String token}) async {
  try {
    final response = await http.get(
      Uri.parse("${dotenv.env['API_URL']}/client/"),
      headers: {'Content-Type': 'application/json', 'Authorization': "Bearer $token"},
    );

    if (response.statusCode != 200) {
      return ClientModel(username: "Not Found");
    }

    final Map data = json.decode(response.body);

    return ClientModel.fromMap(data["user"]);
  } catch (e) {
    print("Erro ao buscar médicos: $e");
    return ClientModel(username: "Not Found");
  }
}
