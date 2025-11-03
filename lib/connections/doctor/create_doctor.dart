import 'package:app_med/connections/doctor/login_doctor.dart';
import 'package:app_med/models/doctor_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:uuid/uuid.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<Map> createDoctor(DoctorModel doctorModel) async {
  var uuid = Uuid();
  String doctorId = uuid.v4();

  final response = await http.post(
    Uri.parse("${dotenv.env['API_URL']}/doctor/create"),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      "id": doctorId,
      "username": doctorModel.username,
      "senha": doctorModel.senha,
      "crm": "123322/SP",
      "especialidade": doctorModel.especialidade,
      "bio": doctorModel.bio,
      "email": doctorModel.email,
      "endereco_id": doctorModel.enderecoId,
    }),
  );
  if (response.statusCode != 201) {
    return {"Error": "erro na consulta"};
  }
  await loginDoctor(email: doctorModel.email!, senha: doctorModel.senha!);
  return {"Message": "Deu boa"};
}
