import 'package:app_med/models/doctor_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<List<DoctorModel>> getDoctor({required String username}) async {
  try {
    final response = await http.get(
      Uri.parse("${dotenv.env['API_URL']}/doctor/username/$username/8"),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      return [];
    }

    final List<dynamic> data = json.decode(response.body);

    return data.map((item) => DoctorModel.fromMap(item)).toList();
  } catch (e) {
    print("Erro ao buscar médicos: $e");
    return [];
  }
}

Future<DoctorModel> getDoctorById({required String id}) async {
  try {
    final response = await http.get(
      Uri.parse("${dotenv.env['API_URL']}/doctor/id/$id"),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      return DoctorModel();
    }

    final Map<String, dynamic> data = json.decode(response.body);

    return DoctorModel.fromMap(data);
  } catch (e) {
    print("Erro ao buscar médicos: $e");
    return DoctorModel();
  }
}
