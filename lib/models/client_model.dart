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

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'dataDeNascimento': dataDeNascimento.toIso8601String(),
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
