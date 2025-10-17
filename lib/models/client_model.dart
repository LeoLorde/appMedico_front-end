import 'package:intl/intl.dart';

class ClientModel {
  String? username;
  DateTime? dataDeNascimento;
  String? gender;
  String? senha;
  String? cpf;
  String? email;

  ClientModel({
    this.username,
    this.dataDeNascimento,
    this.gender,
    this.senha,
    this.cpf,
    this.email,
  });

  String? dataFormatada() {
    if (dataDeNascimento != null) {
      return DateFormat('yyyy-MM-dd').format(dataDeNascimento!);
    }
    return null;
  }

  Map<String, dynamic> toMap() {
    final dataFormatada = dataDeNascimento != null
        ? DateFormat('yyyy-MM-dd').format(dataDeNascimento!)
        : null;

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
      username: map['username'],
      dataDeNascimento: map['dataDeNascimento'] != null
          ? DateTime.tryParse(map['dataDeNascimento'])
          : null,
      gender: map['gender'],
      senha: map['senha'],
      cpf: map['cpf'],
      email: map['email'],
    );
  }
}
