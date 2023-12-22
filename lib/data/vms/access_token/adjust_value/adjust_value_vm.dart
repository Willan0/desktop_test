import 'package:json_annotation/json_annotation.dart';
part 'adjust_value_vm.g.dart';
@JsonSerializable()
class AdjustValueVM{
  @JsonKey(name: 'settingId')
  num? settingId;

  @JsonKey(name: 'keyName')
  String? keyName;

  @JsonKey(name: 'value')
  num? value;

  @JsonKey(name: 'updateDate')
  String? updateDate;

  @JsonKey(name: 'userId')
  String? userId;

  AdjustValueVM(
  {this.settingId, this.keyName, this.value, this.updateDate, this.userId});

  factory AdjustValueVM.fromJson(Map<String,dynamic> json)=> _$AdjustValueVMFromJson(json);

  Map<String,dynamic> toJson()=> _$AdjustValueVMToJson(this);
}