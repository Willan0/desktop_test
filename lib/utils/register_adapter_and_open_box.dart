import 'package:hive_flutter/adapters.dart';

import '../constant/dao_constant.dart';
import '../data/vms/access_token/access_token.dart';
import '../data/vms/access_token/user/access_token_user.dart';
import '../data/vms/issue_stock/issue_stock_vm.dart';
import '../data/vms/issue_stock/item_gem_vm.dart';
import '../data/vms/issue_stock/item_waste_vm.dart';
import '../data/vms/issue_stock/main_stock.dart';
import '../data/vms/language_model/language_model.dart';
import '../data/vms/user/user.dart';

class RegisterAdapterAndOpenBox{
  static  init()async{
    Hive.registerAdapter(AccessTokenAdapter());
    Hive.registerAdapter(UserVMAdapter());
    Hive.registerAdapter(IssueStockVMAdapter());
    Hive.registerAdapter(ItemGemVMAdapter());
    Hive.registerAdapter(ItemWasteVMAdapter());
    Hive.registerAdapter(AccessTokenUserAdapter());
    Hive.registerAdapter(MainStockAdapter());
    Hive.registerAdapter(LanguageAdapter());
    // Hive.registerAdapter(NotificationVMAdapter());

    await Hive.openBox<AccessToken>(kBoxNameForUser);
    await Hive.openBox<IssueStockVM>(kBoxNameForIssue);
    await Hive.openBox<UserVM>(kBoxNameForCustomer);
    await Hive.openBox<MainStock>(kBoxNameForMainStock);
    await Hive.openBox<int>(kBoxNameForReturnVno);
    await Hive.openBox<String>(kBoxNameForNotificationToken);
    await Hive.openBox<Language>(kBoxNameForLanguage);    // await Hive.openBox<NotificationVM>(kBoxNameForNotification);
  }
}