import 'package:intl/intl.dart';

class ClientModel {
  String username;
  DateTime dataDeNascimento;
  String gender;
  String senha;
  String cpf;
  String email;

  ClientModel({
    required this.username,
    required this.dataDeNascimento,
    required this.gender,
    required this.senha,
    required this.cpf,
    required this.email,
  });

  String dataFormatada() {
    return DateFormat('yyyy-MM-dd').format(dataDeNascimento);
  }

  Map<String, dynamic> toMap() {
    final dataFormatada = DateFormat('yyyy-MM-dd').format(dataDeNascimento);

    return {
      'username': username,
      'dataDeNascimento': dataFormatada,
      'gender': gender,
      'senha': senha,
      'cpf': cpf,
      'email': email,
    };
  }

  factory ClientModel.fromMap(Map<String, dynamic> map) {
    return ClientModel(
      username: map['username'] ?? '',
      dataDeNascimento: DateTime.parse(map['dataDeNascimento']),
      gender: map['gender'] ?? '',
      senha: map['senha'] ?? '',
      cpf: map['cpf'] ?? '',
      email: map['email'] ?? '',
    );
  }
}
