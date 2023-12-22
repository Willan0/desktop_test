import 'package:flutter/cupertino.dart';
import 'package:desktop_test/data/data_apply/data_apply/gg_luck_data_apply.dart';
import 'package:desktop_test/data/data_apply/data_apply/gg_luck_data_apply_imp.dart';
import 'package:desktop_test/data/vms/access_token/user/access_token_user.dart';
import 'package:desktop_test/data/vms/transfer_voucher/grouped_transfer_voucher.dart';
import 'package:desktop_test/data/vms/transfer_voucher/transfer_voucher.dart';
import 'package:desktop_test/data/vms/transfer_voucher/transfer_voucher_detail.dart';
import 'package:desktop_test/data/vms/user/user.dart';
import 'package:desktop_test/persistent/daos/user_dao/access_token_dao_impl.dart';
import 'package:desktop_test/utils/extension.dart';

import '../data/vms/gold_price/gold_price.dart';
import '../data/vms/issue_stock/issue_stock_vm.dart';
import '../data/vms/sale_voucher/total_value_vm.dart';
import '../utils/unit_converter.dart';
import '../view_items/create_voucher_view_item.dart';

class TransferVoucherProvider extends ChangeNotifier {
  bool _isDispose = false;
  num value = 0;
  bool _isLoading = true;
  num goldPriceFor16k = 0;
  int _count = 0;
  DateTime? _startDate;
  DateTime? _endDate;
  String? _type;
  bool _isHaveSelectedItem = false;
  List<IssueStockVM>? _issuesList;
  List<IssueStockVM>? _selectedIssuesList;
  List<IssueStockVM> _filteredIssuesList = [];
  List<TransferVoucherDetailVM>? _transferVouchersDetail;
  List<GoldPrice>? _goldPricesOfState;
  String? _recepentUserId;
  List<GroupedTransferVoucher>? _groupedTransferVouchers;
  List<GroupedTransferVoucher>? _receivedGroupedTransferVouchers;
  late TotalValueVM _totalValueVM;
  List<UserVM>? _marketingUsers;
  bool _isFilter = false;
  TransferType? _transferType = TransferType.marketing;

  final TextEditingController _qTextController = TextEditingController();
  final TextEditingController _voucherOrCsController = TextEditingController();
  final TextEditingController _gramTextController = TextEditingController();
  final TextEditingController _kTextController = TextEditingController();
  final TextEditingController _pTextController = TextEditingController();
  final TextEditingController _yTextController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _transferScrollController = ScrollController();
  final TextEditingController _transferReceivedController =
      TextEditingController();
  final TextEditingController _receiveRemarkController =
      TextEditingController();
  final TextEditingController _receivedPendingDeleteController =
      TextEditingController();

  ///instance
  final GgLuckDataApply _ggLuckDataApply = GgLuckDataApplyImpl();

  /// getter
  bool get isLoading => _isLoading;

  TextEditingController get transferReceivedController =>
      _transferReceivedController;

  DateTime? get startDate => _startDate;

  DateTime? get endDate => _endDate;

  String? get type => _type;

  TextEditingController get qTextController => _qTextController;

  TextEditingController get receiveRemarkController => _receiveRemarkController;

  TextEditingController get receivedPendingDeleteController =>
      _receivedPendingDeleteController;

  List<GroupedTransferVoucher>? get receivedGroupedTransferVouchers =>
      _receivedGroupedTransferVouchers;

  TextEditingController get voucherOrCsController => _voucherOrCsController;

  TextEditingController get gramTextController => _gramTextController;

  String? get recepentUserId => _recepentUserId;

  set setRecepentUserId(String value) {
    _recepentUserId = value;
  }

  TotalValueVM get totalValueVM => _totalValueVM;

  TextEditingController get kTextController => _kTextController;

  List<GroupedTransferVoucher>? get groupedTransferVouchers =>
      _groupedTransferVouchers;

  List<TransferVoucherDetailVM>? get transferVouchersDetail =>
      _transferVouchersDetail;

  int get count => _count;

  TransferType? get transferType => _transferType;

