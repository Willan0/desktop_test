import 'package:desktop_test/constant/dao_constant.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
@HiveType(typeId: kTypeIdForCustomer)
class UserVM {
  @JsonKey(name: 'userId')
  @HiveField(0)
  String? userId;

  @JsonKey(name: 'userName')
  @HiveField(1)
  String? userName;

  @JsonKey(name: 'fullName')
  @HiveField(2)
  String? fullName;

  @JsonKey(name: 'email')
  @HiveField(3)
  String? email;

  @JsonKey(name: 'role')
  @HiveField(4)
  String? role;

  @JsonKey(name: 'phone')
  @HiveField(5)
  String? phone;

  @JsonKey(name: 'detailAddress')
  @HiveField(6)
  String? detailAddress;

  @JsonKey(name: 'status')
  @HiveField(7)
  bool? status;

  @JsonKey(name: 'balance')
  num? balance;

  @JsonKey(name: 'gram')
  num? gram;

  @JsonKey(name: "kyat")
  num? kyat;

  @JsonKey(name: "pae")
  num? pae;

  @JsonKey(name: 'yawe')
  num? yawe;

  bool isSelect;

  UserVM(
      {this.userId,
      this.userName,
      this.fullName,
      this.email,
      this.phone,
      this.detailAddress,
      this.status,
      this.balance,
      this.gram,
      this.kyat,
      this.pae,
      this.yawe,
      this.isSelect = false});

  factory UserVM.fromJson(Map<String, dynamic> json) => _$UserVMFromJson(json);
}
