import 'package:desktop_test/data/vms/return_voucher/return_voucher.dart';
import 'package:json_annotation/json_annotation.dart';
part 'grouped_return_voucher.g.dart';

@JsonSerializable()
class GroupedReturnVoucher {
  @JsonKey(name: 'count')
  int? count;

  @JsonKey(name: 'date')
  String? date;

  @JsonKey(name: 'list')
  List<ReturnVoucherVM>? returnVouchers;

  bool isCollapse = true;

  GroupedReturnVoucher(this.count, this.date, this.returnVouchers, isCollapse);

  factory GroupedReturnVoucher.fromJson(Map<String, dynamic> json) =>
      _$GroupedReturnVoucherFromJson(json);

  Map<String, dynamic> toJson() => _$GroupedReturnVoucherToJson(this);
}
