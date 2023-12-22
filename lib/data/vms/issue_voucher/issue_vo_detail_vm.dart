import 'package:json_annotation/json_annotation.dart';
part 'issue_vo_detail_vm.g.dart';
@JsonSerializable()
class IssueVoDetailVM {
  @JsonKey(name: 'issueVno')
  String? issueVno;

  @JsonKey(name: 'gglCode')
  String? gglCode;

  @JsonKey(name: 'itemName')
  String? itemName;

  @JsonKey(name: 'stock')
  int? stock;

  @JsonKey(name: 'stateId')
  String? stateId;

  @JsonKey(name: 'stateName')
  String? stateName;

  @JsonKey(name: 'typeCode')
  String? typeCode;

  @JsonKey(name: 'typeName')
  String? typeName;

  @JsonKey(name: 'qty')
  int? qty;

  @JsonKey(name: 'originalGram')
  int? originalGram;

  @JsonKey(name: 'gram')
  int? gram;

  @JsonKey(name: 'kyat')
  int? kyat;

  @JsonKey(name: 'pae')
  int? pae;

  @JsonKey(name: 'yawe')
  int? yawe;

  IssueVoDetailVM(
      {this.issueVno,
      this.gglCode,
      this.itemName,
      this.stock,
      this.stateId,
      this.stateName,
      this.typeCode,
      this.typeName,
      this.qty,
      this.originalGram,
      this.gram,
      this.kyat,
      this.pae,
      this.yawe});

  factory IssueVoDetailVM.fromJson(Map<String,dynamic>json)=> _$IssueVoDetailVMFromJson(json);

  Map<String,dynamic> issueVoDetailVMToJson()=> _$IssueVoDetailVMToJson(this);

  @override
  String toString() {
    return 'IssueVoDetailVM{issueVno: $issueVno, gglCode: $gglCode, itemName: $itemName, stock: $stock, stateId: $stateId, stateName: $stateName, typeCode: $typeCode, typeName: $typeName, qty: $qty, originalGram: $originalGram, gram: $gram, kyat: $kyat, pae: $pae, yawe: $yawe}';
  }
}
