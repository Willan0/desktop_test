// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_voucher.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransferVoucherVM _$TransferVoucherVMFromJson(Map<String, dynamic> json) =>
    TransferVoucherVM(
      transferVno: json['transferVno'] as String?,
      date: json['date'] as String?,
      lat: json['lat'] as num?,
      long: json['long'] as num?,
      transferUserId: json['transferUserId'] as String?,
      transferUserName: json['transferUserName'] as String?,
      transferTo: json['transferTo'] as String?,
      totalQty: json['totalQty'] as num?,
      totalGram: json['totalGram'] as num?,
      totalKyat: json['totalKyat'] as num?,
      totalPae: json['totalPae'] as num?,
      totalYawe: json['totalYawe'] as num?,
      kyat16: json['kyat16'] as num?,
      pae16: json['pae16'] as num?,
      yawe16: json['yawe16'] as num?,
      recepentUserId: json['recepentUserId'] as String?,
      recepentUser: json['recepentUser'] as String?,
      receiveDate: json['receiveDate'] as String?,
      receivedBy: json['receiveBy'] as String?,
      remark: json['remark'] as String?,
      transferVoucherDetail: (json['transferVoDetails'] as List<dynamic>?)
          ?.map((e) =>
              TransferVoucherDetailVM.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TransferVoucherVMToJson(TransferVoucherVM instance) =>
    <String, dynamic>{
      'transferVno': instance.transferVno,
      'date': instance.date,
      'lat': instance.lat,
      'long': instance.long,
      'transferUserId': instance.transferUserId,
      'transferUserName': instance.transferUserName,
      'transferTo': instance.transferTo,
      'totalQty': instance.totalQty,
      'totalGram': instance.totalGram,
      'totalKyat': instance.totalKyat,
      'totalPae': instance.totalPae,
      'totalYawe': instance.totalYawe,
      'kyat16': instance.kyat16,
      'pae16': instance.pae16,
      'yawe16': instance.yawe16,
      'recepentUserId': instance.recepentUserId,
      'recepentUser': instance.recepentUser,
      'receiveDate': instance.receiveDate,
      'receiveBy': instance.receivedBy,
      'remark': instance.remark,
      'transferVoDetails': instance.transferVoucherDetail,
    };
