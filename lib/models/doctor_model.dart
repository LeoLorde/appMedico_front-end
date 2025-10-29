class DoctorModel {
  String? id;
  String? username;
  String? email;
  String? especialidade;
  String? bio;
  String? enderecoId;
  String? crm;
  String? senha;
  String? startHour;
  String? endHour;
  String? lunchStart;
  String? lunchEnd;
  List<String>? workDays;

  DoctorModel({
    this.id,
    this.username,
    this.email,
    this.especialidade,
    this.bio,
    this.enderecoId,
    this.crm,
    this.senha,
    this.startHour,
    this.endHour,
    this.lunchStart,
    this.lunchEnd,
    this.workDays,
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
      'start_hour': startHour,
      'end_hour': endHour,
      'lunch_start': lunchStart,
      'lunch_end': lunchEnd,
      'work_days': workDays, // pode precisar converter pra string se for salvar no BD
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
      startHour: map['start_hour'],
      endHour: map['end_hour'],
      lunchStart: map['lunch_start'],
      lunchEnd: map['lunch_end'],
      workDays: map['work_days'] != null ? List<String>.from(map['work_days']) : [],
    );
  }
}
