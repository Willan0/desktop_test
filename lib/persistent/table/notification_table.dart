import 'package:desktop_test/data/vms/notification/noti_vm.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NotificationTable {
  static Database? _db;

  static const _databaseName = "Notification.db";
  static const _databaseVersion = 1;

  static const table = "notification_table";

  static const columnId = "id";
  static const columnSentTime = 'sentTime';
  static const columnTitle = 'title';
  static const columnBody = 'body';
  static const columnIsRead = 'isRead';
  static const columnRedirectUrl = 'redirectUrl';

  NotificationTable._internal();
  static final NotificationTable _singleton = NotificationTable._internal();

  factory NotificationTable() => _singleton;

  Future<void> init() async {
    if (_db != null) {
      return;
    }
    try {
      var databasePath = await getDatabasesPath();
      String path = join(databasePath, _databaseName);
      _db = await openDatabase(path,
          version: _databaseVersion, onCreate: _onCreate);
    } catch (e) {
      print(e);
    }
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table(
      $columnId INTEGER PRIMARY KEY,
      $columnTitle TEXT NOT NULL,
      $columnBody TEXT NOT NULL,
      $columnSentTime TEXT NOT NULL,
      $columnIsRead BOOLEAN NOT NULL,
      $columnRedirectUrl TEXT NOT NULL
      )
        ''');
  }

  Future<int> insert(NotificationVM values) async {
    return await _db?.insert(table, values.toJson()) ?? 1;
  }

  Future<List<NotificationVM>?> getNotifications() async {
    final data = await _db!.query(table);
    return data.map(NotificationVM.fromJson).toList();
  }

  Future<int> delete(String sentTime) async {
    return await _db?.rawDelete(
            "DELETE FROM $table WHERE $columnSentTime= '$sentTime'") ??
        1;
  }
}
