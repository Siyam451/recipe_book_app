import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> setupLocalNotifications() async {
  const AndroidInitializationSettings androidSettings =
  AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings settings =
  InitializationSettings(android: androidSettings);

  await flutterLocalNotificationsPlugin.initialize(settings);
}