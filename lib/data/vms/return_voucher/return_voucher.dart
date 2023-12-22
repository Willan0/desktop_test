import 'package:desktop_test/data/vms/return_voucher/return_voucher_detail_vm.dart';
import 'package:json_annotation/json_annotation.dart';

part 'return_voucher.g.dart';

@JsonSerializable()
class ReturnVoucherVM {
  @JsonKey(name: 'returnVno')
  String? returnVno;

  @JsonKey(name: 'date')
  String? date;

  @JsonKey(name: 'totalQty')
  num? totalQty;

  @JsonKey(name: 'lat')
  num? lat;

  @JsonKey(name: 'long')
  num? long;

  @JsonKey(name: 'customerId')
  String? customerId;

  @JsonKey(name: 'createBy')
  String? createBy;

  @JsonKey(name: 'totalAmt')
  num? totalAmt;

  @JsonKey(name: 'totalGram')
  num? totalGram;

  @JsonKey(name: 'totalWasteKyat')
  num? totalWasteKyat;

  @JsonKey(name: 'totalWastePae')
  num? totalWastePae;

  @JsonKey(name: 'totalWasteYawe')
  num? totalWasteYawe;

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

  @JsonKey(name: 'remark')
  String? remark;

  @JsonKey(name: 'warehouseReceiveDate')
  String? warehouseReceiveDate;

  @JsonKey(name: 'warehouseReceiveBy')
  String? warehouseReceiveBy;

  @JsonKey(name: 'warehouseReceiveRemark')
  String? warehouseReceiveRemark;

  @JsonKey(name: 'deleteDate')
  String? deleteDate;

  @JsonKey(name: 'deleteBy')
  String? deleteBy;

  @JsonKey(name: 'deleteRemark')
  String? deleteRemark;

  @JsonKey(name: 'voucherDetailModel')
  List<ReturnVoucherDetailVM>? voucherDetailModel;

  ReturnVoucherVM(
      {this.returnVno,
      this.date,
      this.totalQty,
      this.lat,
      this.long,
      this.customerId,
      this.createBy,
      this.totalAmt,
      this.totalGram,
      this.totalWasteKyat,
      this.totalWastePae,
      this.totalWasteYawe,
      this.totalKyat,
      this.totalPae,
      this.totalYawe,
      this.kyat16,
      this.pae16,
      this.yawe16,
      this.remark,
      this.warehouseReceiveDate,
      this.warehouseReceiveBy,
      this.warehouseReceiveRemark,
      this.deleteDate,
      this.deleteBy,
      this.deleteRemark,
      this.voucherDetailModel});

  factory ReturnVoucherVM.fromJson(Map<String, dynamic> json) =>
      _$ReturnVoucherVMFromJson(json);

  @override
  String toString() {
    return 'ReturnVoucherVM{returnVno: $returnVno, date: $date, totalQty: $totalQty, lat: $lat, long: $long, customerId: $customerId, createBy: $createBy, totalAmt: $totalAmt, totalGram: $totalGram, totalWasteKyat: $totalWasteKyat, totalWastePae: $totalWastePae, totalWasteYawe: $totalWasteYawe, totalKyat: $totalKyat, totalPae: $totalPae, totalYawe: $totalYawe, kyat16: $kyat16, pae16: $pae16, yawe16: $yawe16, remark: $remark, warehouseReceiveDate: $warehouseReceiveDate, warehouseReceiveBy: $warehouseReceiveBy, warehouseReceiveRemark: $warehouseReceiveRemark, deleteDate: $deleteDate, deleteBy: $deleteBy, deleteRemark: $deleteRemark, voucherDetailModel: $voucherDetailModel}';
  }
}
