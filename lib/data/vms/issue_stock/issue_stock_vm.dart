import 'package:desktop_test/constant/dao_constant.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

import 'item_gem_vm.dart';
import 'item_waste_vm.dart';

part 'issue_stock_vm.g.dart';

@JsonSerializable()
@HiveType(typeId: kTypeIdForIssues)
class IssueStockVM {
  @JsonKey(name: 'gglCode')
  @HiveField(0)
  String? gglCode;

  @JsonKey(name: 'itemName')
  @HiveField(1)
  String? itemName;

  @JsonKey(name: 'stateId')
  @HiveField(2)
  String? stateId;

  @JsonKey(name: 'stateName')
  @HiveField(3)
  String? stateName;

  @JsonKey(name: 'typeCode')
  @HiveField(4)
  String? typeCode;

  @JsonKey(name: 'typeName')
  @HiveField(5)
  String? typeName;

  @JsonKey(name: 'image')
  @HiveField(16)
  String? image;

  @JsonKey(name: 'userId')
  @HiveField(6)
  String? userId;

  @JsonKey(name: 'userName')
  @HiveField(7)
  String? userName;

  @JsonKey(name: 'fullName')
  @HiveField(8)
  String? fullName;

  @JsonKey(name: 'qty')
  @HiveField(9)
  num? qty;

  @JsonKey(name: 'gram')
  @HiveField(10)
  num? gram;

  @JsonKey(name: 'kyat')
  @HiveField(11)
  num? kyat;

  @JsonKey(name: 'pae')
  @HiveField(12)
  num? pae;

  @JsonKey(name: 'yawe')
  @HiveField(13)
  num? yawe;

  @JsonKey(name: 'itemWasteList')
  @HiveField(14)
  List<ItemWasteVM>? itemWasteList;

  @JsonKey(name: 'itemGemList')
  @HiveField(15)
  List<ItemGemVM>? itemGemList;

  @JsonKey(name: 'goldPrice')
  @HiveField(17)
  num? goldPrice;

  @HiveField(18)
  num? kyat16;

  @HiveField(19)
  num? pae16;

  @HiveField(20)
  num? yawe16;

  @HiveField(21)
  num? gram16;

  @HiveField(22)
  num? wKyat16;

  @HiveField(23)
  num? wPae16;

  @HiveField(24)
  num? wYawe16;

  @HiveField(25)
  num? totalAmt16State;

  @HiveField(26)
  num? totalAmt;

  @HiveField(27)
  num? charges;
  bool? isSelect;

  IssueStockVM(
      {this.gglCode,
      this.itemName,
      this.stateId,
      this.stateName,
      this.typeCode,
      this.typeName,
      this.userId,
      this.userName,
      this.fullName,
      this.image,
      this.qty,
      this.gram,
      this.kyat,
      this.pae,
      this.yawe,
      this.itemWasteList,
      this.itemGemList,
      this.goldPrice,
      this.kyat16,
      this.pae16,
      this.yawe16,
      this.wYawe16,
      this.wPae16,
      this.wKyat16,
      this.gram16,
      this.totalAmt16State,
      this.totalAmt,
      this.charges,
      this.isSelect = false});
  factory IssueStockVM.fromJson(Map<String, dynamic> json) =>
      _$IssueStockVMFromJson(json);
  Map<String, dynamic> issueStockVMToJson() => _$IssueStockVMToJson(this);

  @override
  String toString() {
    return 'IssueStockVM{gglCode: $gglCode, itemName: $itemName, stateId: $stateId, stateName: $stateName, typeCode: $typeCode, typeName: $typeName, image: $image, userId: $userId, userName: $userName, fullName: $fullName, qty: $qty, gram: $gram, kyat: $kyat, pae: $pae, yawe: $yawe, itemWasteList: $itemWasteList, itemGemList: $itemGemList, goldPrice: $goldPrice, kyat16: $kyat16, pae16: $pae16, yawe16: $yawe16, gram16: $gram16, wKyat16: $wKyat16, wPae16: $wPae16, wYawe16: $wYawe16, totalAmt16State: $totalAmt16State, totalAmt: $totalAmt, isSelect: $isSelect}';
  }
}
