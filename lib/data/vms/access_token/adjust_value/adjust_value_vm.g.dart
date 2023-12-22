// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'adjust_value_vm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdjustValueVM _$AdjustValueVMFromJson(Map<String, dynamic> json) =>
    AdjustValueVM(
      settingId: json['settingId'] as num?,
      keyName: json['keyName'] as String?,
      value: json['value'] as num?,
      updateDate: json['updateDate'] as String?,
      userId: json['userId'] as String?,
    );

Map<String, dynamic> _$AdjustValueVMToJson(AdjustValueVM instance) =>
    <String, dynamic>{
      'settingId': instance.settingId,
      'keyName': instance.keyName,
      'value': instance.value,
      'updateDate': instance.updateDate,
      'userId': instance.userId,
    };
