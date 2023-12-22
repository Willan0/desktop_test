// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grouped_customer_payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupedCustomerPayment _$GroupedCustomerPaymentFromJson(
        Map<String, dynamic> json) =>
    GroupedCustomerPayment(
      count: json['count'] as num?,
      date: json['date'] as String?,
      customerPayments: (json['list'] as List<dynamic>?)
          ?.map((e) => CustomerPayment.fromJson(e as Map<String, dynamic>))
          .toList(),
      isCollapse: json['isCollapse'],
    );

Map<String, dynamic> _$GroupedCustomerPaymentToJson(
        GroupedCustomerPayment instance) =>
    <String, dynamic>{
      'count': instance.count,
      'date': instance.date,
      'list': instance.customerPayments,
      'isCollapse': instance.isCollapse,
    };
