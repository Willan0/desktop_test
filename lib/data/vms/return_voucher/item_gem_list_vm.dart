import 'package:json_annotation/json_annotation.dart';

part 'item_gem_list_vm.g.dart';

@JsonSerializable()
class ItemGemListVM {
  @JsonKey(name: 'gglCode')
  String? gglCode;

  @JsonKey(name: 'logNo')
  String? logNo;

  @JsonKey(name: 'particular')
  String? particular;

  @JsonKey(name: 'kyat')
  int? kyat;

  @JsonKey(name: 'pae')
  int? pae;

  @JsonKey(name: 'yawe')
  int? yawe;

  @JsonKey(name: 'yati')
  int? yati;

  @JsonKey(name: 'ct')
  int? ct;

  @JsonKey(name: 'qty')
  int? qty;

  @JsonKey(name: 'description')
  String? description;

  @JsonKey(name: 'salePriceYati')
  int? salePriceYati;

  @JsonKey(name: 'salePriceCt')
  int? salePriceCt;

  @JsonKey(name: 'gemAmt')
  int? gemAmt;

  ItemGemListVM(
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

  factory ItemGemListVM.fromJson(Map<String, dynamic> json) =>
      _$ItemGemListVMFromJson(json);
}
