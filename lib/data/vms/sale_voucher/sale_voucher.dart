import 'package:desktop_test/data/vms/sale_voucher/sale_voucher_detail.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sale_voucher.g.dart';

@JsonSerializable()
class SaleVoucherVM {
  @JsonKey(name: 'saleVno')
  String? saleVno;

  @JsonKey(name: 'date')
  String? date;

  @JsonKey(name: 'totalQty')
  num? totalQty;

  @JsonKey(name: 'lat')
  num? lat;

  @JsonKey(name: 'long')
  num? long;

  @JsonKey(name: "totalGram")
  num? totalGram;

  @JsonKey(name: 'customerName')
  String? customerName;

  @JsonKey(name: 'phone')
  String? phone;

  @JsonKey(name: 'detailAddress')
  String? address;

  @JsonKey(name: 'customerId')
  String? customerId;

  @JsonKey(name: 'createBy')
  String? createdBy;

  @JsonKey(name: 'totalAmt')
  num? totalAmount;

  @JsonKey(name: 'kyat16')
  num? kyat16;

  @JsonKey(name: 'pae16')
  num? pae16;

  @JsonKey(name: 'yawe16')
  num? yawe16;

  @JsonKey(name: 'totalWasteKyat')
  num? totalWasteKyat;

  @JsonKey(name: 'totalWastePae')
  num? totalWastePae;

  @JsonKey(name: 'totalWasteYawe')
  num? totalWasteYawe;

  @JsonKey(name: 'totalKyat')
  num? totalKyat;

  @JsonKey(name: "totalPae")
  num? totalPae;

  @JsonKey(name: 'totalYawe')
  num? totalYawe;

  @JsonKey(name: 'remark')
  String? remark;

  @JsonKey(name: 'deleteDate')
  String? deleteDate;

  @JsonKey(name: 'deleteBy')
  String? deleteBy;

  @JsonKey(name: 'deleteRemark')
  String? deleteRemark;

  @JsonKey(name: 'saleVoDetailsModel')
  List<SaleVoucherDetailVM>? saleVoucherDetail;

  SaleVoucherVM(
      {this.saleVno,
      this.date,
      this.totalQty,
      this.customerName,
      this.lat,
      this.long,
      this.customerId,
      this.createdBy,
      this.totalGram,
      this.totalAmount,
      this.kyat16,
      this.pae16,
      this.yawe16,
      this.totalWasteKyat,
      this.totalWastePae,
      this.totalWasteYawe,
      this.totalKyat,
      this.totalYawe,
      this.totalPae,
      this.remark,
      this.phone,
      this.address,
      this.deleteDate,
      this.deleteBy,
      this.deleteRemark,
      this.saleVoucherDetail});

  factory SaleVoucherVM.fromJson(Map<String, dynamic> json) =>
      _$SaleVoucherVMFromJson(json);

  @override
  String toString() {
    return 'SaleVoucherVM{saleVno: $saleVno, date: $date, totalQty: $totalQty, lat: $lat, long: $long, totalGram: $totalGram, customerName: $customerName, phone: $phone, address: $address, customerId: $customerId, createdBy: $createdBy, totalAmount: $totalAmount, kyat16: $kyat16, pae16: $pae16, yawe16: $yawe16, totalWasteKyat: $totalWasteKyat, totalWastePae: $totalWastePae, totalWasteYawe: $totalWasteYawe, totalKyat: $totalKyat, totalPae: $totalPae, totalYawe: $totalYawe, remark: $remark, deleteDate: $deleteDate, deleteBy: $deleteBy, deleteRemark: $deleteRemark, saleVoucherDetail: $saleVoucherDetail}';
  }
}
