import 'package:flutter/material.dart';
import 'package:desktop_test/constant/color.dart';
import 'package:desktop_test/constant/dimen.dart';
import 'package:desktop_test/data/vms/customer_payment/grouped_customer_payment.dart';
import 'package:desktop_test/data/vms/return_voucher/grouped_return_voucher.dart';
import 'package:desktop_test/widgets/customer_payment_card.dart';
import 'package:desktop_test/widgets/report_view.dart';
import 'package:desktop_test/widgets/return_voucher_card.dart';
import 'package:desktop_test/widgets/sale_voucher_card.dart';

import '../data/vms/sale_voucher/grouped_sale_voucher.dart';

class CustomerSaleViewItem extends StatefulWidget {
  const CustomerSaleViewItem({super.key, required this.groupedSaleVouchers});

  final List<GroupedSaleVoucher> groupedSaleVouchers;

  @override
  State<CustomerSaleViewItem> createState() => _CustomerSaleViewItemState();
}

class _CustomerSaleViewItemState extends State<CustomerSaleViewItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBackGroundColor,
        body: Padding(
          padding:
              const EdgeInsets.only(left: kAs20x, right: kAs20x, top: kAs10x),
          child: ListView.builder(
            itemCount: widget.groupedSaleVouchers.length,
            itemBuilder: (context, index) {
              return ReportView(
                  isCollapse: widget.groupedSaleVouchers[index].isCollapse,
                  widgets: widget.groupedSaleVouchers[index].saleVouchers!
                      .map((e) => SaleVoucherCard(
                            saleVoucher: e,
                            isReport: true,
                          ))
                      .toList(),
                  onTap: () {
                    if (mounted) {
                      setState(() {
                        widget.groupedSaleVouchers[index].isCollapse =
                            !widget.groupedSaleVouchers[index].isCollapse;
                      });
                    }
                  },
                  count: (widget.groupedSaleVouchers[index].count)!.toInt(),
                  date: widget.groupedSaleVouchers[index].date ?? '');
            },
          ),
        ));
  }
}

class CustomerReportViewItem extends StatefulWidget {
  const CustomerReportViewItem({super.key, required this.returnVouchers});

  final List<GroupedReturnVoucher> returnVouchers;

  @override
  State<CustomerReportViewItem> createState() => _CustomerReportViewItemState();
}

class _CustomerReportViewItemState extends State<CustomerReportViewItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackGroundColor,
      body: Padding(
        padding:
            const EdgeInsets.only(left: kAs20x, right: kAs20x, top: kAs10x),
        child: ListView.builder(
          itemCount: widget.returnVouchers.length,
          itemBuilder: (context, index) {
            return ReportView(
                isCollapse: widget.returnVouchers[index].isCollapse,
                widgets: widget.returnVouchers[index].returnVouchers!
                    .map((e) => ReturnVoucherCard(
                          returnVoucher: e,
                          isReport: true,
                        ))
                    .toList(),
                onTap: () {
                  if (mounted) {
                    setState(() {
                      widget.returnVouchers[index].isCollapse =
                          !widget.returnVouchers[index].isCollapse;
                    });
                  }
                },
                count: (widget.returnVouchers[index].count)!.toInt(),
                date: widget.returnVouchers[index].date ?? '');
          },
        ),
      ),
    );
  }
}

class CustomerPaymentViewItem extends StatefulWidget {
  const CustomerPaymentViewItem({super.key, required this.customerPayments});

  final List<GroupedCustomerPayment> customerPayments;
  @override
  State<CustomerPaymentViewItem> createState() =>
      _CustomerPaymentViewItemState();
}

class _CustomerPaymentViewItemState extends State<CustomerPaymentViewItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackGroundColor,
      body: Padding(
        padding:
            const EdgeInsets.only(left: kAs20x, right: kAs20x, top: kAs10x),
        child: ListView.builder(
          itemCount: widget.customerPayments.length,
          itemBuilder: (context, index) {
            return ReportView(
                isCollapse: widget.customerPayments[index].isCollapse,
                widgets: widget.customerPayments[index].customerPayments!
                    .map((e) => CustomerPaymentCard(customerPayment: e))
                    .toList(),
                onTap: () {
                  if (mounted) {
                    setState(() {
                      widget.customerPayments[index].isCollapse =
                          !widget.customerPayments[index].isCollapse;
                    });
                  }
                },
                count: (widget.customerPayments[index].count)!.toInt(),
                date: widget.customerPayments[index].date ?? '');
          },
        ),
      ),
    );
  }
}
