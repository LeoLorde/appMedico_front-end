import 'package:app_med/screens/shared/notification_screen.dart';
import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// Handler para navegação baseada nos dados da notificação
void handleNotificationNavigation(Map<String, dynamic> data) {
  final String? type = data['type'];
  final String? appointmentId = data['appointment_id'];

  if (navigatorKey.currentContext == null) {
    print('Contexto de navegação não disponível ainda');
    return;
  }

  switch (type) {
    case 'appointment_confirmed':
      // Navegar para tela de calendário ou detalhes do agendamento
      // Navigator.of(navigatorKey.currentContext!).push(
      //   MaterialPageRoute(builder: (_) => AppointmentDetailsScreen(appointmentId: appointmentId)),
      // );
      print('$appointmentId');
      break;

    case 'appointment_request':
      // Navegar para tela de solicitações pendentes (para médicos)
      // Navigator.of(
      //   navigatorKey.currentContext!,
      // ).push(MaterialPageRoute(builder: (_) => PendingAppointmentsScreen()));
      break;

    case 'appointment_cancelled':
      Navigator.of(
        navigatorKey.currentContext!,
      ).push(MaterialPageRoute(builder: (_) => NotificationScreen()));
      break;

    default:
      print('Tipo de notificação desconhecido: $type');
  }
}
