// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LanguageAdapter extends TypeAdapter<Language> {
  @override
  final int typeId = 8;

  @override
  Language read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Language.english;
      case 1:
        return Language.myanmar;
      default:
        return Language.english;
    }
  }

  @override
  void write(BinaryWriter writer, Language obj) {
    switch (obj) {
      case Language.english:
        writer.writeByte(0);
        break;
      case Language.myanmar:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LanguageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
