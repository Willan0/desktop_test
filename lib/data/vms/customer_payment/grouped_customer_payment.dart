import 'package:desktop_test/data/vms/customer_payment/customer_payment.dart';
import 'package:json_annotation/json_annotation.dart';
part 'grouped_customer_payment.g.dart';

@JsonSerializable()
class GroupedCustomerPayment {
  @JsonKey(name: 'count')
  num? count;

  @JsonKey(name: 'date')
  String? date;

  @JsonKey(name: 'list')
  List<CustomerPayment>? customerPayments;

  bool isCollapse = true;

  GroupedCustomerPayment(
      {this.count, this.date, this.customerPayments, isCollapse});

  factory GroupedCustomerPayment.fromJson(Map<String, dynamic> json) =>
      _$GroupedCustomerPaymentFromJson(json);

  Map<String, dynamic> toJson() => _$GroupedCustomerPaymentToJson(this);
}
