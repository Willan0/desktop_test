import 'package:json_annotation/json_annotation.dart';
part 'customer_payment.g.dart';
@JsonSerializable()
class CustomerPayment{
  @JsonKey(name: 'paymentVno')
  String? paymentVno;

  @JsonKey(name: 'date')
  String? date;

  @JsonKey(name: 'lat')
  String? lat;

  @JsonKey(name: 'long')
  String? long;

  @JsonKey(name: 'customerId')
  String? customerId;

  @JsonKey(name: 'customerName')
  String? customerName;

  @JsonKey(name: 'isGold')
  bool? isGold;

  @JsonKey(name: "isDiscount")
  bool? isDiscount;

  @JsonKey(name: 'goldPrice')
  num? goldPrice;

  @JsonKey(name: 'totalAmt')
  num? totalAmt;

  @JsonKey(name: 'gram')
  num? gram;

  @JsonKey(name: 'kyat')
  num? kyat;

  @JsonKey(name: 'pae')
  num? pae;

  @JsonKey(name: 'yawe')
  num? yawe;

  @JsonKey(name: 'receiveBy')
  String? receiveBy;

  @JsonKey(name: 'remark')
  String? remark;

  @JsonKey(name: 'deleteDate')
  String? deleteDate;

  @JsonKey(name: 'deleteBy')
  String? deleteBy;

  @JsonKey(name: 'deleteRemark')
  String? deleteRemark;

  CustomerPayment({
      this.paymentVno,
      this.date,
      this.lat,
      this.long,
      this.customerId,
      this.customerName,
      this.isGold,
    this.isDiscount,
      this.goldPrice,
      this.totalAmt,
      this.gram,
      this.kyat,
      this.pae,
      this.yawe,
      this.receiveBy,
      this.remark,
      this.deleteDate,
      this.deleteBy,
      this.deleteRemark});

  factory CustomerPayment.fromJson(Map<String,dynamic> json)=> _$CustomerPaymentFromJson(json);

  Map<String,dynamic> toJson()=> _$CustomerPaymentToJson(this);
}