import 'package:flutter/material.dart';
import '../data/data_apply/data_apply/gg_luck_data_apply_imp.dart';
import '../data/data_apply/data_apply/gg_luck_data_apply.dart';
import '../data/vms/access_token/access_token.dart';
import '../data/vms/issue_stock/issue_stock_vm.dart';
import '../data/vms/notification/notification_token.dart';
import '../persistent/daos/notification_token_dao/notification_token_dao_impl.dart';
import '../persistent/daos/user_dao/access_token_dao_impl.dart';

class LoginProvider extends ChangeNotifier {

  ///instance variable
  final GgLuckDataApply _ggLuckDataApply = GgLuckDataApplyImpl();
  bool _isDispose = true;
  List<IssueStockVM>? _issuesList;
  bool _isInitialized = true;
  bool _isSale = true;
  AccessToken? accessToken  = AccessTokenDaoImpl().getTokenFromDatabase();

  /// getter
  List<IssueStockVM>? get issues => _issuesList;

  bool get isSale => _isSale;
  bool get isInitialized => _isInitialized;
  bool get isFirstLogin => accessToken?.accessToken ==null;

  LoginProvider(){
   if(!isFirstLogin)checkLogin();
 }

  Future<AccessToken?> login(String userName, String password) async{
     final value= await _ggLuckDataApply.postAccessToken(userName, password);
     if(value!=null){
       _ggLuckDataApply.saveAccessTokenUser(value);
       _ggLuckDataApply.getAccessTokenFromDataBase().listen((event) {
         if(event!=null){
           _ggLuckDataApply.registerNotification(NotificationToken(userId: event.user?.id,role: event.user?.userRole,notificationToken: NotificationTokenDaoImpl().getNotificationToken()));
         }
       });
     }
      return value;
 }

  Future<bool?> checkDevice(String? serialNo)=> _ggLuckDataApply.checkDeviceSerial(serialNo ?? '');
  Future<void> checkLogin() async {
      await _ggLuckDataApply.refreshToken();
    accessToken = AccessTokenDaoImpl().getTokenFromDatabase();
    _isSale = accessToken?.user?.userRole == "sale";
    _isInitialized = accessToken == null ? false : true;
    if(_isSale){
      _issuesList = await _ggLuckDataApply.getIssues().catchError((e) {
        _isInitialized = false;
        return null;
      });
    }
    _isInitialized = false;
    notifyListeners();
  }

  @override
  void notifyListeners() {
    if (_isDispose) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _isDispose = false;
  }
}
