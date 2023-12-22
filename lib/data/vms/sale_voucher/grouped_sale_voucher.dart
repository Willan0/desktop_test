import 'package:desktop_test/data/vms/sale_voucher/sale_voucher.dart';
import 'package:json_annotation/json_annotation.dart';
part 'grouped_sale_voucher.g.dart';

@JsonSerializable()
class GroupedSaleVoucher {
  @JsonKey(name: "count")
  num? count;

  @JsonKey(name: 'date')
  String? date;

  @JsonKey(name: 'list')
  List<SaleVoucherVM>? saleVouchers;

  bool isCollapse = true;

  GroupedSaleVoucher(this.count, this.date, this.saleVouchers, isCollapse);

  factory GroupedSaleVoucher.fromJson(Map<String, dynamic> json) =>
      _$GroupedSaleVoucherFromJson(json);

  Map<String, dynamic> toJson() => _$GroupedSaleVoucherToJson(this);
}
