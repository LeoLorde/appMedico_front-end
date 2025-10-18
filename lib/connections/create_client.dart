import 'package:app_med/models/client_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:uuid/uuid.dart';

Future<Map> createClient(ClientModel clientModel) async {
  var uuid = Uuid();
  String clientId = uuid.v4();

  final response = await http.post(
    Uri.parse("http://192.168.1.10:5000/client/create"),
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
  if (response.statusCode != 201) {
    return {"Error": "erro na consulta"};
  }

  return {"Message": "Deu boa"};
}
