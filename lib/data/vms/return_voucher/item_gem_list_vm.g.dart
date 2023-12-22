// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_gem_list_vm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemGemListVM _$ItemGemListVMFromJson(Map<String, dynamic> json) =>
    ItemGemListVM(
      gglCode: json['gglCode'] as String?,
      logNo: json['logNo'] as String?,
      particular: json['particular'] as String?,
      kyat: json['kyat'] as int?,
      pae: json['pae'] as int?,
      yawe: json['yawe'] as int?,
      yati: json['yati'] as int?,
      ct: json['ct'] as int?,
      qty: json['qty'] as int?,
      description: json['description'] as String?,
      salePriceYati: json['salePriceYati'] as int?,
      salePriceCt: json['salePriceCt'] as int?,
      gemAmt: json['gemAmt'] as int?,
    );

Map<String, dynamic> _$ItemGemListVMToJson(ItemGemListVM instance) =>
    <String, dynamic>{
      'gglCode': instance.gglCode,
      'logNo': instance.logNo,
      'particular': instance.particular,
      'kyat': instance.kyat,
      'pae': instance.pae,
      'yawe': instance.yawe,
      'yati': instance.yati,
      'ct': instance.ct,
      'qty': instance.qty,
      'description': instance.description,
      'salePriceYati': instance.salePriceYati,
      'salePriceCt': instance.salePriceCt,
      'gemAmt': instance.gemAmt,
    };
