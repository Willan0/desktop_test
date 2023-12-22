import 'package:flutter/material.dart';
import 'package:desktop_test/constant/color.dart';
import 'package:desktop_test/widgets/bottom_sheet_indicator.dart';
import 'package:desktop_test/widgets/customer_payment_card.dart';
import 'package:desktop_test/widgets/easy_button.dart';
import 'package:desktop_test/widgets/easy_text.dart';
import 'package:desktop_test/widgets/main_stock_card.dart';
import 'package:desktop_test/widgets/return_voucher_card.dart';
import 'package:desktop_test/widgets/transfer_voucher_card.dart';

import '../constant/dimen.dart';
import '../widgets/issue_card.dart';
import '../widgets/sale_voucher_card.dart';

class MobileListView extends StatelessWidget {
  const MobileListView(
      {super.key,
      this.isIssue = false,
      required this.list,
      this.isSelect,
      this.isTransfer = false,
      this.isReturn = false,
      this.isPayment = false,
      this.scrollController,
      this.isCanDelete = false,
      this.isSale = false});

  final List<dynamic> list;
  final bool isIssue;
  final bool? isSelect;
  final bool isSale;
  final bool isReturn;
  final bool isPayment;
  final bool isTransfer;
  final bool isCanDelete;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      itemCount: list.length,
      itemBuilder: (context, index) => isPayment
          ? CustomerPaymentCard(customerPayment: list[index])
          : isIssue
              ? IssueStocksCard(
                  isSelect: isSelect ?? false,
                  issue: list[index],
                  isCanDelete: isCanDelete,
                )
              : isSale
                  ? SaleVoucherCard(saleVoucher: list[index])
                  : isReturn
                      ? ReturnVoucherCard(returnVoucher: list[index])
                      : isTransfer
                          ? TransferVoucherCard(transferVm: list[index])
                          : MainStocksCard(
                              mainStock: list[index],
                              isCanDelete: isCanDelete,
                            ),
    );
  }
}

class TabletGridView extends StatelessWidget {
  const TabletGridView(
      {super.key,
      this.isIssue = false,
      this.isSale = false,
      required this.list,
      this.isTransfer = false,
      this.isReturn = false,
      this.isPayment = false,
      required this.childAspectRatio,
      required this.crossAxisCount,
      this.isCanDelete = false,
      this.isSelect,
      this.scrollController});

  final bool? isSelect;
  final List<dynamic> list;
  final double childAspectRatio;
  final bool isCanDelete;
  final int crossAxisCount;
  final bool isIssue;
  final bool isReturn;
  final bool isPayment;
  final bool isSale;
  final bool isTransfer;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: kAs20x, right: kAs20x),
      child: GridView.builder(
        controller: scrollController,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: kAs20x,
            childAspectRatio: childAspectRatio,
            crossAxisCount: crossAxisCount),
        itemCount: list.length,
        itemBuilder: (context, index) => isPayment
            ? CustomerPaymentCard(customerPayment: list[index])
            : isIssue
                ? IssueStocksCard(
                    isSelect: isSelect ?? false,
                    issue: list[index],
                    isCanDelete: isCanDelete,
                  )
                : isSale
                    ? SaleVoucherCard(saleVoucher: list[index])
                    : isReturn
                        ? ReturnVoucherCard(returnVoucher: list[index])
                        : isTransfer
                            ? TransferVoucherCard(
                                transferVm: list[index],
                              )
                            : MainStocksCard(
                                mainStock: list[index],
                                isCanDelete: isCanDelete,
                              ),
      ),
    );
  }
}
