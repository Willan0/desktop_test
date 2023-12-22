// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'issue_stock_vm.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IssueStockVMAdapter extends TypeAdapter<IssueStockVM> {
  @override
  final int typeId = 3;

  @override
  IssueStockVM read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IssueStockVM(
      gglCode: fields[0] as String?,
      itemName: fields[1] as String?,
      stateId: fields[2] as String?,
      stateName: fields[3] as String?,
      typeCode: fields[4] as String?,
      typeName: fields[5] as String?,
      userId: fields[6] as String?,
      userName: fields[7] as String?,
      fullName: fields[8] as String?,
      image: fields[16] as String?,
      qty: fields[9] as num?,
      gram: fields[10] as num?,
      kyat: fields[11] as num?,
      pae: fields[12] as num?,
      yawe: fields[13] as num?,
      itemWasteList: (fields[14] as List?)?.cast<ItemWasteVM>(),
      itemGemList: (fields[15] as List?)?.cast<ItemGemVM>(),
      goldPrice: fields[17] as num?,
      kyat16: fields[18] as num?,
      pae16: fields[19] as num?,
      yawe16: fields[20] as num?,
      wYawe16: fields[24] as num?,
      wPae16: fields[23] as num?,
      wKyat16: fields[22] as num?,
      gram16: fields[21] as num?,
      totalAmt16State: fields[25] as num?,
      totalAmt: fields[26] as num?,
      charges: fields[27] as num?,
    );
  }

  @override
  void write(BinaryWriter writer, IssueStockVM obj) {
    writer
      ..writeByte(28)
      ..writeByte(0)
      ..write(obj.gglCode)
      ..writeByte(1)
      ..write(obj.itemName)
      ..writeByte(2)
      ..write(obj.stateId)
      ..writeByte(3)
      ..write(obj.stateName)
      ..writeByte(4)
      ..write(obj.typeCode)
      ..writeByte(5)
      ..write(obj.typeName)
      ..writeByte(16)
      ..write(obj.image)
      ..writeByte(6)
      ..write(obj.userId)
      ..writeByte(7)
      ..write(obj.userName)
      ..writeByte(8)
      ..write(obj.fullName)
      ..writeByte(9)
      ..write(obj.qty)
      ..writeByte(10)
      ..write(obj.gram)
      ..writeByte(11)
      ..write(obj.kyat)
      ..writeByte(12)
      ..write(obj.pae)
      ..writeByte(13)
      ..write(obj.yawe)
      ..writeByte(14)
      ..write(obj.itemWasteList)
      ..writeByte(15)
      ..write(obj.itemGemList)
      ..writeByte(17)
      ..write(obj.goldPrice)
      ..writeByte(18)
      ..write(obj.kyat16)
      ..writeByte(19)
      ..write(obj.pae16)
      ..writeByte(20)
      ..write(obj.yawe16)
      ..writeByte(21)
      ..write(obj.gram16)
      ..writeByte(22)
      ..write(obj.wKyat16)
      ..writeByte(23)
      ..write(obj.wPae16)
      ..writeByte(24)
      ..write(obj.wYawe16)
      ..writeByte(25)
      ..write(obj.totalAmt16State)
      ..writeByte(26)
      ..write(obj.totalAmt)
      ..writeByte(27)
      ..write(obj.charges);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IssueStockVMAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IssueStockVM _$IssueStockVMFromJson(Map<String, dynamic> json) => IssueStockVM(
      gglCode: json['gglCode'] as String?,
      itemName: json['itemName'] as String?,
      stateId: json['stateId'] as String?,
      stateName: json['stateName'] as String?,
      typeCode: json['typeCode'] as String?,
      typeName: json['typeName'] as String?,
      userId: json['userId'] as String?,
      userName: json['userName'] as String?,
      fullName: json['fullName'] as String?,
      image: json['image'] as String?,
      qty: json['qty'] as num?,
      gram: json['gram'] as num?,
      kyat: json['kyat'] as num?,
      pae: json['pae'] as num?,
      yawe: json['yawe'] as num?,
      itemWasteList: (json['itemWasteList'] as List<dynamic>?)
          ?.map((e) => ItemWasteVM.fromJson(e as Map<String, dynamic>))
          .toList(),
      itemGemList: (json['itemGemList'] as List<dynamic>?)
          ?.map((e) => ItemGemVM.fromJson(e as Map<String, dynamic>))
          .toList(),
      goldPrice: json['goldPrice'] as num?,
      kyat16: json['kyat16'] as num?,
      pae16: json['pae16'] as num?,
      yawe16: json['yawe16'] as num?,
      wYawe16: json['wYawe16'] as num?,
      wPae16: json['wPae16'] as num?,
      wKyat16: json['wKyat16'] as num?,
      gram16: json['gram16'] as num?,
      totalAmt16State: json['totalAmt16State'] as num?,
      totalAmt: json['totalAmt'] as num?,
      charges: json['charges'] as num?,
      isSelect: json['isSelect'] as bool? ?? false,
    );

Map<String, dynamic> _$IssueStockVMToJson(IssueStockVM instance) =>
    <String, dynamic>{
      'gglCode': instance.gglCode,
      'itemName': instance.itemName,
      'stateId': instance.stateId,
      'stateName': instance.stateName,
      'typeCode': instance.typeCode,
      'typeName': instance.typeName,
      'image': instance.image,
      'userId': instance.userId,
      'userName': instance.userName,
      'fullName': instance.fullName,
      'qty': instance.qty,
      'gram': instance.gram,
      'kyat': instance.kyat,
      'pae': instance.pae,
      'yawe': instance.yawe,
      'itemWasteList': instance.itemWasteList,
      'itemGemList': instance.itemGemList,
      'goldPrice': instance.goldPrice,
      'kyat16': instance.kyat16,
      'pae16': instance.pae16,
      'yawe16': instance.yawe16,
      'gram16': instance.gram16,
      'wKyat16': instance.wKyat16,
      'wPae16': instance.wPae16,
      'wYawe16': instance.wYawe16,
      'totalAmt16State': instance.totalAmt16State,
      'totalAmt': instance.totalAmt,
      'charges': instance.charges,
      'isSelect': instance.isSelect,
    };
