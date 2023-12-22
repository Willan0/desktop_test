// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_voucher.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaleVoucherVM _$SaleVoucherVMFromJson(Map<String, dynamic> json) =>
    SaleVoucherVM(
      saleVno: json['saleVno'] as String?,
      date: json['date'] as String?,
      totalQty: json['totalQty'] as num?,
      customerName: json['customerName'] as String?,
      lat: json['lat'] as num?,
      long: json['long'] as num?,
      customerId: json['customerId'] as String?,
      createdBy: json['createBy'] as String?,
      totalGram: json['totalGram'] as num?,
      totalAmount: json['totalAmt'] as num?,
      kyat16: json['kyat16'] as num?,
      pae16: json['pae16'] as num?,
      yawe16: json['yawe16'] as num?,
      totalWasteKyat: json['totalWasteKyat'] as num?,
      totalWastePae: json['totalWastePae'] as num?,
      totalWasteYawe: json['totalWasteYawe'] as num?,
      totalKyat: json['totalKyat'] as num?,
      totalYawe: json['totalYawe'] as num?,
      totalPae: json['totalPae'] as num?,
      remark: json['remark'] as String?,
      phone: json['phone'] as String?,
      address: json['detailAddress'] as String?,
      deleteDate: json['deleteDate'] as String?,
      deleteBy: json['deleteBy'] as String?,
      deleteRemark: json['deleteRemark'] as String?,
      saleVoucherDetail: (json['saleVoDetailsModel'] as List<dynamic>?)
          ?.map((e) => SaleVoucherDetailVM.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SaleVoucherVMToJson(SaleVoucherVM instance) =>
    <String, dynamic>{
      'saleVno': instance.saleVno,
      'date': instance.date,
      'totalQty': instance.totalQty,
      'lat': instance.lat,
      'long': instance.long,
      'totalGram': instance.totalGram,
      'customerName': instance.customerName,
      'phone': instance.phone,
      'detailAddress': instance.address,
      'customerId': instance.customerId,
      'createBy': instance.createdBy,
      'totalAmt': instance.totalAmount,
      'kyat16': instance.kyat16,
      'pae16': instance.pae16,
      'yawe16': instance.yawe16,
      'totalWasteKyat': instance.totalWasteKyat,
      'totalWastePae': instance.totalWastePae,
      'totalWasteYawe': instance.totalWasteYawe,
      'totalKyat': instance.totalKyat,
      'totalPae': instance.totalPae,
      'totalYawe': instance.totalYawe,
      'remark': instance.remark,
      'deleteDate': instance.deleteDate,
      'deleteBy': instance.deleteBy,
      'deleteRemark': instance.deleteRemark,
      'saleVoDetailsModel': instance.saleVoucherDetail,
    };
