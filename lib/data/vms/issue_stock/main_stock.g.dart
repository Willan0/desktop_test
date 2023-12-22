// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_stock.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MainStockAdapter extends TypeAdapter<MainStock> {
  @override
  final int typeId = 7;

  @override
  MainStock read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MainStock(
      gglCode: fields[0] as String?,
      itemName: fields[1] as String?,
      stateName: fields[2] as String?,
      stateId: fields[23] as String?,
      quantity: fields[3] as num?,
      gram: fields[4] as num?,
      kyat: fields[5] as num?,
      pae: fields[6] as num?,
      yawe: fields[7] as num?,
      wasteKyat: fields[8] as num?,
      wastePae: fields[9] as num?,
      gram16: fields[19] as num?,
      wasteYawe: fields[10] as num?,
      wasteGram: fields[20] as num?,
      typeName: fields[11] as String?,
      goldPrice: fields[12] as num?,
      kyat16: fields[13] as num?,
      pae16: fields[14] as num?,
      yawe16: fields[15] as num?,
      wKyat16: fields[16] as num?,
      wPae16: fields[17] as num?,
      wYawe16: fields[18] as num?,
      totalAmt16State: fields[21] as num?,
      totalAmt: fields[29] as num?,
      charges: fields[30] as num?,
      image: fields[22] as String?,
      remark: fields[24] as num?,
      tNetKyat: fields[25] as num?,
      tNetPae: fields[26] as num?,
      tNetYawe: fields[27] as num?,
      tNetGram: fields[28] as num?,
    );
  }

  @override
  void write(BinaryWriter writer, MainStock obj) {
    writer
      ..writeByte(31)
      ..writeByte(0)
      ..write(obj.gglCode)
      ..writeByte(1)
      ..write(obj.itemName)
      ..writeByte(2)
      ..write(obj.stateName)
      ..writeByte(23)
      ..write(obj.stateId)
      ..writeByte(11)
      ..write(obj.typeName)
      ..writeByte(12)
      ..write(obj.goldPrice)
      ..writeByte(22)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.quantity)
      ..writeByte(4)
      ..write(obj.gram)
      ..writeByte(5)
      ..write(obj.kyat)
      ..writeByte(6)
      ..write(obj.pae)
      ..writeByte(7)
      ..write(obj.yawe)
      ..writeByte(8)
      ..write(obj.wasteKyat)
      ..writeByte(9)
      ..write(obj.wastePae)
      ..writeByte(10)
      ..write(obj.wasteYawe)
      ..writeByte(13)
      ..write(obj.kyat16)
      ..writeByte(14)
      ..write(obj.pae16)
      ..writeByte(15)
      ..write(obj.yawe16)
      ..writeByte(16)
      ..write(obj.wKyat16)
      ..writeByte(17)
      ..write(obj.wPae16)
      ..writeByte(18)
      ..write(obj.wYawe16)
      ..writeByte(19)
      ..write(obj.gram16)
      ..writeByte(20)
      ..write(obj.wasteGram)
      ..writeByte(21)
      ..write(obj.totalAmt16State)
      ..writeByte(24)
      ..write(obj.remark)
      ..writeByte(25)
      ..write(obj.tNetKyat)
      ..writeByte(26)
      ..write(obj.tNetPae)
      ..writeByte(27)
      ..write(obj.tNetYawe)
      ..writeByte(28)
      ..write(obj.tNetGram)
      ..writeByte(29)
      ..write(obj.totalAmt)
      ..writeByte(30)
      ..write(obj.charges);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MainStockAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MainStock _$MainStockFromJson(Map<String, dynamic> json) => MainStock(
      gglCode: json['gglCode'] as String?,
      itemName: json['itemName'] as String?,
      stateName: json['stateName'] as String?,
      stateId: json['stateId'] as String?,
      quantity: json['quantity'] as num?,
      gram: json['gram'] as num?,
      kyat: json['kyat'] as num?,
      pae: json['pae'] as num?,
      yawe: json['yawe'] as num?,
      wasteKyat: json['wasteKyat'] as num?,
      wastePae: json['wastePae'] as num?,
      gram16: json['gram16'] as num?,
      wasteYawe: json['wasteYawe'] as num?,
      wasteGram: json['wasteGram'] as num?,
      typeName: json['typeName'] as String?,
      goldPrice: json['goldPrice1'] as num?,
      kyat16: json['kyat16'] as num?,
      pae16: json['pae16'] as num?,
      yawe16: json['yawe16'] as num?,
      wKyat16: json['wKyat16'] as num?,
      wPae16: json['wPae16'] as num?,
      wYawe16: json['wYawe16'] as num?,
      totalAmt16State: json['totalAmt16State'] as num?,
      totalAmt: json['totalAmt'] as num?,
      charges: json['charges'] as num?,
      image: json['image'] as String?,
      isSelect: json['isSelect'] as bool? ?? false,
      remark: json['remark'] as num?,
      tNetKyat: json['tNetKyat'] as num?,
      tNetPae: json['tNetPae'] as num?,
      tNetYawe: json['tNetYawe'] as num?,
      tNetGram: json['tNetGram'] as num?,
    );

Map<String, dynamic> _$MainStockToJson(MainStock instance) => <String, dynamic>{
      'gglCode': instance.gglCode,
      'itemName': instance.itemName,
      'stateName': instance.stateName,
      'stateId': instance.stateId,
      'typeName': instance.typeName,
      'goldPrice1': instance.goldPrice,
      'image': instance.image,
      'quantity': instance.quantity,
      'gram': instance.gram,
      'kyat': instance.kyat,
      'pae': instance.pae,
      'yawe': instance.yawe,
      'wasteKyat': instance.wasteKyat,
      'wastePae': instance.wastePae,
      'wasteYawe': instance.wasteYawe,
      'kyat16': instance.kyat16,
      'pae16': instance.pae16,
      'yawe16': instance.yawe16,
      'wKyat16': instance.wKyat16,
      'wPae16': instance.wPae16,
      'wYawe16': instance.wYawe16,
      'gram16': instance.gram16,
      'wasteGram': instance.wasteGram,
      'totalAmt16State': instance.totalAmt16State,
      'remark': instance.remark,
      'tNetKyat': instance.tNetKyat,
      'tNetPae': instance.tNetPae,
      'tNetYawe': instance.tNetYawe,
      'tNetGram': instance.tNetGram,
      'totalAmt': instance.totalAmt,
      'charges': instance.charges,
      'isSelect': instance.isSelect,
    };