  set setTransferType(TransferType? value) {
    _transferType = value;
    notifyListeners();
  }

  TextEditingController get pTextController => _pTextController;
  TextEditingController get yTextController => _yTextController;
  TextEditingController get searchController => _searchController;
  ScrollController get transferScrollController => _transferScrollController;
  List<IssueStockVM>? get issuesList => _issuesList;
  List<IssueStockVM> get filteredIssueList => _filteredIssuesList;
  bool get isHaveSelectedItem => _isHaveSelectedItem;
  List<IssueStockVM>? get selectedIssuesList => _selectedIssuesList;
  List<GoldPrice>? get goldPricesOfState => _goldPricesOfState;
  List<UserVM>? get marketingUsers => _marketingUsers;
  bool get isFilter => _isFilter;

  TransferVoucherProvider() {
    value =
        AccessTokenDaoImpl().getTokenFromDatabase()!.adjustValues!.first.value!;
  }

  Future<void> getIssues() async {
    _isFilter = false;
    _issuesList = await _ggLuckDataApply.getIssues();
    notifyListeners();
  }

  Future<void> getTransferVouchersReport(
      DateTime? startDate, DateTime? endDate, String type,
      {int index = 0}) async {
    _startDate = startDate;
    _endDate = endDate;
    _type = type;
    _groupedTransferVouchers = await _ggLuckDataApply.getTransferReports(
        (_startDate ?? DateTime.now()).formatForFilter(),
        (_endDate ?? DateTime.now()).formatForFilter(),
        voucherOrCsController.text,
        _type ?? '',
        index == 0
            ? "Pending"
            : index == 1
                ? "Transferred"
                : "Received");
    notifyListeners();
  }

  void filterIssuesStock() {
    if (_issuesList == null) return;
    _filteredIssuesList = [];
    _isFilter = true;
    if (_searchController.text.isEmpty) {
      getIssues();
    } else {
      for (var issue in _issuesList!) {
        if (issue.gglCode!.contains(_searchController.text) ||
            issue.itemName!.contains(_searchController.text)) {
          _filteredIssuesList.add(issue);
        }
      }
    }
    notifyListeners();
    _transferScrollController.jumpTo(0);
  }

  Future<void> receiveTransferVoucher(String transferVno) async {
    await _ggLuckDataApply.receiveTransferVoucher(
        transferVno, _receiveRemarkController.text);
  }

