// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_waste_vm.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ItemWasteVMAdapter extends TypeAdapter<ItemWasteVM> {
  @override
  final int typeId = 5;

  @override
  ItemWasteVM read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ItemWasteVM(
      gglCode: fields[0] as String?,
      wasteId: fields[1] as num?,
      minQty: fields[2] as num?,
      maxQty: fields[3] as num?,
      wasteKyat: fields[4] as num?,
      wastePae: fields[5] as num?,
      wasteGram: fields[7] as num?,
      wasteYawe: fields[6] as num?,
    );
  }

  @override
  void write(BinaryWriter writer, ItemWasteVM obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.gglCode)
      ..writeByte(1)
      ..write(obj.wasteId)
      ..writeByte(2)
      ..write(obj.minQty)
      ..writeByte(3)
      ..write(obj.maxQty)
      ..writeByte(4)
      ..write(obj.wasteKyat)
      ..writeByte(5)
      ..write(obj.wastePae)
      ..writeByte(6)
      ..write(obj.wasteYawe)
      ..writeByte(7)
      ..write(obj.wasteGram);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemWasteVMAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemWasteVM _$ItemWasteVMFromJson(Map<String, dynamic> json) => ItemWasteVM(
      gglCode: json['gglCode'] as String?,
      wasteId: json['wasteId'] as num?,
      minQty: json['minQty'] as num?,
      maxQty: json['maxQty'] as num?,
      wasteKyat: json['wasteKyat'] as num?,
      wastePae: json['wastePae'] as num?,
      wasteGram: json['wasteGram'] as num?,
      wasteYawe: json['wasteYawe'] as num?,
    );

Map<String, dynamic> _$ItemWasteVMToJson(ItemWasteVM instance) =>
    <String, dynamic>{
      'gglCode': instance.gglCode,
      'wasteId': instance.wasteId,
      'minQty': instance.minQty,
      'maxQty': instance.maxQty,
      'wasteKyat': instance.wasteKyat,
      'wastePae': instance.wastePae,
      'wasteYawe': instance.wasteYawe,
      'wasteGram': instance.wasteGram,
    };
