class DoctorModel {
  String? id;
  String? username;
  String? email;
  String? especialidade;
  String? bio;
  String? enderecoId;
  String? crm;
  String? senha;

  DoctorModel({
    this.id,
    this.username,
    this.email,
    this.especialidade,
    this.bio,
    this.enderecoId,
    this.crm,
    this.senha,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'especialidade': especialidade,
      'bio': bio,
      'endereco_id': enderecoId,
      'crm': crm,
      'senha': senha,
    };
  }

  factory DoctorModel.fromMap(Map<String, dynamic> map) {
    return DoctorModel(
      id: map['id'],
      username: map['username'],
      email: map['email'],
      especialidade: map['especialidade'],
      bio: map['bio'],
      enderecoId: map['endereco_id'],
      crm: map['crm'],
      senha: map['senha'],
    );
  }
}
