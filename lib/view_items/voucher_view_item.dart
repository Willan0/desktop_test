import 'package:flutter/material.dart';
import 'package:desktop_test/constant/dimen.dart';
import 'package:desktop_test/data/vms/customer_payment/customer_payment.dart';
import 'package:desktop_test/data/vms/sale_voucher/sale_voucher.dart';
import 'package:desktop_test/data/vms/transfer_voucher/grouped_transfer_voucher.dart';
import 'package:desktop_test/provider/customer_provider.dart';
import 'package:desktop_test/provider/sale_voucher_provider.dart';
import 'package:desktop_test/provider/return_voucher_provider.dart';
import 'package:desktop_test/provider/transfer_voucher_provider.dart';
import 'package:desktop_test/utils/extension.dart';
import 'package:desktop_test/utils/responsive_view.dart';
import 'package:desktop_test/widgets/easy_text.dart';
import 'package:desktop_test/widgets/report_view.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../constant/color.dart';
import '../data/vms/return_voucher/return_voucher.dart';
import '../widgets/transfer_voucher_card.dart';

class SaleViewItem extends StatefulWidget {
  const SaleViewItem({super.key});

  @override
  State<SaleViewItem> createState() => _SaleViewItemState();
}

class _SaleViewItemState extends State<SaleViewItem> {
  bool _isInitialize = false;
  late SaleVoucherProvider _saleVoucherProvider;
  List<SaleVoucherVM> saleVouchers = [];
  bool isLoading = true;

  @override
  void didChangeDependencies() async {
    _saleVoucherProvider = context.watch<SaleVoucherProvider>();
    if (!_isInitialize) {
      await _saleVoucherProvider.getSaleVouchers();
      isLoading = false;
    }

    saleVouchers = !_saleVoucherProvider.isFilter
        ? _saleVoucherProvider.todaySaleVoucher ?? []
        : _saleVoucherProvider.filteredSaleVouchers;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    _isInitialize = true;

    // NotificationListener<UserScrollNotification>(
    // onNotification: (notification) {
    //   if (notification.direction == ScrollDirection.forward) {
    //     context.read<SaleVoucherProvider>().checkScroll(false);
    //   }
    //   if (notification.direction == ScrollDirection.reverse) {
    //     context.read<SaleVoucherProvider>().checkScroll(true);
    //   }
    //   return true;
    // },
    // child:
    return Scaffold(
        backgroundColor: kBackGroundColor,
        body: isLoading
            ? context.showLoading()
            : saleVouchers.isEmpty
                ? Center(
                    child: EasyText(
                    text: AppLocalizations.of(context)!.no_sale,
                    fontSize: kFs16x,
                  ))
                : context.responsive(
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: kAs20x),
                      child: MobileListView(
                        list: saleVouchers,
                        isSale: true,
                        scrollController:
                            _saleVoucherProvider.saleScrollController,
                      ),
                    ),
                    lg: TabletGridView(
                      list: saleVouchers,
                      childAspectRatio: 2.7,
                      crossAxisCount: 3,
                      isSale: true,
                      scrollController:
                          _saleVoucherProvider.saleScrollController,
                    ),
                    md: TabletGridView(
                      list: saleVouchers,
                      childAspectRatio: 2.7,
                      crossAxisCount: 2,
                      isSale: true,
                      scrollController:
                          _saleVoucherProvider.saleScrollController,
                    )));
  }
}

class ReturnViewItem extends StatefulWidget {
  const ReturnViewItem({super.key});

  @override
  State<ReturnViewItem> createState() => _ReturnViewItemState();
}

class _ReturnViewItemState extends State<ReturnViewItem> {
  late ReturnVoucherProvider _returnVoucherProvider;
  List<ReturnVoucherVM>? todayReturnVouchers;
  bool _isInitialize = false;

