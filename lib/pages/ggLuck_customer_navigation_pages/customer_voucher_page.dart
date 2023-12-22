import 'package:flutter/material.dart';
import 'package:desktop_test/constant/color.dart';
import 'package:desktop_test/persistent/daos/user_dao/access_token_dao_impl.dart';
import 'package:desktop_test/utils/extension.dart';
import 'package:provider/provider.dart';

import '../../constant/dimen.dart';
import '../../data/vms/return_voucher/grouped_return_voucher.dart';
import '../../data/vms/sale_voucher/grouped_sale_voucher.dart';
import '../../provider/customer_provider.dart';
import '../../view_items/customer_detail_view_item.dart';
import '../../view_items/filter_widget.dart';
import '../../widgets/easy_app_bar.dart';
import '../../widgets/easy_text.dart';

class CustomerVoucherPage extends StatefulWidget {
  const CustomerVoucherPage({super.key});

  @override
  State<CustomerVoucherPage> createState() => _CustomerVoucherPageState();
}

class _CustomerVoucherPageState extends State<CustomerVoucherPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<GroupedSaleVoucher> _saleVouchers = [];
  List<GroupedReturnVoucher> _returnVouchers = [];
  bool _isInitialized = false;
  late CustomerProvider _customerProvider;
  bool isLoading = true;
  int _tabIndex = 0;
  DateTime? _startDate;
  DateTime? _endDate;
  String id = AccessTokenDaoImpl().getTokenFromDatabase()?.user?.id ?? '';
  @override
  void initState() {
    isLoading = true;
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabIndex != _tabController.index) {
        if (mounted) {
          setState(() {
            isLoading = true;
          });
        }
        _tabIndex = _tabController.index;
        switch (_tabIndex) {
          case 0:
            _loadDataForSale();
            break;
          case 1:
            _loadDataForReturn();
            break;
        }
      }
    });
    super.initState();
  }

  _loadDataForSale() async {
    await _customerProvider.getSaleVouchers(id, _startDate, _endDate);
    isLoading = false;
  }

  _loadDataForReturn() async {
    await _customerProvider.getReturnVouchers(id, _startDate, _endDate);
    isLoading = false;
  }

  @override
  void didChangeDependencies() async {
    _customerProvider = context.watch<CustomerProvider>();
    if (!_isInitialized) {
      _loadDataForSale();
    }
    switch (_tabIndex) {
      case 0:
        _getSaleVouchers();
        break;
      case 1:
        _getReturnVouchers();
        break;
    }
    super.didChangeDependencies();
  }

  _getSaleVouchers() {
    _saleVouchers = _customerProvider.saleVouchers ?? [];
    if (_saleVouchers.isNotEmpty) {
      _saleVouchers.sort(
        (a, b) => b.date!
            .formatStringToDate()
            .compareTo(a.date!.formatStringToDate()),
      );
    }
  }

  _getReturnVouchers() {
    _returnVouchers = _customerProvider.returnVouchers ?? [];
    if (_returnVouchers.isNotEmpty) {
      _returnVouchers.sort(
        (a, b) => b.date!
            .formatStringToDate()
            .compareTo(a.date!.formatStringToDate()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    _isInitialized = true;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(getWidth(context), kToolbarHeight),
          child: const EasyAppBar(
            text: "Voucher",
          )),
      backgroundColor: kBackGroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FilterWidget(
            hintText: 'Type Voucher code',
            textEditingController: _tabIndex == 0
                ? _customerProvider.saleSearchController
                : _customerProvider.returnSearchController,
            isNeedCategory: false,
            filter: ({category, endDate, startDate}) => _filterFunction(
                category: category, endDate: endDate, startDate: startDate),
          ),
          Container(
              color: kBackGroundColor,
              height: kAs50x,
              child: TabBar(
                controller: _tabController,
                tabs: const [
                  Tab(
                    child: Text("Sale"),
                  ),
                  Tab(
                    child: Text("Return"),
                  ),
                ],
                labelColor: kPrimaryTextColor,
                unselectedLabelColor: kSecondaryTextColor,
                indicatorPadding: const EdgeInsets.symmetric(horizontal: kAs5x),
              )),
          Expanded(
              child: TabBarView(
            controller: _tabController,
            children: [
              isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : _saleVouchers.isEmpty
                      ? const Center(
                          child: EasyText(
                            text: "There is no sale Vouchers",
                            fontSize: kFs16x,
                          ),
                        )
                      : CustomerSaleViewItem(
                          groupedSaleVouchers: _saleVouchers,
                        ),
              isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : _returnVouchers.isEmpty
                      ? const Center(
                          child: EasyText(
                            text: "There is no return Vouchers",
                            fontSize: kFs16x,
                          ),
                        )
                      : CustomerReportViewItem(
                          returnVouchers: _returnVouchers,
                        ),
            ],
          ))
        ],
      ),
    );
  }

  _filterFunction(
      {String? category, DateTime? endDate, DateTime? startDate}) async {
    _startDate = startDate;
    _endDate = endDate;
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }
    switch (_tabIndex) {
      case 0:
        await _customerProvider.getSaleVouchers(
            id, startDate ?? DateTime.now(), endDate ?? DateTime.now());
        break;
      case 1:
        await _customerProvider.getReturnVouchers(
            id, startDate ?? DateTime.now(), endDate ?? DateTime.now());
        break;
    }
    isLoading = false;
  }
}
