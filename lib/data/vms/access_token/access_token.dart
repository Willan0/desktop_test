import 'package:desktop_test/constant/dao_constant.dart';
import 'package:desktop_test/data/vms/access_token/user/access_token_user.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import 'adjust_value/adjust_value_vm.dart';

part 'access_token.g.dart';

@JsonSerializable()
@HiveType(typeId: kTypeIdForAccess)
class AccessToken {
  @JsonKey(name: 'access_token')
  @HiveField(0)
  final String? accessToken;

  @JsonKey(name: 'refresh_token')
  @HiveField(1)
  final String? refreshToken;

  @JsonKey(name: 'expiration')
  @HiveField(2)
  final int? expiration;

  @JsonKey(name: 'user')
  @HiveField(3)
  final AccessTokenUser? user;

  @JsonKey(name: 'adjust_values')
  final List<AdjustValueVM>? adjustValues;
  AccessToken(
      {this.accessToken,
      this.refreshToken,
      this.expiration,
      this.user,
      this.adjustValues});

  factory AccessToken.fromJson(Map<String, dynamic> json) =>
      _$AccessTokenFromJson(json);
  Map<String, dynamic> accessTokenToJson() => _$AccessTokenToJson(this);

  @override
  String toString() {
    return 'AccessToken{ accessToken: $accessToken, refreshToken: $refreshToken, expiration: $expiration}';
  }
}