  @override
  void didChangeDependencies() {
    _returnVoucherProvider = context.watch<ReturnVoucherProvider>();
    todayReturnVouchers = !_returnVoucherProvider.isFilter
        ? _returnVoucherProvider.todayReturnVoucher
        : _returnVoucherProvider.filteredReturnVoucher;
    if (!_isInitialize) {
      _returnVoucherProvider.getReturnVouchers();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    _isInitialize = true;
    return Scaffold(
      backgroundColor: kBackGroundColor,
      body: _returnVoucherProvider.isLoading
          ? context.showLoading()
          : todayReturnVouchers == null || todayReturnVouchers!.isEmpty
              ? Center(
                  child: EasyText(
                    text: AppLocalizations.of(context)!.no_return,
                    fontSize: kFs16x,
                  ),
                )
              : context.responsive(
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: kAs20x),
                    child: MobileListView(
                      list: todayReturnVouchers ?? [],
                      isReturn: true,
                      scrollController:
                          _returnVoucherProvider.returnScrollController,
                    ),
                  ),
                  lg: TabletGridView(
                    list: todayReturnVouchers ?? [],
                    childAspectRatio: 2.7,
                    crossAxisCount: 3,
                    isReturn: true,
                    scrollController:
                        _returnVoucherProvider.returnScrollController,
                  ),
                  md: TabletGridView(
                    list: todayReturnVouchers ?? [],
                    childAspectRatio: 2.7,
                    crossAxisCount: 2,
                    isReturn: true,
                    scrollController:
                        _returnVoucherProvider.returnScrollController,
                  )),
    );
  }
}

class StatementViewItem extends StatefulWidget {
  const StatementViewItem({super.key});

  @override
  State<StatementViewItem> createState() => _StatementViewItemState();
}

class _StatementViewItemState extends State<StatementViewItem> {
  late CustomerProvider _customerProvider;
  List<CustomerPayment> _todayStatementPayments = [];
  bool _isInitialized = false;
  bool _isLoading = true;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    _customerProvider = context.watch<CustomerProvider>();
    if (!_isInitialized) {
      await _customerProvider.getTodayStatementReport();
      _isLoading = false;
    }
    _todayStatementPayments = _customerProvider.isFiltered
        ? _customerProvider.todayFilteredStatementPayments
        : _customerProvider.todayStatementPayments ?? [];
  }

  @override
  Widget build(BuildContext context) {
    _isInitialized = true;
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : _todayStatementPayments.isEmpty
            ? Center(
                child: EasyText(
                  text: AppLocalizations.of(context)!.no_statement,
                  fontSize: kFs16x,
                ),
              )
            : context.responsive(
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: kAs20x),
                  child: MobileListView(
                    list: _todayStatementPayments,
                    isPayment: true,
                    scrollController: _customerProvider.todayStatementScroll,
                  ),
                ),
                lg: TabletGridView(
                  list: _todayStatementPayments,
                  childAspectRatio: 2.3,
                  crossAxisCount: 3,
                  isPayment: true,
                  scrollController: _customerProvider.todayStatementScroll,
                ),
                md: TabletGridView(
                  list: _todayStatementPayments,
                  childAspectRatio: 2.2,
                  crossAxisCount: 2,
                  isPayment: true,
                  scrollController: _customerProvider.todayStatementScroll,
                ));
  }
}

class ReceivedTransferViewItem extends StatefulWidget {
  const ReceivedTransferViewItem(
      {super.key, required this.receivedTransferVouchers});

  final List<GroupedTransferVoucher> receivedTransferVouchers;

  @override
  State<ReceivedTransferViewItem> createState() =>
      _ReceivedTransferViewItemState();
}

class _ReceivedTransferViewItemState extends State<ReceivedTransferViewItem> {
  @override
  Widget build(BuildContext context) {
    return widget.receivedTransferVouchers.isEmpty
        ? Center(
            child: EasyText(
              text: AppLocalizations.of(context)!.no_transfer_received,
              fontSize: kFs16x,
            ),
          )
        : RefreshIndicator(
            onRefresh: () async {
              await context
                  .read<TransferVoucherProvider>()
                  .getReceivedTransferVouchers();
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: kAs20x),
              child: ListView.builder(
                itemCount: widget.receivedTransferVouchers.length,
                itemBuilder: (context, i) => ReportView(
                    isCollapse: widget.receivedTransferVouchers[i].isCollapse,
                    widgets:
                        (widget.receivedTransferVouchers[i].transferVouchers ??
                                [])
                            .map((e) => TransferVoucherCard(
                                  transferVm: e,
                                  isReceive: true,
                                ))
                            .toList(),
                    onTap: () {
                      setState(() {
                        widget.receivedTransferVouchers[i].isCollapse =
                            !widget.receivedTransferVouchers[i].isCollapse;
                      });
                    },
                    count:
                        (widget.receivedTransferVouchers[i].count ?? 0).toInt(),
                    date: widget.receivedTransferVouchers[i].date ?? ''),
              ),
            ),
          );
  }
}
