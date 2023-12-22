// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'access_token_user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AccessTokenUserAdapter extends TypeAdapter<AccessTokenUser> {
  @override
  final int typeId = 1;

  @override
  AccessTokenUser read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AccessTokenUser(
      id: fields[0] as String?,
      useName: fields[1] as String?,
      email: fields[2] as String?,
      phoneNumber: fields[3] as String?,
      fullName: fields[5] as String?,
      userRole: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AccessTokenUser obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.useName)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.phoneNumber)
      ..writeByte(5)
      ..write(obj.fullName)
      ..writeByte(4)
      ..write(obj.userRole);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccessTokenUserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccessTokenUser _$AccessTokenUserFromJson(Map<String, dynamic> json) =>
    AccessTokenUser(
      id: json['id'] as String?,
      useName: json['userName'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      fullName: json['fullName'] as String?,
      userRole: json['user_role'] as String?,
    );

Map<String, dynamic> _$AccessTokenUserToJson(AccessTokenUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userName': instance.useName,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'fullName': instance.fullName,
      'user_role': instance.userRole,
    };
