abstract class NotificationTokenDao{
  Future<void> saveNotificationToken(String notiToken);

  String? getNotificationToken();

  Future<void> deleteNotificationToken();


}