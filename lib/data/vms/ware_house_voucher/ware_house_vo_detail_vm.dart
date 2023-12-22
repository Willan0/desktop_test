import 'package:json_annotation/json_annotation.dart';
part 'ware_house_vo_detail_vm.g.dart';
@JsonSerializable()
class WareHouseVoDetailVM {
  @JsonKey(name: 'vno')
  String? vno;

  @JsonKey(name: 'gglCode')
  String? gglCode;

  @JsonKey(name: 'itemName')
  String? itemName;

  @JsonKey(name: 'qty')
  int? qty;

  @JsonKey(name: 'gram')
  int? gram;

  @JsonKey(name: 'kyat')
  int? kyat;

  @JsonKey(name: 'pae')
  int? pae;

  @JsonKey(name: 'yawe')
  int? yawe;
  WareHouseVoDetailVM(
      {this.vno,
      this.gglCode,
      this.itemName,
      this.qty,
      this.gram,
      this.kyat,
      this.pae,
      this.yawe});

  factory WareHouseVoDetailVM.fromJson(Map<String,dynamic>json)=> _$WareHouseVoDetailVMFromJson(json);

  Map<String,dynamic> wareHouseVoDetailVMToJson()=> _$WareHouseVoDetailVMToJson(this);

  @override
  String toString() {
    return 'WareHouseVoDetailVM{vno: $vno, gglCode: $gglCode, itemName: $itemName, qty: $qty, gram: $gram, kyat: $kyat, pae: $pae, yawe: $yawe}';
  }
}
