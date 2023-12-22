import 'package:desktop_test/constant/dao_constant.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'item_gem_vm.g.dart';

@JsonSerializable()
@HiveType(typeId: kTypeIdForItemGem)
class ItemGemVM {
  @JsonKey(name: 'gglCode')
  @HiveField(0)
  String? gglCode;

  @JsonKey(name: 'logNo')
  @HiveField(1)
  String? logNo;

  @JsonKey(name: 'particular')
  @HiveField(2)
  String? particular;

  @JsonKey(name: 'kyat')
  @HiveField(3)
  num? kyat;

  @JsonKey(name: 'pae')
  @HiveField(4)
  num? pae;

  @JsonKey(name: 'yawe')
  @HiveField(5)
  num? yawe;

  @JsonKey(name: 'yati')
  @HiveField(6)
  num? yati;

  @JsonKey(name: 'ct')
  @HiveField(7)
  num? ct;

  @JsonKey(name: 'qty')
  @HiveField(8)
  num? qty;

  @JsonKey(name: 'description')
  @HiveField(9)
  String? description;

  @JsonKey(name: 'salePriceYati')
  @HiveField(10)
  num? salePriceYati;

  @JsonKey(name: 'salePriceCt')
  @HiveField(11)
  num? salePriceCt;

  @JsonKey(name: 'gemAmt')
  @HiveField(12)
  num? gemAmt;

  ItemGemVM(
      {this.gglCode,
      this.logNo,
      this.particular,
      this.kyat,
      this.pae,
      this.yawe,
      this.yati,
      this.ct,
      this.qty,
      this.description,
      this.salePriceYati,
      this.salePriceCt,
      this.gemAmt});

  factory ItemGemVM.fromJson(Map<String, dynamic> json) =>
      _$ItemGemVMFromJson(json);
  Map<String, dynamic> itemGemVMToJson() => _$ItemGemVMToJson(this);

  @override
  String toString() {
    return 'ItemGemVM{gglCode: $gglCode, logNo: $logNo, particular: $particular, kyat: $kyat, pae: $pae, yawe: $yawe, yati: $yati, ct: $ct, qty: $qty, description: $description, salePriceYati: $salePriceYati, salePriceCt: $salePriceCt, gemAmt: $gemAmt}';
  }
}
