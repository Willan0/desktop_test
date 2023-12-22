// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grouped_sale_voucher.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupedSaleVoucher _$GroupedSaleVoucherFromJson(Map<String, dynamic> json) =>
    GroupedSaleVoucher(
      json['count'] as num?,
      json['date'] as String?,
      (json['list'] as List<dynamic>?)
          ?.map((e) => SaleVoucherVM.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['isCollapse'],
    );

Map<String, dynamic> _$GroupedSaleVoucherToJson(GroupedSaleVoucher instance) =>
    <String, dynamic>{
      'count': instance.count,
      'date': instance.date,
      'list': instance.saleVouchers,
      'isCollapse': instance.isCollapse,
    };
