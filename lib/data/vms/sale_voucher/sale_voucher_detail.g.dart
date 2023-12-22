// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_voucher_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaleVoucherDetailVM _$SaleVoucherDetailVMFromJson(Map<String, dynamic> json) =>
    SaleVoucherDetailVM(
      saleVno: json['saleVno'] as String?,
      customerName: json['customerName'] as String?,
      phone: json['phone'] as String?,
      state: json['state'] as String?,
      township: json['township'] as String?,
      street: json['street'] as String?,
      detailAddress: json['detailAddress'] as String?,
      gglCode: json['gglCode'] as String?,
      qty: json['qty'] as num?,
      goldPrice: json['goldPrice'] as num?,
      charges: json['charges'] as num?,
      gram: json['gram'] as num?,
      kyat: json['kyat'] as num?,
      pae: json['pae'] as num?,
      yawe: json['yawe'] as num?,
      wasteKyat: json['wasteKyat'] as num?,
      wastePae: json['wastePae'] as num?,
      wasteYawe: json['wasteYawe'] as num?,
      totalKyat: json['totalKyat'] as num?,
      totalPae: json['totalPae'] as num?,
      totalYawe: json['totalYawe'] as num?,
      kyat16: json['kyat16'] as num?,
      image: json['image'] as String?,
      pae16: json['pae16'] as num?,
      yawe16: json['yawe16'] as num?,
      itemGemList: (json['itemGemList'] as List<dynamic>?)
          ?.map((e) => ItemGemVM.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalAmt: json['totalAmt'] as num?,
    )
      ..itemName = json['itemName'] as String?
      ..stateName = json['stateName'] as String?
      ..typeName = json['typeName'] as String?;

Map<String, dynamic> _$SaleVoucherDetailVMToJson(
        SaleVoucherDetailVM instance) =>
    <String, dynamic>{
      'saleVno': instance.saleVno,
      'customerName': instance.customerName,
      'phone': instance.phone,
      'state': instance.state,
      'township': instance.township,
      'street': instance.street,
      'detailAddress': instance.detailAddress,
      'itemName': instance.itemName,
      'stateName': instance.stateName,
      'typeName': instance.typeName,
      'gglCode': instance.gglCode,
      'image': instance.image,
      'qty': instance.qty,
      'goldPrice': instance.goldPrice,
      'charges': instance.charges,
      'gram': instance.gram,
      'kyat': instance.kyat,
      'pae': instance.pae,
      'yawe': instance.yawe,
      'wasteKyat': instance.wasteKyat,
      'wastePae': instance.wastePae,
      'wasteYawe': instance.wasteYawe,
      'totalKyat': instance.totalKyat,
      'totalPae': instance.totalPae,
      'totalYawe': instance.totalYawe,
      'kyat16': instance.kyat16,
      'pae16': instance.pae16,
      'yawe16': instance.yawe16,
      'totalAmt': instance.totalAmt,
      'itemGemList': instance.itemGemList,
    };
