import 'package:app_med/models/doctor_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:uuid/uuid.dart';

Future<Map> createDoctor(DoctorModel doctorModel) async {
  var uuid = Uuid();
  String doctorId = uuid.v4();

  final response = await http.post(
    Uri.parse("http://192.168.1.10:5000/doctor/create"),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      "id": doctorId,
      "username": doctorModel.username,
      "senha": doctorModel.senha,
      "crm": doctorModel.crm,
      "especialidade": doctorModel.especialidade,
      "bio": doctorModel.bio,
      "email": doctorModel.email,
      "endereco_id": doctorModel.enderecoId,
    }),
  );
  if (response.statusCode != 201) {
    return {"Error": "erro na consulta"};
  }

  return {"Message": "Deu boa"};
}
