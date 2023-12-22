import 'package:desktop_test/data/vms/transfer_voucher/transfer_voucher.dart';
import 'package:json_annotation/json_annotation.dart';
part 'grouped_transfer_voucher.g.dart';

@JsonSerializable()
class GroupedTransferVoucher {
  @JsonKey(name: 'count')
  num? count;

  @JsonKey(name: 'date')
  String? date;

  @JsonKey(name: 'list')
  List<TransferVoucherVM>? transferVouchers;

  bool isCollapse = true;

  GroupedTransferVoucher(
      {this.count, this.date, this.transferVouchers, isCollapse});

  factory GroupedTransferVoucher.fromJson(Map<String, dynamic> json) =>
      _$GroupedTransferVoucherFromJson(json);

  Map<String, dynamic> toJson() => _$GroupedTransferVoucherToJson(this);
}
