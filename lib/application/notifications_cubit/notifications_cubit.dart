import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_storage/get_storage.dart';

import '../../core/constant/notifications.dart';
import '../../data/models/notification/recieved_notification.dart';

class NotificationsCubit extends Cubit<List<String>> {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  NotificationsCubit(this._flutterLocalNotificationsPlugin) : super([]);

  Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('icon');

    _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: null,
    );

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);

    _configureDidReceiveLocalNotificationSubject();
    _configureSelectNotificationSubject();
  }

  void _configureDidReceiveLocalNotificationSubject() {
    didReceiveLocalNotificationStream.stream
        .listen((ReceivedNotification receivedNotification) async {
      // Handle received local notification
      emit([...state, receivedNotification.payload ?? '']);
    });
  }

  void _configureSelectNotificationSubject() {
    selectNotificationStream.stream.listen((String? payload) async {
      // Handle selected notification
      emit([...state, payload ?? '']);
    });
  }

  Future<void> showAndSaveNotification(String title, String body) async {
    try {
      const AndroidNotificationDetails androidNotificationDetails =
          AndroidNotificationDetails('your channel id', 'your channel name',
              channelDescription: 'your channel description',
              importance: Importance.max,
              priority: Priority.high,
              ticker: 'ticker');
      const NotificationDetails notificationDetails =
          NotificationDetails(android: androidNotificationDetails);
      await _flutterLocalNotificationsPlugin
          .show(id++, title, body, notificationDetails, payload: 'item x');

      // Save Notification Body Locally
      final box = GetStorage();
      final List<dynamic>? notificationsData = box.read('notifications');

      final List<String> updatedNotifications =
          List<String>.from(notificationsData ?? []);

      updatedNotifications.add(body);

      box.write('notifications', updatedNotifications);
    } catch (e) {
      log("error$e");
    }
  }

  Future<void> getSavedNotifications() async {
    final box = GetStorage();
    final List<dynamic>? notificationsData = box.read('notifications');

    if (notificationsData == null) {
      emit([]);
      return;
    }

    final List<String> notifications =
        notificationsData.map((dynamic item) => item.toString()).toList();

    emit(notifications);
  }

  Future<void> clearNotifications() async {
    final box = GetStorage();
    box.remove('notifications');
    emit([]);
  }
/*Future<void> showNotificationWithAudioAttributeAlarm() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your alarm channel id',
      'your alarm channel name',
      channelDescription: 'your alarm channel description',
      importance: Importance.max,
      priority: Priority.high,
      audioAttributesUsage: AudioAttributesUsage.alarm,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await _flutterLocalNotificationsPlugin.show(
      0,
      'notification sound controlled by alarm volume',
      'alarm notification sound body',
      platformChannelSpecifics,
    );
  }*/
}
