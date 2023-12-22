// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'issue_voucher_vm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IssueVoucherVM _$IssueVoucherVMFromJson(Map<String, dynamic> json) =>
    IssueVoucherVM(
      issueVno: json['issueVno'] as String?,
      date: json['date'] as String?,
      userId: json['userId'] as String?,
      userName: json['userName'] as String?,
      fullName: json['fullName'] as String?,
      createBy: json['createBy'] as String?,
      totalQty: json['totalQty'] as int?,
      remark: json['remark'] as String?,
      deleteDate: json['deleteDate'] as String?,
      deleteBy: json['deleteBy'] as String?,
      deleteRemark: json['deleteRemark'] as String?,
      voDetailList: (json['voDetialList'] as List<dynamic>?)
          ?.map((e) => IssueVoDetailVM.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$IssueVoucherVMToJson(IssueVoucherVM instance) =>
    <String, dynamic>{
      'issueVno': instance.issueVno,
      'date': instance.date,
      'userId': instance.userId,
      'userName': instance.userName,
      'fullName': instance.fullName,
      'createBy': instance.createBy,
      'totalQty': instance.totalQty,
      'remark': instance.remark,
      'deleteDate': instance.deleteDate,
      'deleteBy': instance.deleteBy,
      'deleteRemark': instance.deleteRemark,
      'voDetialList': instance.voDetailList,
    };
