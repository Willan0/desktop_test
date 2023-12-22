import 'package:flutter/cupertino.dart';
import 'package:desktop_test/data/data_apply/data_apply/gg_luck_data_apply_imp.dart';
import 'package:desktop_test/data/data_apply/data_apply/gg_luck_data_apply.dart';
import 'package:desktop_test/data/vms/customer_payment/customer_payment.dart';
import 'package:desktop_test/data/vms/customer_payment/grouped_customer_payment.dart';
import 'package:desktop_test/data/vms/gold_price/gold_price.dart';
import 'package:desktop_test/data/vms/return_voucher/grouped_return_voucher.dart';
import 'package:desktop_test/data/vms/sale_voucher/grouped_sale_voucher.dart';
import 'package:desktop_test/data/vms/user/user.dart';
import 'package:desktop_test/utils/extension.dart';
import 'package:desktop_test/utils/unit_converter.dart';

class CustomerProvider extends ChangeNotifier {
  bool _isDispose = true;
  num gold16Price = 0;
  bool _isPayWithGold = false;
  bool _isDiscount = false;
  List<UserVM>? _customers;
  List<UserVM> _filteredCustomers = [];
  List<GroupedSaleVoucher>? _saleVouchers;
  List<GoldPrice> goldPrices = [];
  bool _isLoading = true;
  List<GroupedReturnVoucher>? _returnVouchers;
  final ScrollController _scrollControllerForTodayStatement =
      ScrollController();
  List<GroupedCustomerPayment>? _customerPayments;
  List<GroupedCustomerPayment>? _statementReportPayments;
  List<CustomerPayment>? _todayStatementPayments;
  List<CustomerPayment> _todayFilteredStatementPayments = [];
  bool _isFiltered = false;
  final TextEditingController _saleSearchController = TextEditingController();
  final TextEditingController _returnSearchController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _paymentSearchController =
      TextEditingController();
  final TextEditingController _customerPaymentController =
      TextEditingController();
  final TextEditingController _totalAmtPaymentController =
      TextEditingController();
  final TextEditingController _remarkForCreatingCustomerPayment =
      TextEditingController();
  final TextEditingController _filterStatementReport = TextEditingController();
  final TextEditingController _kyatPaymentController = TextEditingController();
  final TextEditingController _paePaymentController = TextEditingController();
  final TextEditingController _yawePaymentController = TextEditingController();
  final TextEditingController _gramPaymentController = TextEditingController();
  final TextEditingController _goldPriceController = TextEditingController();
  final TextEditingController _customerSearchController =
      TextEditingController();
  final TextEditingController _remarkCustomerPayment = TextEditingController();
  GlobalKey<FormState> get formKey => _formKey;
  final ScrollController _customerScrollController = ScrollController();
  TextEditingController get totalAmtPaymentController =>
      _totalAmtPaymentController;
  List<GroupedCustomerPayment>? get statementPayments =>
      _statementReportPayments;
  TextEditingController get kyatPaymentController => _kyatPaymentController;
  TextEditingController get gramPaymentController => _gramPaymentController;
  TextEditingController get paePaymentController => _paePaymentController;
  TextEditingController get yawePaymentController => _yawePaymentController;
  TextEditingController get customerPaymentController =>
      _customerPaymentController;
  TextEditingController get goldPriceController => _goldPriceController;
  TextEditingController get remarkCustomerPayment => _remarkCustomerPayment;
  TextEditingController get customerSearchController =>
      _customerSearchController;
  TextEditingController get filterStatementReport => _filterStatementReport;
  List<GroupedCustomerPayment>? get customerPayments => _customerPayments;
  TextEditingController get saleSearchController => _saleSearchController;
  TextEditingController get returnSearchController => _returnSearchController;
  TextEditingController get paymentSearchController => _paymentSearchController;
  List<GroupedReturnVoucher>? get returnVouchers => _returnVouchers;
  List<GroupedSaleVoucher>? get saleVouchers => _saleVouchers;
  List<GroupedCustomerPayment>? get statementReportPayments =>
      _statementReportPayments;
  TextEditingController get remarkForCreatingCustomerPayment =>
      _remarkForCreatingCustomerPayment;
  ScrollController get customerScrollController => _customerScrollController;
  List<CustomerPayment>? get todayStatementPayments => _todayStatementPayments;
  List<CustomerPayment> get todayFilteredStatementPayments =>
      _todayFilteredStatementPayments;
  bool get isLoading => _isLoading;
  ScrollController get todayStatementScroll =>
      _scrollControllerForTodayStatement;
  bool get isFiltered => _isFiltered;
  List<UserVM>? get customers => _customers;
  List<UserVM> get filteredCustomers => _filteredCustomers;
  bool get isPayWithGold => _isPayWithGold;
  bool get isDiscount => _isDiscount;

  set setPayWithGold(bool value) {
    _isPayWithGold = value;
  }

  set setDiscount(bool value) {
    _isDiscount = value;
  }

