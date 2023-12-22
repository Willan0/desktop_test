// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerPayment _$CustomerPaymentFromJson(Map<String, dynamic> json) =>
    CustomerPayment(
      paymentVno: json['paymentVno'] as String?,
      date: json['date'] as String?,
      lat: json['lat'] as String?,
      long: json['long'] as String?,
      customerId: json['customerId'] as String?,
      customerName: json['customerName'] as String?,
      isGold: json['isGold'] as bool?,
      isDiscount: json['isDiscount'] as bool?,
      goldPrice: json['goldPrice'] as num?,
      totalAmt: json['totalAmt'] as num?,
      gram: json['gram'] as num?,
      kyat: json['kyat'] as num?,
      pae: json['pae'] as num?,
      yawe: json['yawe'] as num?,
      receiveBy: json['receiveBy'] as String?,
      remark: json['remark'] as String?,
      deleteDate: json['deleteDate'] as String?,
      deleteBy: json['deleteBy'] as String?,
      deleteRemark: json['deleteRemark'] as String?,
    );

Map<String, dynamic> _$CustomerPaymentToJson(CustomerPayment instance) =>
    <String, dynamic>{
      'paymentVno': instance.paymentVno,
      'date': instance.date,
      'lat': instance.lat,
      'long': instance.long,
      'customerId': instance.customerId,
      'customerName': instance.customerName,
      'isGold': instance.isGold,
      'isDiscount': instance.isDiscount,
      'goldPrice': instance.goldPrice,
      'totalAmt': instance.totalAmt,
      'gram': instance.gram,
      'kyat': instance.kyat,
      'pae': instance.pae,
      'yawe': instance.yawe,
      'receiveBy': instance.receiveBy,
      'remark': instance.remark,
      'deleteDate': instance.deleteDate,
      'deleteBy': instance.deleteBy,
      'deleteRemark': instance.deleteRemark,
    };
