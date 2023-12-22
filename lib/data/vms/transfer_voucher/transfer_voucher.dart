import 'package:desktop_test/data/vms/transfer_voucher/transfer_voucher_detail.dart';
import 'package:json_annotation/json_annotation.dart';
part 'transfer_voucher.g.dart';

@JsonSerializable()
class TransferVoucherVM {
  @JsonKey(name: 'transferVno')
  String? transferVno;

  @JsonKey(name: 'date')
  String? date;

  @JsonKey(name: 'lat')
  num? lat;

  @JsonKey(name: 'long')
  num? long;

  @JsonKey(name: 'transferUserId')
  String? transferUserId;

  @JsonKey(name: 'transferUserName')
  String? transferUserName;

  @JsonKey(name: 'transferTo')
  String? transferTo;

  @JsonKey(name: 'totalQty')
  num? totalQty;

  @JsonKey(name: 'totalGram')
  num? totalGram;

  @JsonKey(name: "totalKyat")
  num? totalKyat;

  @JsonKey(name: 'totalPae')
  num? totalPae;

  @JsonKey(name: "totalYawe")
  num? totalYawe;

  @JsonKey(name: 'kyat16')
  num? kyat16;

  @JsonKey(name: 'pae16')
  num? pae16;

  @JsonKey(name: 'yawe16')
  num? yawe16;

  @JsonKey(name: 'recepentUserId')
  String? recepentUserId;

  @JsonKey(name: 'recepentUser')
  String? recepentUser;

  @JsonKey(name: 'receiveDate')
  String? receiveDate;

  @JsonKey(name: 'receiveBy')
  String? receivedBy;

  @JsonKey(name: 'remark')
  String? remark;

  @JsonKey(name: 'transferVoDetails')
  List<TransferVoucherDetailVM>? transferVoucherDetail;

  TransferVoucherVM(
      {this.transferVno,
      this.date,
      this.lat,
      this.long,
      this.transferUserId,
      this.transferUserName,
      this.transferTo,
      this.totalQty,
      this.totalGram,
      this.totalKyat,
      this.totalPae,
      this.totalYawe,
      this.kyat16,
      this.pae16,
      this.yawe16,
      this.recepentUserId,
      this.recepentUser,
      this.receiveDate,
      this.receivedBy,
      this.remark,
      this.transferVoucherDetail});
  factory TransferVoucherVM.fromJson(Map<String, dynamic> json) =>
      _$TransferVoucherVMFromJson(json);

  Map<String, dynamic> toJson() => _$TransferVoucherVMToJson(this);
}
