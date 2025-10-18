import 'package:app_med/models/endereco_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:uuid/uuid.dart';

Future<Map> createAdress(EnderecoModel enderecoModel) async {
  var uuid = Uuid();
  String enderecoId = uuid.v4();

  final response = await http.post(
    Uri.parse("http://192.168.1.10:5000/address/create"),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      "id": enderecoId,
      "estado": enderecoModel.estado,
      "cidade": enderecoModel.cidade,
      "rua": enderecoModel.rua,
      "cep": enderecoModel.cep,
      "numero": enderecoModel.numero,
      "complemento": enderecoModel.complemento,
    }),
  );

  if (response.statusCode != 201) {
    return {"Error": "Erro na consulta"};
  }

  return {"Message": "Deu boa", "address": jsonDecode(response.body)["data"]["id"]};
}
