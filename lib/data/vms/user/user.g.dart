// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserVMAdapter extends TypeAdapter<UserVM> {
  @override
  final int typeId = 6;

  @override
  UserVM read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserVM(
      userId: fields[0] as String?,
      userName: fields[1] as String?,
      fullName: fields[2] as String?,
      email: fields[3] as String?,
      phone: fields[5] as String?,
      detailAddress: fields[6] as String?,
      status: fields[7] as bool?,
    )..role = fields[4] as String?;
  }

  @override
  void write(BinaryWriter writer, UserVM obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.userName)
      ..writeByte(2)
      ..write(obj.fullName)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.role)
      ..writeByte(5)
      ..write(obj.phone)
      ..writeByte(6)
      ..write(obj.detailAddress)
      ..writeByte(7)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserVMAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserVM _$UserVMFromJson(Map<String, dynamic> json) => UserVM(
      userId: json['userId'] as String?,
      userName: json['userName'] as String?,
      fullName: json['fullName'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      detailAddress: json['detailAddress'] as String?,
      status: json['status'] as bool?,
      balance: json['balance'] as num?,
      gram: json['gram'] as num?,
      kyat: json['kyat'] as num?,
      pae: json['pae'] as num?,
      yawe: json['yawe'] as num?,
      isSelect: json['isSelect'] as bool? ?? false,
    )..role = json['role'] as String?;

Map<String, dynamic> _$UserVMToJson(UserVM instance) => <String, dynamic>{
      'userId': instance.userId,
      'userName': instance.userName,
      'fullName': instance.fullName,
      'email': instance.email,
      'role': instance.role,
      'phone': instance.phone,
      'detailAddress': instance.detailAddress,
      'status': instance.status,
      'balance': instance.balance,
      'gram': instance.gram,
      'kyat': instance.kyat,
      'pae': instance.pae,
      'yawe': instance.yawe,
      'isSelect': instance.isSelect,
    };
