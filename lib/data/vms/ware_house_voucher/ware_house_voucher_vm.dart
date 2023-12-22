import 'package:desktop_test/data/vms/ware_house_voucher/ware_house_vo_detail_vm.dart';
import 'package:json_annotation/json_annotation.dart';
part 'ware_house_voucher_vm.g.dart';

@JsonSerializable()
class WareHouseVoucherVM {
  @JsonKey(name: 'vno')
  String? vno;

  @JsonKey(name: 'date')
  String? date;

  @JsonKey(name: 'createBy')
  String? createBy;

  @JsonKey(name: 'remark')
  String? remark;

  @JsonKey(name: 'deleteDate')
  String? deleteDate;

  @JsonKey(name: 'deleteBy')
  String? deleteBy;

  @JsonKey(name: 'deleteRemark')
  String? deleteRemark;

  @JsonKey(name: 'voucherDetailModel')
  List<WareHouseVoDetailVM>? voucherDetailModel;

  WareHouseVoucherVM(
      {this.vno,
      this.date,
      this.createBy,
      this.remark,
      this.deleteDate,
      this.deleteBy,
      this.deleteRemark,
      this.voucherDetailModel});
  factory WareHouseVoucherVM.fromJson(Map<String, dynamic> json) =>
      _$WareHouseVoucherVMFromJson(json);

  Map<String, dynamic> wareHouseVoucherVMToJson() =>
      _$WareHouseVoucherVMToJson(this);

  @override
  String toString() {
    return 'WareHouseVoucherVM{vno: $vno, date: $date, createBy: $createBy, remark: $remark, deleteDate: $deleteDate, deleteBy: $deleteBy, deleteRemark: $deleteRemark, voucherDetailModel: $voucherDetailModel}';
  }
}
