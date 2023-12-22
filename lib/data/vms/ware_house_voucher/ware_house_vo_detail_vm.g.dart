// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ware_house_vo_detail_vm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WareHouseVoDetailVM _$WareHouseVoDetailVMFromJson(Map<String, dynamic> json) =>
    WareHouseVoDetailVM(
      vno: json['vno'] as String?,
      gglCode: json['gglCode'] as String?,
      itemName: json['itemName'] as String?,
      qty: json['qty'] as int?,
      gram: json['gram'] as int?,
      kyat: json['kyat'] as int?,
      pae: json['pae'] as int?,
      yawe: json['yawe'] as int?,
    );

Map<String, dynamic> _$WareHouseVoDetailVMToJson(
        WareHouseVoDetailVM instance) =>
    <String, dynamic>{
      'vno': instance.vno,
      'gglCode': instance.gglCode,
      'itemName': instance.itemName,
      'qty': instance.qty,
      'gram': instance.gram,
      'kyat': instance.kyat,
      'pae': instance.pae,
      'yawe': instance.yawe,
    };
