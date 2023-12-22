import 'package:flutter/material.dart';
import 'package:desktop_test/constant/color.dart';
import 'package:desktop_test/data/vms/return_voucher/return_voucher.dart';
import 'package:desktop_test/data/vms/sale_voucher/sale_voucher.dart';
import 'package:desktop_test/pages/voucher_page_components/sliver_header.dart';
import 'package:desktop_test/provider/customer_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:desktop_test/provider/return_voucher_provider.dart';
import 'package:desktop_test/provider/sale_voucher_provider.dart';
import 'package:desktop_test/provider/transfer_voucher_provider.dart';
import 'package:desktop_test/utils/extension.dart';
import 'package:desktop_test/view_items/voucher_view_item.dart';
import 'package:desktop_test/widgets/easy_sliver_app_bar.dart';
import 'package:desktop_test/widgets/item_count_widget.dart';
import 'package:provider/provider.dart';

import '../../constant/dimen.dart';
import '../../data/vms/customer_payment/customer_payment.dart';
import '../../widgets/reuse_floating_button.dart';
import '../voucher_creating_pages/selected_voucher_page.dart';

class VoucherPage extends StatefulWidget {
  const VoucherPage({super.key});

  @override
  State<VoucherPage> createState() => _VoucherPageState();
}

class _VoucherPageState extends State<VoucherPage>
    with SingleTickerProviderStateMixin {
  ScrollPhysics? physics = const NeverScrollableScrollPhysics();
  late TabController _tabController;
  int _tabIndex = 0;
  late SaleVoucherProvider _saleVoucherProvider;
  late ReturnVoucherProvider _returnVoucherProvider;
  late CustomerProvider _customerStatementProvider;
  late TransferVoucherProvider _transferVoucherProvider;
  final TextEditingController _saleTextController = TextEditingController();
  final TextEditingController _returnTextController = TextEditingController();
  final TextEditingController _statementTextController =
      TextEditingController();
  List<SaleVoucherVM> _todaySaleVouchers = [];
  List<ReturnVoucherVM> _todayReturnVouchers = [];
  List<CustomerPayment> _todayCustomerPayments = [];
  @override
  void initState() {
    physics = const NeverScrollableScrollPhysics();
    _tabController = TabController(length: tabs.length, vsync: this);
    _tabController.addListener(() {
      if (_tabIndex != _tabController.index) {
        physics = const NeverScrollableScrollPhysics();
        FocusScope.of(context).unfocus();
        _tabIndex = _tabController.index;
        if (_tabIndex == 3) {
          _transferVoucherProvider.getReceivedTransferVouchers();
        }
      }
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _saleVoucherProvider = context.watch<SaleVoucherProvider>();
    _returnVoucherProvider = context.watch<ReturnVoucherProvider>();
    _customerStatementProvider = context.watch<CustomerProvider>();
    _transferVoucherProvider = context.watch<TransferVoucherProvider>();
    _tabIndex == 0
        ? _todaySaleVouchers = !_saleVoucherProvider.isFilter
            ? _saleVoucherProvider.todaySaleVoucher ?? []
            : _saleVoucherProvider.filteredSaleVouchers
        : _tabIndex == 1
            ? _todayReturnVouchers = !_returnVoucherProvider.isFilter
                ? _returnVoucherProvider.todayReturnVoucher ?? []
                : _returnVoucherProvider.filteredReturnVoucher
            : _todayCustomerPayments = _customerStatementProvider.isFiltered
                ? _customerStatementProvider.todayFilteredStatementPayments
                : _customerStatementProvider.todayStatementPayments ?? [];
    _tabIndex == 0
        ? _saleVoucherProvider.saleScrollController.addListener(() {
            if (physics == const NeverScrollableScrollPhysics()) {
              physics = const ClampingScrollPhysics();
            }
          })
        : _tabIndex == 1
            ? _returnVoucherProvider.returnScrollController.addListener(() {
                if (physics == const NeverScrollableScrollPhysics()) {
                  physics = const ClampingScrollPhysics();
                }
              })
            : 0;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _returnTextController.dispose();
    _saleTextController.dispose();
    _statementTextController.dispose();
    super.dispose();
  }

  List<Tab> tabs = [
    const Tab(
      child: Text('Sales'),
    ),
    const Tab(
      child: Text('Returns'),
    ),
    const Tab(
      child: Text('Statement'),
    ),
    const Tab(
      child: Text('Received'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackGroundColor,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: NestedScrollView(
          physics: physics,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            EasySliverAppBar(
              expandedHeight: kAs130x,
              title: AppLocalizations.of(context)!.voucher,
              hintText: AppLocalizations.of(context)!.search_voucher,
              onChange: _tabIndex == 0
                  ? (value) {
                      _saleVoucherProvider
                          .filterSaleVoucherLocal(_saleTextController);
                    }
                  : _tabIndex == 1
                      ? (value) {
                          _returnVoucherProvider
                              .filterReturnVoucherLocal(_returnTextController);
                        }
                      : (value) {
                          _customerStatementProvider.filterStatementReportLocal(
                              _statementTextController);
                        },
              textEditingController: _tabIndex == 0
                  ? _saleTextController
                  : _tabIndex == 1
                      ? _returnTextController
                      : _tabIndex == 2
                          ? _statementTextController
                          : _transferVoucherProvider.transferReceivedController,
            ),
            SliverPersistentHeader(
                pinned: true,
                delegate: PersistentHeaderDelegateWidget(
                  Container(
                    height: kAs50x,
                    color: kBackGroundColor,
                    padding: EdgeInsets.only(
                        left: context.responsive(kAs20x, lg: 0, md: 0)),
                    child: TabBar(
                      isScrollable:
                          context.responsive(true, lg: false, md: false),
                      controller: _tabController,
                      tabs: tabs,
                      labelColor: kPrimaryTextColor,
                      unselectedLabelColor: kSecondaryTextColor,
                      indicatorPadding:
                          const EdgeInsets.symmetric(horizontal: kAs5x),
                    ),
                  ),
                )),
            SliverPersistentHeader(
                pinned: true,
                delegate: PersistentHeaderDelegateWidget(
                  Container(
                      height: kAs50x,
                      color: kBackGroundColor,
                      child: ItemCountWidget(
                          count: _tabIndex == 0
                              ? _todaySaleVouchers.isEmpty
                                  ? 0
                                  : _todaySaleVouchers.length
                              : _tabIndex == 1
                                  ? _returnVoucherProvider.isLoading
                                      ? 0
                                      : _todayReturnVouchers.length
                                  : _tabIndex == 3
                                      ? _transferVoucherProvider.isLoading
                                          ? 0
                                          : _transferVoucherProvider.count
                                      : _customerStatementProvider.isLoading
                                          ? 0
                                          : _todayCustomerPayments.length)),
                ))
          ],
          body: TabBarView(controller: _tabController, children: [
            const SaleViewItem(),
            const ReturnViewItem(),
            const StatementViewItem(),
            _transferVoucherProvider.isLoading
                ? context.showLoading()
                : ReceivedTransferViewItem(
                    receivedTransferVouchers: _transferVoucherProvider
                            .receivedGroupedTransferVouchers ??
                        [],
                  )
          ]),
        ),
      ),
      floatingActionButton: _tabIndex == 2 || _tabIndex == 3
          ? null
          : ReuseFloatingActionButton(
              page: SelectedVoucherPage(
                isSale: _tabIndex == 0 ? true : false,
              ),
              padding: 0,
            ),
    );
  }
}
