import 'package:desktop_test/data/vms/access_token/access_token.dart';

abstract class AccessTokenDao {
  void saveUser(AccessToken accessToken);

  AccessToken? getTokenFromDatabase();

  Stream<AccessToken?> getTokenFromStreamDataBase();

  Stream watchUser();

  Future deleteAccessToken();
}
