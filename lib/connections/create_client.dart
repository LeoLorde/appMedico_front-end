import 'package:app_med/models/client_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map> createClient(ClientModel clientModel) async {
  final response = await http.post(
    Uri.parse("http://10.0.29.229:5000/client/create"),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      "username": clientModel.username,
      "dataDeNascimento": clientModel.dataDeNascimento.toString(),
      "gender": clientModel.gender,
      "senha": clientModel.senha,
      "cpf": clientModel.cpf,
      "email": clientModel.email,
    }),
  );
  if (response.statusCode != 201) {
    return {"Error": "erro na consulta"};
  }

  return {"Message": "Deu boa"};
}
