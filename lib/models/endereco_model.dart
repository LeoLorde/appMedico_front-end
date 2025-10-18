class EnderecoModel {
  final String estado;
  final String cidade;
  final String rua;
  final String cep;
  final String numero;
  final String complemento;

  EnderecoModel({
    required this.estado,
    required this.cidade,
    required this.rua,
    required this.cep,
    required this.numero,
    required this.complemento,
  });

  Map<String, dynamic> toMap() {
    return {
      'estado': estado,
      'cidade': cidade,
      'rua': rua,
      'cep': cep,
      'numero': numero,
      'complemento': complemento,
    };
  }

  factory EnderecoModel.fromMap(Map<String, dynamic> map) {
    return EnderecoModel(
      estado: map['estado'] ?? '',
      cidade: map['cidade'] ?? '',
      rua: map['rua'] ?? '',
      cep: map['cep'] ?? '',
      numero: map['numero'] ?? '',
      complemento: map['complemento'] ?? '',
    );
  }
}
