import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:recipebookapp/app/set_up_local_notification.dart';

class FCMService {
 static Future <void> initialize()async{
    await FirebaseMessaging.instance.requestPermission(
         alert : true,
         announcement : false,
         badge : true,
         carPlay : false,
         criticalAlert : false,
         provisional : false,
         sound : true,
         providesAppNotificationSettings : false
    );

    /// firebase recieve message in three ways - foreground,background and terminated
    ///foreground
    FirebaseMessaging.onMessage.listen(_handlenotification);

    /// background

    FirebaseMessaging.onMessageOpenedApp.listen(_handlenotification);


    FirebaseMessaging.onBackgroundMessage(_handleTerminatedNotification);
  }
 static void _handlenotification(RemoteMessage message) {
   print(message.data);
   print(message.notification?.title);
   print(message.notification?.body);

   if (message.notification != null) {
     flutterLocalNotificationsPlugin.show(
       0,
       message.notification!.title,
       message.notification!.body,
       const NotificationDetails(
         android: AndroidNotificationDetails(
           'high_importance_channel',
           'High Importance Notifications',
           importance: Importance.max,
           priority: Priority.high,
         ),
       ),
     );
   }
 }
}

Future<void> _handleTerminatedNotification(RemoteMessage message) async {
  print("Background message: ${message.messageId}");
}