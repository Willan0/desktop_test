import 'package:desktop_test/constant/dao_constant.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'access_token_user.g.dart';

@JsonSerializable()
@HiveType(typeId: kTypeIdForUser)
class AccessTokenUser {
  @JsonKey(name: 'id')
  @HiveField(0)
  String? id;

  @JsonKey(name: 'userName')
  @HiveField(1)
  String? useName;

  @JsonKey(name: 'email')
  @HiveField(2)
  String? email;

  @JsonKey(name: 'phoneNumber')
  @HiveField(3)
  String? phoneNumber;

  @JsonKey(name: 'fullName')
  @HiveField(5)
  String? fullName;

  @JsonKey(name: 'user_role')
  @HiveField(4)
  String? userRole;

  AccessTokenUser(
      {this.id,
      this.useName,
      this.email,
      this.phoneNumber,
      this.fullName,
      this.userRole});

  factory AccessTokenUser.fromJson(Map<String, dynamic> json) =>
      _$AccessTokenUserFromJson(json);

  Map<String, dynamic> userVMToJson() => _$AccessTokenUserToJson(this);

  @override
  String toString() {
    return 'User{id: $id, useName: $useName, email: $email, phoneNumber: $phoneNumber, fullName: $fullName, userRole: $userRole}';
  }
}
