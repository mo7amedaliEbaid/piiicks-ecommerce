import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../core/constant/notifications.dart';
import '../../data/models/notification/recieved_notification.dart';

class NotificationsCubit extends Cubit<List<String>> {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  NotificationsCubit(this._flutterLocalNotificationsPlugin) : super([]);

  Future<void> init() async {
    log("initiaiiiiiizing");
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon');
    // TODO add icon in drawable folder

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

  Future<void> showPlainNotification() async {
    log("presssssssed");
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails('your channel id', 'your channel name',
        channelDescription: 'your channel description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');
    const NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);
    await _flutterLocalNotificationsPlugin.show(
        id++, 'plain title', 'plain body', notificationDetails,
        payload: 'item x');
  }

  Future<void> showNotificationWithAudioAttributeAlarm() async {
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
  }
}