  final GgLuckDataApply _ggLuckDataApply = GgLuckDataApplyImpl();

  CustomerProvider() {
    // getCustomers();
    getGoldPrices();
  }

  void checkPayWithGoldOrNot() {
    _isPayWithGold = !_isPayWithGold;
    notifyListeners();
  }

  void checkIsDiscountOrNot() {
    _isDiscount = !_isDiscount;
    notifyListeners();
  }

  void setGoldPriceManually() {
    gold16Price = _goldPriceController.text.textToNum();
    if (_gramPaymentController.text.isNotEmpty) {
      changeGramToKyatPaeYaweAndTotalAmt();
    }
  }

  Future<void> getCustomers() async {
    _isFiltered = false;
    _customers = await _ggLuckDataApply.getCustomers();
    notifyListeners();
  }

  Future<void> getGoldPrices() async {
    goldPrices = await _ggLuckDataApply.getGoldPrice() ?? [];
    if (goldPrices.isNotEmpty) {
      for (var prices in goldPrices) {
        if (prices.stateId?.trim().toString() == "A0") {
          gold16Price = prices.goldPrice ?? 0;
          _goldPriceController.text = gold16Price.toString();
        }
      }
    } else {
      _goldPriceController.text = gold16Price.toString();
    }
  }

  Future<void> getSaleVouchers(
      String customerId, DateTime? startDate, DateTime? endDate) async {
    _saleVouchers = await _ggLuckDataApply.getSaleVouchersByCustomer(
        customerId,
        (startDate ?? DateTime.now()).formatForFilter(),
        (endDate ?? DateTime.now()).formatForFilter(),
        saleSearchController.text);
    notifyListeners();
  }

  Future<void> getReturnVouchers(
      String customerId, DateTime? startDate, DateTime? endDate) async {
    _returnVouchers = await _ggLuckDataApply.getReturnVouchersByCustomer(
        customerId,
        (startDate ?? DateTime.now()).formatForFilter(),
        (endDate ?? DateTime.now()).formatForFilter(),
        _returnSearchController.text);
    notifyListeners();
  }

  Future<void> getCustomerPayments(
      String customerId, DateTime? startDate, DateTime? endDate) async {
    _customerPayments = await _ggLuckDataApply.getCustomerPaymentsByCustomer(
        customerId,
        (startDate ?? DateTime.now()).formatForFilter(),
        (endDate ?? DateTime.now()).formatForFilter(),
        _customerPaymentController.text);
    notifyListeners();
  }

