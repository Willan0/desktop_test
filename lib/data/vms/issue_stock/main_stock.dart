import 'package:desktop_test/constant/dao_constant.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'main_stock.g.dart';

@JsonSerializable()
@HiveType(typeId: kTypeIdForMainStock)
class MainStock {
  @JsonKey(name: 'gglCode')
  @HiveField(0)
  String? gglCode;

  @JsonKey(name: 'itemName')
  @HiveField(1)
  String? itemName;

  @JsonKey(name: 'stateName')
  @HiveField(2)
  String? stateName;

  @JsonKey(name: 'stateId')
  @HiveField(23)
  String? stateId;

  @JsonKey(name: 'typeName')
  @HiveField(11)
  String? typeName;

  @JsonKey(name: 'goldPrice1')
  @HiveField(12)
  num? goldPrice;

  @JsonKey(name: 'image')
  @HiveField(22)
  String? image;

  @HiveField(3)
  num? quantity;

  @HiveField(4)
  num? gram;

  @HiveField(5)
  num? kyat;

  @HiveField(6)
  num? pae;

  @HiveField(7)
  num? yawe;

  @HiveField(8)
  num? wasteKyat;

  @HiveField(9)
  num? wastePae;

  @HiveField(10)
  num? wasteYawe;

  @HiveField(13)
  num? kyat16;

  @HiveField(14)
  num? pae16;

  @HiveField(15)
  num? yawe16;

  @HiveField(16)
  num? wKyat16;

  @HiveField(17)
  num? wPae16;

  @HiveField(18)
  num? wYawe16;

  @HiveField(19)
  num? gram16;

  @HiveField(20)
  num? wasteGram;

  @HiveField(21)
  num? totalAmt16State;

  @HiveField(24)
  num? remark;

  @HiveField(25)
  num? tNetKyat;

  @HiveField(26)
  num? tNetPae;

  @HiveField(27)
  num? tNetYawe;

  @HiveField(28)
  num? tNetGram;

  @HiveField(29)
  num? totalAmt;

  @HiveField(30)
  num? charges;

  MainStock(
      {this.gglCode,
      this.itemName,
      this.stateName,
      this.stateId,
      this.quantity,
      this.gram,
      this.kyat,
      this.pae,
      this.yawe,
      this.wasteKyat,
      this.wastePae,
      this.gram16,
      this.wasteYawe,
      this.wasteGram,
      this.typeName,
      this.goldPrice,
      this.kyat16,
      this.pae16,
      this.yawe16,
      this.wKyat16,
      this.wPae16,
      this.wYawe16,
      this.totalAmt16State,
      this.totalAmt,
      this.charges,
      this.image,
      this.isSelect = false,
      this.remark,
      this.tNetKyat,
      this.tNetPae,
      this.tNetYawe,
      this.tNetGram});

  bool isSelect;

  factory MainStock.fromJson(Map<String, dynamic> json) =>
      _$MainStockFromJson(json);

  Map<String, dynamic> mainStockToJson() => _$MainStockToJson(this);
}
