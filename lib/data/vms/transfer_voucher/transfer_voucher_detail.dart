import 'package:json_annotation/json_annotation.dart';

import '../issue_stock/item_gem_vm.dart';
part 'transfer_voucher_detail.g.dart';

@JsonSerializable()
class TransferVoucherDetailVM {
  @JsonKey(name: 'transferVno')
  String? transferVno;

  @JsonKey(name: 'transferUserName')
  String? transferUserName;

  @JsonKey(name: 'receiveUser')
  String? receiveUser;

  @JsonKey(name: 'gglCode')
  String? gglCode;

  @JsonKey(name: 'itemName')
  String? itemName;

  @JsonKey(name: 'stateName')
  String? stateName;

  @JsonKey(name: 'image')
  String? image;

  @JsonKey(name: 'qty')
  num? qty;

  @JsonKey(name: 'gram')
  num? gram;

  @JsonKey(name: 'kyat')
  num? kyat;

  @JsonKey(name: 'pae')
  num? pae;

  @JsonKey(name: 'yawe')
  num? yawe;

  @JsonKey(name: 'itemGemList')
  List<ItemGemVM>? itemGemList;

  TransferVoucherDetailVM(
      {this.transferVno,
      this.transferUserName,
      this.receiveUser,
      this.gglCode,
      this.stateName,
      this.itemName,
      this.image,
      this.qty,
      this.gram,
      this.kyat,
      this.pae,
      this.yawe,
      this.itemGemList});

  factory TransferVoucherDetailVM.fromJson(Map<String, dynamic> json) =>
      _$TransferVoucherDetailVMFromJson(json);

  Map<String, dynamic> toJson() => _$TransferVoucherDetailVMToJson(this);
}
