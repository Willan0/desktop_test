// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'issue_vo_detail_vm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IssueVoDetailVM _$IssueVoDetailVMFromJson(Map<String, dynamic> json) =>
    IssueVoDetailVM(
      issueVno: json['issueVno'] as String?,
      gglCode: json['gglCode'] as String?,
      itemName: json['itemName'] as String?,
      stock: json['stock'] as int?,
      stateId: json['stateId'] as String?,
      stateName: json['stateName'] as String?,
      typeCode: json['typeCode'] as String?,
      typeName: json['typeName'] as String?,
      qty: json['qty'] as int?,
      originalGram: json['originalGram'] as int?,
      gram: json['gram'] as int?,
      kyat: json['kyat'] as int?,
      pae: json['pae'] as int?,
      yawe: json['yawe'] as int?,
    );

Map<String, dynamic> _$IssueVoDetailVMToJson(IssueVoDetailVM instance) =>
    <String, dynamic>{
      'issueVno': instance.issueVno,
      'gglCode': instance.gglCode,
      'itemName': instance.itemName,
      'stock': instance.stock,
      'stateId': instance.stateId,
      'stateName': instance.stateName,
      'typeCode': instance.typeCode,
      'typeName': instance.typeName,
      'qty': instance.qty,
      'originalGram': instance.originalGram,
      'gram': instance.gram,
      'kyat': instance.kyat,
      'pae': instance.pae,
      'yawe': instance.yawe,
    };
