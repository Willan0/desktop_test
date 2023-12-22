// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'return_voucher_detail_vm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReturnVoucherDetailVM _$ReturnVoucherDetailVMFromJson(
        Map<String, dynamic> json) =>
    ReturnVoucherDetailVM(
      returnVno: json['returnVno'] as String?,
      gglCode: json['gglCode'] as String?,
      customerName: json['customerName'] as String?,
      phone: json['phone'] as String?,
      state: json['state'] as String?,
      township: json['township'] as String?,
      street: json['street'] as String?,
      detailAddress: json['detailAddress'] as String?,
      itemName: json['itemName'] as String?,
      stateName: json['stateName'] as String?,
      typeName: json['typeName'] as String?,
      image: json['image'] as String?,
      qty: json['qty'] as num?,
      goldPrice: json['goldPrice'] as num?,
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
      pae16: json['pae16'] as num?,
      yawe16: json['yawe16'] as num?,
      totalAmt: json['totalAmt'] as num?,
      itemGemLists: (json['itemGemLists'] as List<dynamic>?)
          ?.map((e) => ItemGemListVM.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReturnVoucherDetailVMToJson(
        ReturnVoucherDetailVM instance) =>
    <String, dynamic>{
      'returnVno': instance.returnVno,
      'customerName': instance.customerName,
      'phone': instance.phone,
      'state': instance.state,
      'township': instance.township,
      'street': instance.street,
      'detailAddress': instance.detailAddress,
      'gglCode': instance.gglCode,
      'itemName': instance.itemName,
      'stateName': instance.stateName,
      'typeName': instance.typeName,
      'image': instance.image,
      'qty': instance.qty,
      'goldPrice': instance.goldPrice,
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
      'itemGemLists': instance.itemGemLists,
    };
