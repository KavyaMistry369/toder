import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tzz;

class NotificationsHelper {
  NotificationsHelper._();

  static final NotificationsHelper notificationsHelper =
      NotificationsHelper._();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    final AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('logo');

    final InitializationSettings initializationSettings =
        InitializationSettings(android: androidInitializationSettings);

    tz.initializeTimeZones();

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void simpleNotifications() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'channelId',
      'channelName',
      importance: Importance.max,
      priority: Priority.max,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
        0, 'title Kavya', 'Flutter Developer', platformChannelSpecifics,
        payload: 'data');
  }

  void scheduledNotification({required DateTime myTime}) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'channelId',
      'channelName',
      importance: Importance.max,
      priority: Priority.max,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.zonedSchedule(0, 'This is Title',
        'This is Body',tzz.TZDateTime.from(myTime,tzz.local), platformChannelSpecifics,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }
}
