import 'package:desktop_test/constant/dao_constant.dart';
import 'package:desktop_test/persistent/daos/notification_token_dao/notification_token_dao.dart';
import 'package:hive/hive.dart';

class NotificationTokenDaoImpl extends NotificationTokenDao {
  NotificationTokenDaoImpl._();
  static final NotificationTokenDaoImpl _singleTon =
      NotificationTokenDaoImpl._();
  factory NotificationTokenDaoImpl() => _singleTon;

  final Box<String> _notiTokenBox = Hive.box(kBoxNameForNotificationToken);
  @override
  Future<void> deleteNotificationToken() => _notiTokenBox.clear();

  @override
  String? getNotificationToken() => _notiTokenBox.get('token');

  @override
  Future<void> saveNotificationToken(String notiToken) =>
      _notiTokenBox.put('token', notiToken);
}
