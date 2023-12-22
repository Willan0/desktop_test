// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grouped_transfer_voucher.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupedTransferVoucher _$GroupedTransferVoucherFromJson(
        Map<String, dynamic> json) =>
    GroupedTransferVoucher(
      count: json['count'] as num?,
      date: json['date'] as String?,
      transferVouchers: (json['list'] as List<dynamic>?)
          ?.map((e) => TransferVoucherVM.fromJson(e as Map<String, dynamic>))
          .toList(),
      isCollapse: json['isCollapse'],
    );

Map<String, dynamic> _$GroupedTransferVoucherToJson(
        GroupedTransferVoucher instance) =>
    <String, dynamic>{
      'count': instance.count,
      'date': instance.date,
      'list': instance.transferVouchers,
      'isCollapse': instance.isCollapse,
    };
