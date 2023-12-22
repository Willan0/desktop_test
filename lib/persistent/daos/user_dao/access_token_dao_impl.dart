import 'package:desktop_test/constant/dao_constant.dart';
import 'package:desktop_test/data/vms/access_token/access_token.dart';
import 'package:desktop_test/persistent/daos/user_dao/access_token_dao.dart';
import 'package:hive/hive.dart';

class AccessTokenDaoImpl extends AccessTokenDao {
  final _keyForAccessTokenBox = "token";
  AccessTokenDaoImpl._();
  static final AccessTokenDaoImpl _singleton = AccessTokenDaoImpl._();

  factory AccessTokenDaoImpl() => _singleton;

  final Box<AccessToken> _accessTokenBox =
      Hive.box<AccessToken>(kBoxNameForUser);
  @override
  AccessToken? getTokenFromDatabase() {
    return _accessTokenBox.get(_keyForAccessTokenBox);
  }

  @override
  Stream<AccessToken?> getTokenFromStreamDataBase() =>
      Stream.value(getTokenFromDatabase());

  @override
  void saveUser(AccessToken accessToken) {
    _accessTokenBox.put(_keyForAccessTokenBox, accessToken);
  }

  @override
  Stream watchUser() => _accessTokenBox.watch();

  @override
  Future deleteAccessToken() async {
    _accessTokenBox.clear();
  }
}
