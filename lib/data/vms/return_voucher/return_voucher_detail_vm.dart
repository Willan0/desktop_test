import 'package:json_annotation/json_annotation.dart';

import 'item_gem_list_vm.dart';
part 'return_voucher_detail_vm.g.dart';

@JsonSerializable()
class ReturnVoucherDetailVM {
  @JsonKey(name: 'returnVno')
  String? returnVno;

  @JsonKey(name: 'customerName')
  String? customerName;

  @JsonKey(name: 'phone')
  String? phone;

  @JsonKey(name: 'state')
  String? state;

  @JsonKey(name: 'township')
  String? township;

  @JsonKey(name: 'street')
  String? street;

  @JsonKey(name: 'detailAddress')
  String? detailAddress;

  @JsonKey(name: 'gglCode')
  String? gglCode;

  @JsonKey(name: 'itemName')
  String? itemName;

  @JsonKey(name: 'stateName')
  String? stateName;

  @JsonKey(name: 'typeName')
  String? typeName;

  @JsonKey(name: 'image')
  String? image;

  @JsonKey(name: 'qty')
  num? qty;

  @JsonKey(name: 'goldPrice')
  num? goldPrice;

  @JsonKey(name: 'gram')
  num? gram;

  @JsonKey(name: 'kyat')
  num? kyat;

  @JsonKey(name: 'pae')
  num? pae;

  @JsonKey(name: 'yawe')
  num? yawe;

  @JsonKey(name: 'wasteKyat')
  num? wasteKyat;

  @JsonKey(name: 'wastePae')
  num? wastePae;

  @JsonKey(name: 'wasteYawe')
  num? wasteYawe;

  @JsonKey(name: 'totalKyat')
  num? totalKyat;

  @JsonKey(name: 'totalPae')
  num? totalPae;

  @JsonKey(name: 'totalYawe')
  num? totalYawe;

  @JsonKey(name: 'kyat16')
  num? kyat16;

  @JsonKey(name: 'pae16')
  num? pae16;

  @JsonKey(name: 'yawe16')
  num? yawe16;

  @JsonKey(name: 'totalAmt')
  num? totalAmt;
  

  @JsonKey(name: 'itemGemLists')
  List<ItemGemListVM>? itemGemLists;

  ReturnVoucherDetailVM(
      {this.returnVno,
      this.gglCode,
      this.customerName,
      this.phone,
      this.state,
      this.township,
      this.street,
      this.detailAddress,
      this.itemName,
      this.stateName,
      this.typeName,
      this.image,
      this.qty,
      this.goldPrice,
      this.gram,
      this.kyat,
      this.pae,
      this.yawe,
      this.wasteKyat,
      this.wastePae,
      this.wasteYawe,
      this.totalKyat,
      this.totalPae,
      this.totalYawe,
      this.kyat16,
      this.pae16,
      this.yawe16,
      this.totalAmt,
      this.itemGemLists});

  factory ReturnVoucherDetailVM.fromJson(Map<String, dynamic> json) =>
      _$ReturnVoucherDetailVMFromJson(json);
}
