import 'package:json_annotation/json_annotation.dart';

import 'issue_vo_detail_vm.dart';
part 'issue_voucher_vm.g.dart';
@JsonSerializable()
class IssueVoucherVM {
  @JsonKey(name: 'issueVno')
  String? issueVno;

  @JsonKey(name: 'date')
  String? date;

  @JsonKey(name: 'userId')
  String? userId;

  @JsonKey(name: 'userName')
  String? userName;

  @JsonKey(name: 'fullName')
  String? fullName;

  @JsonKey(name: 'createBy')
  String? createBy;

  @JsonKey(name: 'totalQty')
  int? totalQty;

  @JsonKey(name: 'remark')
  String? remark;

  @JsonKey(name: 'deleteDate')
  String? deleteDate;

  @JsonKey(name: 'deleteBy')
  String? deleteBy;

  @JsonKey(name: 'deleteRemark')
  String? deleteRemark;

  @JsonKey(name: 'voDetialList')
  List<IssueVoDetailVM>? voDetailList;

  IssueVoucherVM(
      {this.issueVno,
      this.date,
      this.userId,
      this.userName,
      this.fullName,
      this.createBy,
      this.totalQty,
      this.remark,
      this.deleteDate,
      this.deleteBy,
      this.deleteRemark,
      this.voDetailList});
  factory IssueVoucherVM.fromJson(Map<String,dynamic> json)=> _$IssueVoucherVMFromJson(json);
  Map<String,dynamic> issueVoucherVMToJson()=> _$IssueVoucherVMToJson(this);

  @override
  String toString() {
    return 'IssueVoucherVM{issueVno: $issueVno, date: $date, userId: $userId, userName: $userName, fullName: $fullName, createBy: $createBy, totalQty: $totalQty, remark: $remark, deleteDate: $deleteDate, deleteBy: $deleteBy, deleteRemark: $deleteRemark, voDetailList: $voDetailList}';
  }
}
