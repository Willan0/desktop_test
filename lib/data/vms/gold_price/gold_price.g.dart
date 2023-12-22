// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gold_price.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoldPrice _$GoldPriceFromJson(Map<String, dynamic> json) => GoldPrice(
      stateName: json['stateName'] as String?,
      stateId: json['stateId'] as String?,
      date: json['date'] as String?,
      goldPrice: json['goldPrice1'] as num?,
      currentUse: json['currentUse'] as bool?,
    );

Map<String, dynamic> _$GoldPriceToJson(GoldPrice instance) => <String, dynamic>{
      'stateName': instance.stateName,
      'stateId': instance.stateId,
      'date': instance.date,
      'goldPrice1': instance.goldPrice,
      'currentUse': instance.currentUse,
    };
