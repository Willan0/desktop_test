import 'package:desktop_test/constant/dao_constant.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'item_waste_vm.g.dart';

@JsonSerializable()
@HiveType(typeId: kTypeIdForItemWaste)
class ItemWasteVM {
  @JsonKey(name: 'gglCode')
  @HiveField(0)
  String? gglCode;

  @JsonKey(name: 'wasteId')
  @HiveField(1)
  num? wasteId;

  @JsonKey(name: 'minQty')
  @HiveField(2)
  num? minQty;

  @JsonKey(name: 'maxQty')
  @HiveField(3)
  num? maxQty;

  @JsonKey(name: 'wasteKyat')
  @HiveField(4)
  num? wasteKyat;

  @JsonKey(name: 'wastePae')
  @HiveField(5)
  num? wastePae;

  @JsonKey(name: 'wasteYawe')
  @HiveField(6)
  num? wasteYawe;

  @HiveField(7)
  num? wasteGram;

  ItemWasteVM(
      {this.gglCode,
      this.wasteId,
      this.minQty,
      this.maxQty,
      this.wasteKyat,
      this.wastePae,
      this.wasteGram,
      this.wasteYawe});

  factory ItemWasteVM.fromJson(Map<String, dynamic> json) =>
      _$ItemWasteVMFromJson(json);

  Map<String, dynamic> itemWasteVMToJson() => _$ItemWasteVMToJson(this);

  @override
  String toString() {
    return 'ItemWasteVM{gglCode: $gglCode, wasteId: $wasteId, minQty: $minQty, maxQty: $maxQty, wasteKyat: $wasteKyat, wastePae: $wastePae, wasteYawe: $wasteYawe}';
  }
}
