// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grouped_return_voucher.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupedReturnVoucher _$GroupedReturnVoucherFromJson(
        Map<String, dynamic> json) =>
    GroupedReturnVoucher(
      json['count'] as int?,
      json['date'] as String?,
      (json['list'] as List<dynamic>?)
          ?.map((e) => ReturnVoucherVM.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['isCollapse'],
    );

Map<String, dynamic> _$GroupedReturnVoucherToJson(
        GroupedReturnVoucher instance) =>
    <String, dynamic>{
      'count': instance.count,
      'date': instance.date,
      'list': instance.returnVouchers,
      'isCollapse': instance.isCollapse,
    };
