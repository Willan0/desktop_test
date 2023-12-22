import 'package:desktop_test/data/vms/issue_stock/item_gem_vm.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sale_voucher_detail.g.dart';

@JsonSerializable()
class SaleVoucherDetailVM {
  @JsonKey(name: 'saleVno')
  String? saleVno;

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

  @JsonKey(name: 'itemName')
  String? itemName;

  @JsonKey(name: 'stateName')
  String? stateName;

  @JsonKey(name: 'typeName')
  String? typeName;

  @JsonKey(name: 'gglCode')
  String? gglCode;

  @JsonKey(name: 'image')
  String? image;

  @JsonKey(name: 'qty')
  num? qty;

  @JsonKey(name: 'goldPrice')
  num? goldPrice;

  @JsonKey(name: 'charges')
  num? charges;

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

  @JsonKey(name: 'itemGemList')
  List<ItemGemVM>? itemGemList;

  SaleVoucherDetailVM(
      {this.saleVno,
      this.customerName,
      this.phone,
      this.state,
      this.township,
      this.street,
      this.detailAddress,
      this.gglCode,
      this.qty,
      this.goldPrice,
      this.charges,
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
      this.image,
      this.pae16,
      this.yawe16,
      this.itemGemList,
      this.totalAmt});

  factory SaleVoucherDetailVM.fromJson(Map<String, dynamic> json) =>
      _$SaleVoucherDetailVMFromJson(json);

  @override
  String toString() {
    return 'SaleVoucherDetailVM{saleVno: $saleVno, itemName: $itemName, stateName: $stateName, typeName: $typeName, gglCode: $gglCode, image: $image, qty: $qty, goldPrice: $goldPrice, charges: $charges, gram: $gram, kyat: $kyat, pae: $pae, yawe: $yawe, wasteKyat: $wasteKyat, wastePae: $wastePae, wasteYawe: $wasteYawe, totalKyat: $totalKyat, totalPae: $totalPae, totalYawe: $totalYawe, kyat16: $kyat16, pae16: $pae16, yawe16: $yawe16, totalAmt: $totalAmt, itemGemList: $itemGemList}';
  }
}
