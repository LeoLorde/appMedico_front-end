class AppointmentModel {
  String? id;
  DateTime? dataMarcada;
  String? clientId;
  String? doctorId;
  String? isConfirmed;

  AppointmentModel({this.id, this.dataMarcada, this.clientId, this.doctorId, this.isConfirmed});

  // Converter objeto para Map (para enviar ao backend)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'data_marcada': dataMarcada?.toIso8601String(), // só converte se não for nulo
      'client_id': clientId,
      'doctor_id': doctorId,
      'is_confirmed': isConfirmed,
    };
  }

  // Criar a partir de um Map (quando recebe do backend)
  factory AppointmentModel.fromMap(Map<String, dynamic> map) {
    return AppointmentModel(
      id: map['id'],
      dataMarcada: map['data_marcada'] != null ? DateTime.parse(map['data_marcada']) : null,
      clientId: map['client_id'],
      doctorId: map['doctor_id'],
      isConfirmed: map['is_confirmed'],
    );
  }
}
