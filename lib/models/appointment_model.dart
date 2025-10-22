class AppointmentModel {
  String? id;
  DateTime? dataMarcada;
  String? clientId;
  String? doctorId;
  String? isConfirmed;
  String? motivo;
  String? planoDeSaude;

  AppointmentModel({
    this.id,
    this.dataMarcada,
    this.clientId,
    this.doctorId,
    this.isConfirmed,
    this.motivo,
    this.planoDeSaude,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'data_marcada': dataMarcada?.toIso8601String(),
      'client_id': clientId,
      'doctor_id': doctorId,
      'is_confirmed': isConfirmed,
      'motivo': motivo,
      'plano_de_saude': planoDeSaude,
    };
  }

  factory AppointmentModel.fromMap(Map<String, dynamic> map) {
    return AppointmentModel(
      id: map['id'],
      dataMarcada: map['data_marcada'] != null ? DateTime.parse(map['data_marcada']) : null,
      clientId: map['client_id'],
      doctorId: map['doctor_id'],
      isConfirmed: map['is_confirmed'],
      motivo: map['motivo'],
      planoDeSaude: map['plano_de_saude'],
    );
  }
}
