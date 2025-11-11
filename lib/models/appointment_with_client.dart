import 'client_model.dart';
import 'appointment_model.dart';

class AppointmentWithClient {
  final AppointmentModel appointment;
  final ClientModel client;

  AppointmentWithClient({required this.appointment, required this.client});
}
