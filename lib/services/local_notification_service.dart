import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class LocalNotificationService{
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static const kChannelId = 'NotificationId';
  static const kChannelName = 'NotificationName';
  static const kChannelDescription = "ChannelDescription";

  static final LocalNotificationService _service = LocalNotificationService.internal();
  LocalNotificationService.internal(){
    init();
  }

  factory LocalNotificationService() => _service;

  init() async{
    const androidInitialization = AndroidInitializationSettings("@drawable/notification");
    const iosInitialization = DarwinInitializationSettings();
    const initializationSettings =  InitializationSettings(android: androidInitialization,iOS: iosInitialization);
    await  _flutterLocalNotificationsPlugin.initialize(initializationSettings,onDidReceiveNotificationResponse: (notificationResponse) {
    },);
  }

  Future<void> showNotification(String title,String body,{String? payload,String? image}) async{
    const iosNotificationDetail = DarwinNotificationDetails();
    const androidNotificationDetail = AndroidNotificationDetails(kChannelId, kChannelName,channelDescription: kChannelDescription,importance: Importance.max,priority: Priority.high);
    const notificationDetails = NotificationDetails(android: androidNotificationDetail,iOS: iosNotificationDetail);
    await _flutterLocalNotificationsPlugin.show(1, title, body, notificationDetails,payload: payload);
  }
}