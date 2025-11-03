import 'config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'firebase_options.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Controlador pra enviar mensagens pra interface se quiser mostrar
final _messageStreamController = BehaviorSubject<RemoteMessage>();

// Config do plugin local notifications (pra exibir notificação com app aberto)
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// Handler de mensagens em segundo plano (app fechado ou em background)
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  if (kDebugMode) {
    print("📨 Mensagem recebida em segundo plano: ${message.messageId}");
    print("Título: ${message.notification?.title}");
    print("Corpo: ${message.notification?.body}");
  }
}

// Inicializa as notificações locais
Future<void> _initLocalNotifications() async {
  const AndroidInitializationSettings androidInit = AndroidInitializationSettings(
    '@mipmap/ic_launcher',
  );

  const InitializationSettings initSettings = InitializationSettings(android: androidInit);

  await flutterLocalNotificationsPlugin.initialize(initSettings);
}

// Mostra a notificação local (quando app tá aberto)
Future<void> _showNotification(RemoteMessage message) async {
  final notification = message.notification;
  if (notification == null) return;

  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'default_channel',
    'Notificações',
    importance: Importance.max,
    priority: Priority.high,
  );

  const NotificationDetails generalNotificationDetails = NotificationDetails(
    android: androidDetails,
  );

  await flutterLocalNotificationsPlugin.show(
    0,
    notification.title,
    notification.body,
    generalNotificationDetails,
  );
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  print("🌐 API_URL = ${dotenv.env['API_URL']}");

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await _initLocalNotifications();

  // Handler pra background
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  final messaging = FirebaseMessaging.instance;

  // Solicita permissão (iOS e Android 13+)
  final settings = await messaging.requestPermission(alert: true, badge: true, sound: true);

  if (kDebugMode) {
    print('✅ Permissão: ${settings.authorizationStatus}');
  }

  // Gera o token do dispositivo (pra usar no backend)
  final token = await messaging.getToken();
  if (kDebugMode) {
    print('📱 Token FCM: $token');
  }

  // Mensagem recebida com o app aberto
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (kDebugMode) {
      print("🔥 Mensagem em foreground: ${message.messageId}");
      print("Título: ${message.notification?.title}");
      print("Corpo: ${message.notification?.body}");
    }
    _messageStreamController.add(message);
    _showNotification(message);
  });

  // Mensagem aberta a partir da notificação
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    if (kDebugMode) {
      print("🚀 Notificação clicada: ${message.messageId}");
    }
  });

  runApp(configApp(developing: false, testing: true));
}
