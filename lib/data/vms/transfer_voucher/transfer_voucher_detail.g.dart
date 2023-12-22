// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_voucher_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransferVoucherDetailVM _$TransferVoucherDetailVMFromJson(
        Map<String, dynamic> json) =>
    TransferVoucherDetailVM(
      transferVno: json['transferVno'] as String?,
      transferUserName: json['transferUserName'] as String?,
      receiveUser: json['receiveUser'] as String?,
      gglCode: json['gglCode'] as String?,
      stateName: json['stateName'] as String?,
      itemName: json['itemName'] as String?,
      image: json['image'] as String?,
      qty: json['qty'] as num?,
      gram: json['gram'] as num?,
      kyat: json['kyat'] as num?,
      pae: json['pae'] as num?,
      yawe: json['yawe'] as num?,
      itemGemList: (json['itemGemList'] as List<dynamic>?)
          ?.map((e) => ItemGemVM.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TransferVoucherDetailVMToJson(
        TransferVoucherDetailVM instance) =>
    <String, dynamic>{
      'transferVno': instance.transferVno,
      'transferUserName': instance.transferUserName,
      'receiveUser': instance.receiveUser,
      'gglCode': instance.gglCode,
      'itemName': instance.itemName,
      'stateName': instance.stateName,
      'image': instance.image,
      'qty': instance.qty,
      'gram': instance.gram,
      'kyat': instance.kyat,
      'pae': instance.pae,
      'yawe': instance.yawe,
      'itemGemList': instance.itemGemList,
    };
