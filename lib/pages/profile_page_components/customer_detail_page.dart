import 'package:flutter/material.dart';
import 'package:desktop_test/constant/color.dart';
import 'package:desktop_test/constant/dimen.dart';
import 'package:desktop_test/data/vms/customer_payment/grouped_customer_payment.dart';
import 'package:desktop_test/data/vms/return_voucher/grouped_return_voucher.dart';
import 'package:desktop_test/data/vms/sale_voucher/grouped_sale_voucher.dart';
import 'package:desktop_test/data/vms/user/user.dart';
import 'package:desktop_test/provider/customer_provider.dart';
import 'package:desktop_test/utils/extension.dart';
import 'package:desktop_test/view_items/customer_detail_view_item.dart';
import 'package:desktop_test/view_items/filter_widget.dart';
import 'package:desktop_test/widgets/customer_card.dart';
import 'package:desktop_test/widgets/easy_app_bar.dart';
import 'package:desktop_test/widgets/easy_text.dart';
import 'package:provider/provider.dart';

class CustomerDetailPage extends StatefulWidget {
  const CustomerDetailPage({super.key, required this.customer});

  final UserVM customer;

  @override
  State<CustomerDetailPage> createState() => _CustomerDetailPageState();
}

class _CustomerDetailPageState extends State<CustomerDetailPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<GroupedSaleVoucher> _saleVouchers = [];
  List<GroupedReturnVoucher> _returnVouchers = [];
  List<GroupedCustomerPayment> _customerPayments = [];
  bool _isInitialized = false;
  late CustomerProvider _customerProvider;
  bool isLoading = true;
  int _tabIndex = 0;
  DateTime? _startDate;
  DateTime? _endDate;
  @override
  void initState() {
    isLoading = true;
    _tabController = TabController(length: _tabs.length, vsync: this);
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
          case 2:
            _loadDataForPayment();
            break;
        }
      }
    });
    super.initState();
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
      case 2:
        _getCustomerPayments();
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

  _getCustomerPayments() {
    _customerPayments = _customerProvider.customerPayments ?? [];
    if (_customerPayments.isNotEmpty) {
      _customerPayments.sort(
        (a, b) => b.date!
            .formatStringToDate()
            .compareTo(a.date!.formatStringToDate()),
      );
    }
  }

  _loadDataForSale() async {
    await _customerProvider.getSaleVouchers(
        widget.customer.userId ?? '', _startDate, _endDate);
    isLoading = false;
  }

  _loadDataForReturn() async {
    await _customerProvider.getReturnVouchers(
        widget.customer.userId ?? '', _startDate, _endDate);
    isLoading = false;
  }

  _loadDataForPayment() async {
    await _customerProvider.getCustomerPayments(
        widget.customer.userId ?? '', _startDate, _endDate);
    isLoading = false;
  }

  final List<Tab> _tabs = const [
    Tab(
      child: Text("Sale"),
    ),
    Tab(
      child: Text("Return"),
    ),
    Tab(
      child: Text("Payment"),
    )
  ];

  @override
  Widget build(BuildContext context) {
    _isInitialized = true;
    return Scaffold(
      backgroundColor: kBackGroundColor,
      appBar: PreferredSize(
          preferredSize: Size(getWidth(context), kToolbarHeight),
          child: const EasyAppBar(
            text: "Customer Detail",
            leading: true,
          )),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          context.responsive(
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomerCard(customerVM: widget.customer),
                  FilterWidget(
                    hintText: 'Type Voucher code',
                    textEditingController: _tabIndex == 0
                        ? _customerProvider.saleSearchController
                        : _tabIndex == 1
                            ? _customerProvider.returnSearchController
                            : _customerProvider.customerPaymentController,
                    isNeedCategory: false,
                    filter: ({category, endDate, startDate}) => _filterFunction(
                        category: category,
                        endDate: endDate,
                        startDate: startDate),
                  )
                ],
              ),
              lg: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomerCard(customerVM: widget.customer),
                  Expanded(
                    child: FilterWidget(
                      hintText: 'Type Voucher code',
                      textEditingController:
                          _customerProvider.saleSearchController,
                      isNeedCategory: false,
                      filter: ({category, endDate, startDate}) =>
                          _filterFunction(
                              category: category,
                              endDate: endDate,
                              startDate: startDate),
                    ),
                  )
                ],
              )),
          Container(
              color: kBackGroundColor,
              height: kAs50x,
              child: TabBar(
                controller: _tabController,
                tabs: _tabs,
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
              isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : _customerPayments.isEmpty
                      ? const Center(
                          child: EasyText(
                            text: "There is no payments",
                            fontSize: kFs16x,
                          ),
                        )
                      : CustomerPaymentViewItem(
                          customerPayments: _customerPayments)
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
        await _customerProvider.getSaleVouchers(widget.customer.userId ?? '',
            startDate ?? DateTime.now(), endDate ?? DateTime.now());
        break;
      case 1:
        await _customerProvider.getReturnVouchers(widget.customer.userId ?? '',
            startDate ?? DateTime.now(), endDate ?? DateTime.now());
        break;
      case 2:
        await _customerProvider.getCustomerPayments(
            widget.customer.userId ?? '',
            startDate ?? DateTime.now(),
            endDate ?? DateTime.now());
        break;
    }
    isLoading = false;
  }
}