  Future<void> getTodayStatementReport() async {
    _isFiltered = false;
    List<GroupedCustomerPayment>? groupedCustomers =
        await _ggLuckDataApply.getCustomerPayments(
            DateTime.now().formatForFilter(),
            DateTime.now().formatForFilter(),
            '',
            'all');
    if (groupedCustomers != null && groupedCustomers.isNotEmpty) {
      _todayStatementPayments = groupedCustomers.first.customerPayments;
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> getStatementPaymentsReports(
      DateTime? startDate, DateTime? endDate,
      [int index = 0]) async {
    _statementReportPayments = await _ggLuckDataApply.getCustomerPayments(
        (startDate ?? DateTime.now()).formatForFilter(),
        (endDate ?? DateTime.now()).formatForFilter(),
        filterStatementReport.text,
        index == 0 ? "active" : "delete");
    notifyListeners();
  }

  void filterStatementReportLocal(TextEditingController textController) {
    _isLoading = true;
    _isFiltered = true;
    _todayFilteredStatementPayments = [];
    if (textController.text.isEmpty) {
      getTodayStatementReport();
    } else {
      if (_todayStatementPayments != null) {
        for (var payment in _todayStatementPayments!) {
          if (payment.paymentVno!
              .trim()
              .toLowerCase()
              .contains(textController.text.trim().toLowerCase())) {
            _todayFilteredStatementPayments.add(payment);
          }
        }
      }
    }
    _isLoading = false;
    notifyListeners();
    _scrollControllerForTodayStatement.jumpTo(0);
  }

  void filterCustomersLocal() {
    _filteredCustomers = [];
    _isFiltered = true;
    if (_customerSearchController.text.isEmpty) {
      getCustomers();
    } else {
      if (_customers != null) {
        for (var customer in _customers!) {
          if (customer.fullName!
              .toLowerCase()
              .trim()
              .contains(_customerSearchController.text.trim().toLowerCase())) {
            _filteredCustomers.add(customer);
          }
        }
      }
    }
    notifyListeners();
    _customerScrollController.jumpTo(0);
  }

  void changeGramToKyatPaeYaweAndTotalAmt() {
    List<num> kpyList = UnitConverter.changeGramToGoldWeight(
        _gramPaymentController.text.textToNum());
    _kyatPaymentController.text = kpyList[0].toString();
    _paePaymentController.text = kpyList[1].toString();
    _yawePaymentController.text = kpyList[2].toStringAsFixed(2);
    _totalAmtPaymentController.text = UnitConverter.calculateTheTotalAmtForKPY(
            _kyatPaymentController.text.textToNum(),
            _paePaymentController.text.textToNum(),
            _yawePaymentController.text.textToNum(),
            gold16Price)
        .toStringAsFixed(0);
    notifyListeners();
  }

  void clearText() {
    gold16Price = 0;
    _totalAmtPaymentController.clear();
    _gramPaymentController.clear();
    _kyatPaymentController.clear();
    _paePaymentController.clear();
    _yawePaymentController.clear();
    _goldPriceController.clear();
    notifyListeners();
  }

  void changeKyatPaeYaweToGramAndTotalAmt() {
    num kyat = _kyatPaymentController.text.textToNum();
    num pae = _paePaymentController.text.textToNum();
    num yawe = _yawePaymentController.text.textToNum();
    _gramPaymentController.text =
        UnitConverter.changeGoldWeightToGram(kyat, pae, yawe)
            .floorAsFixedTwo()
            .toString();

    _totalAmtPaymentController.text =
        UnitConverter.calculateTheTotalAmtForKPY(kyat, pae, yawe, gold16Price)
            .toStringAsFixed(0);
    notifyListeners();
  }

  void changeTotalAmtToGramAndKYP() {
    List<num> kpyList = UnitConverter.calculateTotalToKPY(
        _totalAmtPaymentController.text.textToNum(), gold16Price);
    _kyatPaymentController.text = kpyList[0].floor().toString();
    _paePaymentController.text = kpyList[1].floor().toString();
    _yawePaymentController.text = kpyList[2].floorAsFixedTwo().toString();
    _gramPaymentController.text =
        UnitConverter.changeGoldWeightToGram(kpyList[0], kpyList[1], kpyList[2])
            .floorAsFixedTwo()
            .toString();
    notifyListeners();
  }

  void chooseCustomer() {
    if (_isFiltered) {
      if (filteredCustomers.isNotEmpty) {
        for (var c in filteredCustomers) {
          if (c.isSelect == true) {
            _ggLuckDataApply.saveSelectedCustomer(c);
          }
        }
      }
    } else {
      if (_customers != null) {
        for (var c in _customers!) {
          if (c.isSelect == true) {
            _ggLuckDataApply.saveSelectedCustomer(c);
          }
        }
      }
    }
  }

  Future createCustomerPayment(UserVM customer) async {
    final String paymentVno = DateTime.now().microsecond.toString();
    await _ggLuckDataApply.createCustomerPayment(CustomerPayment(
      paymentVno: "P-$paymentVno",
      lat: "0",
      long: "0",
      customerId: customer.userId,
      customerName: customer.userName,
      isDiscount: _isDiscount,
      isGold: _isPayWithGold,
      goldPrice: gold16Price,
      remark: _remarkForCreatingCustomerPayment.text,
      kyat: _kyatPaymentController.text.textToNum().floor(),
      pae: _paePaymentController.text.textToNum().floor(),
      yawe: _yawePaymentController.text.textToNum().floorAsFixedTwo(),
      gram: _gramPaymentController.text.textToNum().floorAsFixedTwo(),
      totalAmt: _totalAmtPaymentController.text.textToNum().floorAsFixedTwo(),
      date: DateTime.now().formatDateTimeForCreate(),
    ));
  }

  void setSelect(int index) {
    clearText();
    if (_isFiltered) {
      _filteredCustomers[index].isSelect = true;
      for (int i = 0; i < _filteredCustomers.length; i++) {
        if (i != index) _filteredCustomers[i].isSelect = false;
      }
    } else {
      _customers?[index].isSelect = true;
      for (int i = 0; i < _customers!.length; i++) {
        if (i != index) _customers?[i].isSelect = false;
      }
    }
    notifyListeners();
  }

  void cancelSelect() {
    // gold16Price = 0;
    if (_isFiltered) {
      for (int i = 0; i < filteredCustomers.length; i++) {
        filteredCustomers[i].isSelect = false;
      }
    } else {
      for (int i = 0; i < _customers!.length; i++) {
        _customers?[i].isSelect = false;
      }
    }

    notifyListeners();
  }

  Future<void> deleteCustomerPayment(String vNo) async {
    await _ggLuckDataApply.deleteCustomerPayment(
        vNo, _remarkCustomerPayment.text);
  }

  @override
  void notifyListeners() {
    if (_isDispose) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _filterStatementReport.dispose();
    _gramPaymentController.dispose();
    _kyatPaymentController.dispose();
    _yawePaymentController.dispose();
    _paePaymentController.dispose();
    _customerScrollController.dispose();
    _customerSearchController.dispose();
    _saleSearchController.dispose();
    _returnSearchController.dispose();
    _paymentSearchController.dispose();
    _remarkCustomerPayment.dispose();
    _totalAmtPaymentController.dispose();
    _remarkForCreatingCustomerPayment.dispose();
    _isDispose = false;
    super.dispose();
  }
}
