import 'package:app_med/connections/login_client.dart';
import 'package:app_med/models/client_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:uuid/uuid.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

Future<Map> createClient(ClientModel clientModel) async {
  print("COMEÇANDO");
  var uuid = Uuid();
  String clientId = uuid.v4();
  print("UUID");

  final response = await http.post(
    Uri.parse("${dotenv.env['API_URL']}/client/create"),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      "id": clientId,
      "username": clientModel.username,
      "dataDeNascimento": clientModel.dataFormatada(),
      "genero": clientModel.gender,
      "senha": clientModel.senha,
      "cpf": clientModel.cpf,
      "email": clientModel.email,
    }),
  );
  print(jsonDecode(response.body));
  if (response.statusCode != 201) {
    return {"Error": "erro na consulta"};
  }
  final response2 = await loginClient(email: clientModel.email!, senha: clientModel.senha!);
  final access_token = response2["access_token"];

  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('access_token', access_token);

  return {"Message": "Deu boa"};
}
