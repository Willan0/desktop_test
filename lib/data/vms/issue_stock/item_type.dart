import 'package:json_annotation/json_annotation.dart';
part 'item_type.g.dart';
@JsonSerializable()
class ItemType{
  @JsonKey(name: 'typeCode')
  String? typeCode;

  @JsonKey(name: 'typeName')
  String? typeName;

  ItemType({this.typeCode,this.typeName});
  factory ItemType.fromJson(Map<String,dynamic> json)=> _$ItemTypeFromJson(json);

  Map<String,dynamic> toJson()=> _$ItemTypeToJson(this);
}