import 'package:flutter/material.dart';
import 'package:desktop_test/persistent/table/notification_table.dart';
import 'package:rxdart/rxdart.dart';

import '../data/vms/notification/noti_vm.dart';

class NotificationProvider extends ChangeNotifier {
  bool _isDispose = false;

  NotificationProvider.internal();

  static final NotificationProvider _instance = NotificationProvider.internal();
  static bool _isInitialize = false;
  List<NotificationVM>? notificationList;

  ///instant
  static final NotificationTable _notificationTable = NotificationTable();
  static final BehaviorSubject<List<NotificationVM>?> _notificationSubj =
      BehaviorSubject.seeded([]);

  Stream<List<NotificationVM>?> notificationsFromStream() =>
      _notificationSubj.stream.asBroadcastStream();

  static Future<NotificationProvider> getInstance() async {
    await initialize();
    return _instance;
  }

  static Future<void> initialize() async {
    if (!_isInitialize) {
      await _notificationTable.init();
      await getNotificationList();
    }
    _isInitialize = true;
  }

  static Future<List<NotificationVM>?> getNotificationList() async {
    final notifications = await _notificationTable.getNotifications();
    _notificationSubj.add(notifications);
    return notifications;
  }

  Future<int> saveNotification(NotificationVM notification) async {
    final result = await _notificationTable.insert(notification);
    await getNotificationList();
    return result;
  }

  Future<int> deleteNotification(String sentTime) async {
    final result = await _notificationTable.delete(sentTime);
    await getNotificationList();
    return result;
  }

  @override
  void notifyListeners() {
    if (!_isDispose) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _isDispose = true;
    super.dispose();
  }
}