  Future<void> getReceivedTransferVouchers() async {
    if (!_isLoading) {
      _count = 0;
      _isLoading = true;
      notifyListeners();
    }
    _receivedGroupedTransferVouchers = await _ggLuckDataApply
        .getReceivedTransferVouchers(_transferReceivedController.text);
    if (_receivedGroupedTransferVouchers?.isNotEmpty ?? false) {
      for (var v in _receivedGroupedTransferVouchers!) {
        _count += v.count!.toInt();
      }
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> deleteTransferVoucher(String vNo) async {
    await _ggLuckDataApply.deleteTransferVoucher(vNo);
    notifyListeners();
  }

  Future<void> getSelectedIssues() async {
    _ggLuckDataApply.getSelectedIssues().listen((selectedIssues) {
      _isHaveSelectedItem = false;
      _selectedIssuesList = selectedIssues;
      if (selectedIssues != null && selectedIssues.isNotEmpty) {
        _isHaveSelectedItem = true;
      }
      notifyListeners();
    });
    await getGoldPricesOfState();
  }

  Future<void> getGoldPricesOfState() async {
    _goldPricesOfState = await _ggLuckDataApply.getGoldPrice();
    if (_goldPricesOfState != null) {
      for (var prices in _goldPricesOfState!) {
        if (prices.stateId == "AC") goldPriceFor16k = prices.goldPrice ?? 1;
      }
    }
  }

  Future<void> getMarketingUsers() async {
    _marketingUsers = await _ggLuckDataApply.getMarketingUsers();
    notifyListeners();
  }

  Future<void> getTransferVouchersDetail(String transferVno) async {
    _transferVouchersDetail =
        await _ggLuckDataApply.getTransferVoucherDetail(transferVno);
    notifyListeners();
  }

  void changeGramToGoldWeight() {
    List<num> goldWeightList = UnitConverter.changeGramToGoldWeight(
        _gramTextController.text.textToNum());

    _kTextController.text = goldWeightList[0].toString();
    _pTextController.text = goldWeightList[1].toString();
    _yTextController.text = goldWeightList[2].floorAsFixedTwo().toString();
    notifyListeners();
  }

  void changeGoldWeightToGram() {
    _gramTextController.text = (UnitConverter.changeGoldWeightToGram(
            _kTextController.text.textToNum(),
            _pTextController.text.textToNum(),
            yTextController.text.textToNum()))
        .floorAsFixedTwo()
        .toString();
    notifyListeners();
  }

  void saveSelectedIssues(IssueStockVM issue) {
    List<num> gold16KPY = UnitConverter.changeGoldState(
        _kTextController.text.textToNum(),
        _pTextController.text.textToNum(),
        _yTextController.text.textToNum(),
        issue.stateId ?? '');
    num gold16Gram = UnitConverter.changeGoldWeightToGram(
        gold16KPY[0], gold16KPY[1], gold16KPY[2]);
    List<num> totalKPY = UnitConverter.changeGramToGoldWeight(gold16Gram);

    IssueStockVM selectedIssue = IssueStockVM(
      gglCode: issue.gglCode ?? '',
      fullName: issue.fullName,
      itemName: issue.itemName,
      stateId: issue.stateId,
      stateName: issue.stateName,
      typeCode: issue.typeCode,
      image: issue.image,
      typeName: issue.typeName,
      userId: issue.userId,
      userName: issue.userName,
      itemGemList: issue.itemGemList,
      kyat: _kTextController.text.textToNum(),
      pae: _pTextController.text.textToNum(),
      yawe: _yTextController.text.textToNum(),
      gram: _gramTextController.text.textToNum(),
      qty: _qTextController.text.textToNum(),
      kyat16: totalKPY[0],
      pae16: totalKPY[1],
      yawe16: totalKPY[2],
      gram16: gold16Gram,
      itemWasteList: [],
    );
    _ggLuckDataApply.saveSelectedIssueItem(selectedIssue);
  }

  Future<void> deleteSelectedVouchers() async {
    _ggLuckDataApply.deleteSelectedCustomer();
    await _ggLuckDataApply.deleteSelectedIssues();
  }

  TotalValueVM changeIssuesToTotalValue(List<IssueStockVM> issues,
      [isCreate = true]) {
    num tQty = 0;
    num tGram = 0;
    num total16Gram = 0;
    for (int i = 0; i < issues.length; i++) {
      tQty += issues[i].qty ?? 0;
      tGram += issues[i].gram ?? 0;
      total16Gram += issues[i].gram16 ?? 0;
    }
    List<num> total16KPY = UnitConverter.changeGramToGoldWeight(total16Gram);
    List<num> totalKPY = UnitConverter.changeGramToGoldWeight(tGram);
    final temp = TotalValueVM(
      tQty: tQty,
      tGram: tGram,
      tKyat: totalKPY[0],
      tPae: totalKPY[1],
      tYawe: totalKPY[2],
      tKyat16: total16KPY[0],
      tPae16: total16KPY[1],
      tGram16: total16Gram,
      tYawe16: total16KPY[2],
      tAdjustableGram: total16Gram,
      tAdjustableKyat: total16KPY[0],
      tAdjustablePae: total16KPY[1],
      tAdjustableYawe: total16KPY[2],
    );
    if (isCreate) {
      _totalValueVM = temp;
    }
    return temp;
  }

  List<IssueStockVM> changeDetailToIssues(
      List<TransferVoucherDetailVM> transferVouchersDetail) {
    List<IssueStockVM>? issueStocks = transferVouchersDetail
        .map((e) => IssueStockVM(
            gglCode: e.gglCode,
            qty: e.qty,
            gram: e.gram,
            kyat: e.kyat,
            pae: e.pae,
            yawe: e.yawe,
            itemName: e.itemName,
            stateName: e.stateName,
            itemGemList: e.itemGemList,
            image: e.image))
        .toList();
    return issueStocks;
  }

  TotalValueVM changeDetailToTotalVal(List<TransferVoucherDetailVM> voDetail) {
    num totalGram = 0;
    num totalQty = 0;

    for (int i = 0; i < voDetail.length; i++) {
      totalQty += voDetail[i].qty ?? 0;
      totalGram += UnitConverter.changeGoldWeightToGram(
          voDetail[i].kyat ?? 0, voDetail[i].pae ?? 0, voDetail[i].yawe ?? 0);
    }
    List<num> totalKPY = UnitConverter.changeGramToGoldWeight(totalGram);
    TotalValueVM totalVal = TotalValueVM(
      tQty: totalQty,
      tGram: totalGram,
      tKyat: totalKPY[0],
      tPae: totalKPY[1],
      tYawe: totalKPY[2],
    );
    return totalVal;
  }

  Future<void> createTransferVoucher(TotalValueVM totalValue) async {
    final String transferVno = DateTime.now().millisecondsSinceEpoch.toString();
    AccessTokenUser? accessUser =
        AccessTokenDaoImpl().getTokenFromDatabase()!.user;
    TransferVoucherVM transferVoucherVM = TransferVoucherVM(
        transferVno: transferVno,
        transferUserId: accessUser!.id,
        transferTo:
            _transferType == TransferType.wareHouse ? "Warehouse" : "Marketing",
        totalQty: totalValue.tQty,
        transferUserName: accessUser.fullName,
        recepentUserId:
            _transferType == TransferType.wareHouse ? null : _recepentUserId,
        totalGram: totalValue.tAdjustableGram!.floorAsFixedTwo(),
        totalKyat: totalValue.tKyat!.floorAsFixedTwo(),
        totalPae: totalValue.tPae!.floorAsFixedTwo(),
        totalYawe: totalValue.tYawe!.floorAsFixedTwo(),
        kyat16: totalValue.tAdjustableKyat!.floorAsFixedTwo(),
        pae16: totalValue.tAdjustablePae!.floorAsFixedTwo(),
        yawe16: totalValue.tAdjustableYawe!.floorAsFixedTwo(),
        transferVoucherDetail: _selectedIssuesList
            ?.map((e) => TransferVoucherDetailVM(
                transferVno: transferVno,
                gglCode: e.gglCode,
                qty: e.qty,
                gram: e.gram!.floorAsFixedTwo(),
                kyat: e.kyat!.floorAsFixedTwo(),
                pae: e.pae!.floorAsFixedTwo(),
                yawe: e.yawe!.floorAsFixedTwo()))
            .toList());
    _ggLuckDataApply.createTransferVoucher(transferVoucherVM);
  }

  void adjustGoldWeightValue([bool isIncrease = true]) {
    _totalValueVM = UnitConverter.adjustGoldWeight(
        _totalValueVM, value, isIncrease, goldPriceFor16k);
    notifyListeners();
  }

  clearText() {
    _qTextController.clear();
    _gramTextController.clear();
    _kTextController.clear();
    _pTextController.clear();
    _yTextController.clear();
    notifyListeners();
  }

  bool checkInsufficientQuantityOrNot(num qty) {
    if (_qTextController.text.textToNum() > qty) {
      _qTextController.clear();
      return true;
    }
    return false;
  }

  bool checkInsufficientGramOrNot(num gram) {
    if (_gramTextController.text.textToNum() > gram) {
      _gramTextController.clear();
      return false;
    }
    return true;
  }

  @override
  void notifyListeners() {
    if (!_isDispose) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _isDispose = true;
    _qTextController.dispose();
    _gramTextController.dispose();
    _searchController.dispose();
    _kTextController.dispose();
    _pTextController.dispose();
    _yTextController.dispose();
    _voucherOrCsController.dispose();
    _receiveRemarkController.dispose();
    _transferScrollController.dispose();
    _transferReceivedController.dispose();
    _receivedPendingDeleteController.dispose();
    super.dispose();
  }
}
