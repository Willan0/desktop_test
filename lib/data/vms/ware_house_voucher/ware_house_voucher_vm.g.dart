// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ware_house_voucher_vm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WareHouseVoucherVM _$WareHouseVoucherVMFromJson(Map<String, dynamic> json) =>
    WareHouseVoucherVM(
      vno: json['vno'] as String?,
      date: json['date'] as String?,
      createBy: json['createBy'] as String?,
      remark: json['remark'] as String?,
      deleteDate: json['deleteDate'] as String?,
      deleteBy: json['deleteBy'] as String?,
      deleteRemark: json['deleteRemark'] as String?,
      voucherDetailModel: (json['voucherDetailModel'] as List<dynamic>?)
          ?.map((e) => WareHouseVoDetailVM.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WareHouseVoucherVMToJson(WareHouseVoucherVM instance) =>
    <String, dynamic>{
      'vno': instance.vno,
      'date': instance.date,
      'createBy': instance.createBy,
      'remark': instance.remark,
      'deleteDate': instance.deleteDate,
      'deleteBy': instance.deleteBy,
      'deleteRemark': instance.deleteRemark,
      'voucherDetailModel': instance.voucherDetailModel,
    };
