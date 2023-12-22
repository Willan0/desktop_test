// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_gem_vm.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ItemGemVMAdapter extends TypeAdapter<ItemGemVM> {
  @override
  final int typeId = 4;

  @override
  ItemGemVM read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ItemGemVM(
      gglCode: fields[0] as String?,
      logNo: fields[1] as String?,
      particular: fields[2] as String?,
      kyat: fields[3] as num?,
      pae: fields[4] as num?,
      yawe: fields[5] as num?,
      yati: fields[6] as num?,
      ct: fields[7] as num?,
      qty: fields[8] as num?,
      description: fields[9] as String?,
      salePriceYati: fields[10] as num?,
      salePriceCt: fields[11] as num?,
      gemAmt: fields[12] as num?,
    );
  }

  @override
  void write(BinaryWriter writer, ItemGemVM obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.gglCode)
      ..writeByte(1)
      ..write(obj.logNo)
      ..writeByte(2)
      ..write(obj.particular)
      ..writeByte(3)
      ..write(obj.kyat)
      ..writeByte(4)
      ..write(obj.pae)
      ..writeByte(5)
      ..write(obj.yawe)
      ..writeByte(6)
      ..write(obj.yati)
      ..writeByte(7)
      ..write(obj.ct)
      ..writeByte(8)
      ..write(obj.qty)
      ..writeByte(9)
      ..write(obj.description)
      ..writeByte(10)
      ..write(obj.salePriceYati)
      ..writeByte(11)
      ..write(obj.salePriceCt)
      ..writeByte(12)
      ..write(obj.gemAmt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemGemVMAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemGemVM _$ItemGemVMFromJson(Map<String, dynamic> json) => ItemGemVM(
      gglCode: json['gglCode'] as String?,
      logNo: json['logNo'] as String?,
      particular: json['particular'] as String?,
      kyat: json['kyat'] as num?,
      pae: json['pae'] as num?,
      yawe: json['yawe'] as num?,
      yati: json['yati'] as num?,
      ct: json['ct'] as num?,
      qty: json['qty'] as num?,
      description: json['description'] as String?,
      salePriceYati: json['salePriceYati'] as num?,
      salePriceCt: json['salePriceCt'] as num?,
      gemAmt: json['gemAmt'] as num?,
    );

Map<String, dynamic> _$ItemGemVMToJson(ItemGemVM instance) => <String, dynamic>{
      'gglCode': instance.gglCode,
      'logNo': instance.logNo,
      'particular': instance.particular,
      'kyat': instance.kyat,
      'pae': instance.pae,
      'yawe': instance.yawe,
      'yati': instance.yati,
      'ct': instance.ct,
      'qty': instance.qty,
      'description': instance.description,
      'salePriceYati': instance.salePriceYati,
      'salePriceCt': instance.salePriceCt,
      'gemAmt': instance.gemAmt,
    };
