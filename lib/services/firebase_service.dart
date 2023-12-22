import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:desktop_test/persistent/daos/notification_token_dao/notification_token_dao_impl.dart';
import 'package:desktop_test/provider/notification_provider.dart';
import 'package:desktop_test/services/local_notification_service.dart';

import '../data/vms/notification/noti_vm.dart';

class FirebaseService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  void init() {
    _firebaseMessaging.requestPermission(
        sound: true,
        badge: true,
        alert: true,
        announcement: true,
        carPlay: true);

    /// fcm Token generate
    _firebaseMessaging.getToken().then((value) {
      debugPrint("FCM Token --------> $value");
      NotificationTokenDaoImpl().saveNotificationToken(value ?? '');
    });

    /// foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage? remoteMessage) async {
      final notification = remoteMessage?.notification;

      await showNotification({
        'title': notification?.title,
        'body': notification?.body,
        'sentTime': remoteMessage?.sentTime.toString(),
        'redirectUrl': remoteMessage?.data['redirectUrl']
      });
    });

    /// background and terminal
    FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);
  }

  @pragma('vm:entry-point')
  static Future<void> backgroundMessageHandler(
      RemoteMessage? remoteMessage) async {
    NotificationProvider notificationProvider =
        await NotificationProvider.getInstance();
    final notification = remoteMessage?.notification;
    final data = {
      'title': notification?.title,
      'body': notification?.body,
      'sentTime': remoteMessage?.sentTime.toString(),
      'redirectUrl': remoteMessage?.data['redirectUrl']
    };
    await notificationProvider.saveNotification(NotificationVM.fromJson(data));
  }

  static Future<void> showNotification(
      Map<String, dynamic> notification) async {
    NotificationProvider notificationProvider =
        await NotificationProvider.getInstance();

    NotificationVM notifications = NotificationVM.fromJson(notification);
    await notificationProvider.saveNotification(notifications);
    await LocalNotificationService().showNotification(
        notifications.title ?? 'fail', notifications.body ?? "fail",
        payload: notifications.redirectUrl ?? '');
  }
}
