// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'return_voucher.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReturnVoucherVM _$ReturnVoucherVMFromJson(Map<String, dynamic> json) =>
    ReturnVoucherVM(
      returnVno: json['returnVno'] as String?,
      date: json['date'] as String?,
      totalQty: json['totalQty'] as num?,
      lat: json['lat'] as num?,
      long: json['long'] as num?,
      customerId: json['customerId'] as String?,
      createBy: json['createBy'] as String?,
      totalAmt: json['totalAmt'] as num?,
      totalGram: json['totalGram'] as num?,
      totalWasteKyat: json['totalWasteKyat'] as num?,
      totalWastePae: json['totalWastePae'] as num?,
      totalWasteYawe: json['totalWasteYawe'] as num?,
      totalKyat: json['totalKyat'] as num?,
      totalPae: json['totalPae'] as num?,
      totalYawe: json['totalYawe'] as num?,
      kyat16: json['kyat16'] as num?,
      pae16: json['pae16'] as num?,
      yawe16: json['yawe16'] as num?,
      remark: json['remark'] as String?,
      warehouseReceiveDate: json['warehouseReceiveDate'] as String?,
      warehouseReceiveBy: json['warehouseReceiveBy'] as String?,
      warehouseReceiveRemark: json['warehouseReceiveRemark'] as String?,
      deleteDate: json['deleteDate'] as String?,
      deleteBy: json['deleteBy'] as String?,
      deleteRemark: json['deleteRemark'] as String?,
      voucherDetailModel: (json['voucherDetailModel'] as List<dynamic>?)
          ?.map(
              (e) => ReturnVoucherDetailVM.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReturnVoucherVMToJson(ReturnVoucherVM instance) =>
    <String, dynamic>{
      'returnVno': instance.returnVno,
      'date': instance.date,
      'totalQty': instance.totalQty,
      'lat': instance.lat,
      'long': instance.long,
      'customerId': instance.customerId,
      'createBy': instance.createBy,
      'totalAmt': instance.totalAmt,
      'totalGram': instance.totalGram,
      'totalWasteKyat': instance.totalWasteKyat,
      'totalWastePae': instance.totalWastePae,
      'totalWasteYawe': instance.totalWasteYawe,
      'totalKyat': instance.totalKyat,
      'totalPae': instance.totalPae,
      'totalYawe': instance.totalYawe,
      'kyat16': instance.kyat16,
      'pae16': instance.pae16,
      'yawe16': instance.yawe16,
      'remark': instance.remark,
      'warehouseReceiveDate': instance.warehouseReceiveDate,
      'warehouseReceiveBy': instance.warehouseReceiveBy,
      'warehouseReceiveRemark': instance.warehouseReceiveRemark,
      'deleteDate': instance.deleteDate,
      'deleteBy': instance.deleteBy,
      'deleteRemark': instance.deleteRemark,
      'voucherDetailModel': instance.voucherDetailModel,
    };
