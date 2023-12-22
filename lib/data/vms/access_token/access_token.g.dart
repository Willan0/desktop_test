// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'access_token.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AccessTokenAdapter extends TypeAdapter<AccessToken> {
  @override
  final int typeId = 2;

  @override
  AccessToken read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AccessToken(
      accessToken: fields[0] as String?,
      refreshToken: fields[1] as String?,
      expiration: fields[2] as int?,
      user: fields[3] as AccessTokenUser?,
    );
  }

  @override
  void write(BinaryWriter writer, AccessToken obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.accessToken)
      ..writeByte(1)
      ..write(obj.refreshToken)
      ..writeByte(2)
      ..write(obj.expiration)
      ..writeByte(3)
      ..write(obj.user);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccessTokenAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccessToken _$AccessTokenFromJson(Map<String, dynamic> json) => AccessToken(
      accessToken: json['access_token'] as String?,
      refreshToken: json['refresh_token'] as String?,
      expiration: json['expiration'] as int?,
      user: json['user'] == null
          ? null
          : AccessTokenUser.fromJson(json['user'] as Map<String, dynamic>),
      adjustValues: (json['adjust_values'] as List<dynamic>?)
          ?.map((e) => AdjustValueVM.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AccessTokenToJson(AccessToken instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
      'expiration': instance.expiration,
      'user': instance.user,
      'adjust_values': instance.adjustValues,
    };
