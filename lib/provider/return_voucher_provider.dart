import 'package:flutter/material.dart';
import 'package:desktop_test/constant/dimen.dart';
import 'package:desktop_test/data/data_apply/data_apply/gg_luck_data_apply.dart';
import 'package:desktop_test/data/data_apply/data_apply/gg_luck_data_apply_imp.dart';
import 'package:desktop_test/data/vms/access_token/access_token.dart';
import 'package:desktop_test/data/vms/gold_price/gold_price.dart';
import 'package:desktop_test/data/vms/issue_stock/main_stock.dart';
import 'package:desktop_test/data/vms/return_voucher/grouped_return_voucher.dart';
import 'package:desktop_test/data/vms/return_voucher/return_voucher.dart';
import 'package:desktop_test/data/vms/return_voucher/return_voucher_detail_vm.dart';
import 'package:desktop_test/data/vms/sale_voucher/total_value_vm.dart';
import 'package:desktop_test/data/vms/user/user.dart';
import 'package:desktop_test/persistent/daos/user_dao/access_token_dao_impl.dart';
import 'package:desktop_test/utils/extension.dart';
import 'package:desktop_test/utils/unit_converter.dart';
import 'package:intl/intl.dart';

import '../data/vms/access_token/user/access_token_user.dart';

class ReturnVoucherProvider extends ChangeNotifier {
  bool _isDispose = true;
  num value = 0;
  num goldPriceFor16k = 0;
  List<GroupedReturnVoucher>? _reportReturnVouchers;
  List<MainStock>? _mainStocks;
  List<MainStock>? _selectedMainStocks;
  List<MainStock> _filteredMainStocks = [];
  List<GoldPrice>? _goldPricesOfState;
  List<ReturnVoucherVM>? _todayReturnVoucher;
  List<ReturnVoucherVM> _filteredReturnVouchers = [];
  List<ReturnVoucherDetailVM>? _returnVouchersDetail;
  late TotalValueVM _totalValueVM;
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();
  bool _isHaveMainStock = false;
  bool _isHaveCustomer = false;
  UserVM? _customerVM;
  bool _isLoading = true;
  final TextEditingController _gramTextController = TextEditingController();
  final TextEditingController _quantityTextController = TextEditingController();
  final TextEditingController _kTextController = TextEditingController();
  final TextEditingController _yTextController = TextEditingController();
  final TextEditingController _pTextController = TextEditingController();
  final TextEditingController _wKTextController = TextEditingController();
  final TextEditingController _wPTextController = TextEditingController();
  final TextEditingController _wYTextController = TextEditingController();
  final TextEditingController _filterTextController = TextEditingController();
  final TextEditingController _searchTextController = TextEditingController();
  final ScrollController _returnScrollController = ScrollController();
  final ScrollController _availableReturnScrollController = ScrollController();
  final TextEditingController _remarkReturnTextController =
      TextEditingController();
  final TextEditingController _remarkForCreatingReturnController =
      TextEditingController();
  final TextEditingController _goldPriceController = TextEditingController();
  final TextEditingController _totalAmountController = TextEditingController();
  bool _isFilter = false;

  bool get isHaveSelectedMainStocks => _isHaveMainStock;

  bool get isHaveCustomer => _isHaveCustomer;

  UserVM? get customer => _customerVM;

  bool get isLoading => _isLoading;

  TextEditingController get kTextController => _kTextController;

  TextEditingController get remarkForCreatingReturnController =>
      _remarkForCreatingReturnController;

  List<MainStock>? get selectedMainStocks => _selectedMainStocks;

  List<MainStock> get filteredMainStocks => _filteredMainStocks;

  List<ReturnVoucherDetailVM>? get returnVouchersDetail =>
      _returnVouchersDetail;

  TextEditingController get goldPriceController => _goldPriceController;

  TextEditingController get totalAmountController => _totalAmountController;

  ScrollController get availableReturnScrollController =>
      _availableReturnScrollController;

  TextEditingController get gramTextController => _gramTextController;

  ScrollController get returnScrollController => _returnScrollController;

  TotalValueVM get totalValueVM => _totalValueVM;

  TextEditingController get yTextController => _yTextController;

  TextEditingController get remarkReturnTextController =>
      _remarkReturnTextController;

  TextEditingController get pTextController => _pTextController;

  TextEditingController get wKTextController => _wKTextController;

  TextEditingController get wPTextController => _wPTextController;

  TextEditingController get wYTextController => _wYTextController;

  TextEditingController get quantityTextController => _quantityTextController;

  TextEditingController get searchTextController => _searchTextController;

  TextEditingController get filterTextController => _filterTextController;

  List<GroupedReturnVoucher>? get reportReturnVouchers => _reportReturnVouchers;

  List<MainStock>? get mainStocks => _mainStocks;

  List<ReturnVoucherVM>? get todayReturnVoucher => _todayReturnVoucher;

  List<ReturnVoucherVM> get filteredReturnVoucher => _filteredReturnVouchers;
  bool get isFilter => _isFilter;

  // instance variable
  final GgLuckDataApply _ggLuckDataApply = GgLuckDataApplyImpl();

  ReturnVoucherProvider() {
    value =
        AccessTokenDaoImpl().getTokenFromDatabase()!.adjustValues!.first.value!;
    _ggLuckDataApply.getGoldPrice().then((value) => _goldPricesOfState = value);
  }

  void showSelectedGoldPrice(String stateId) {
    _goldPriceController.text = getGoldPricesOfState(stateId).toString();
  }

  void deleteSelectedMainStock(String gglCode) {
    _ggLuckDataApply.deleteSelectedMainStock(gglCode);
    getSelectedMainStocks();
  }

  void calculateAndShowTotalAmount() {
    if (_quantityTextController.text.isNotEmpty &&
        _gramTextController.text.isNotEmpty &&
        _kTextController.text.isNotEmpty &&
        _pTextController.text.isNotEmpty &&
        _yTextController.text.isNotEmpty &&
        _goldPriceController.text.isNotEmpty) {
      num gram = UnitConverter.changeGoldWeightToGram(
          _kTextController.text.textToNum(),
          _pTextController.text.textToNum(),
          _yTextController.text.textToNum());
      num wGram = UnitConverter.changeGoldWeightToGram(
          _wKTextController.text.textToNum(),
          _wPTextController.text.textToNum(),
          _wYTextController.text.textToNum());
      List<num> totalKPY = UnitConverter.changeGramToGoldWeight(gram + wGram);
      _totalAmountController.text = UnitConverter.calculateTheTotalAmtForKPY(
              totalKPY[0],
              totalKPY[1],
              totalKPY[2],
              _goldPriceController.text.textToNum())
          .toStringAsFixed(0);
    }
  }

  Future<void> getReturnVouchers(
      {DateTime? startDate,
      DateTime? endDate,
      String? category,
      bool? isReport,
      bool isTabChange = false,
      int index = 0}) async {
    _isLoading = true;
    _isFilter = false;
    _startDate = startDate ?? DateTime.now();
    _endDate = endDate ?? DateTime.now();
    if (isReport == null) {
      final returnVouchers = await _ggLuckDataApply.getReturnVouchers(
          _startDate.formatForFilter(),
          _endDate.formatForFilter(),
          "",
          "",
          'All');
      if (returnVouchers != null && returnVouchers.isNotEmpty)
        _todayReturnVoucher = returnVouchers.first.returnVouchers;
    } else {
      _reportReturnVouchers = await _ggLuckDataApply.getReturnVouchers(
          _startDate.formatForFilter(),
          _endDate.formatForFilter(),
          _filterTextController.text,
          category ?? '',
          index == 0
              ? "Pending"
              : index == 1
                  ? "Delete"
                  : "Receive");
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> deleteReturnVoucher(String voucherNo) async {
    _ggLuckDataApply.deleteReturnVoucher(
        voucherNo, _remarkReturnTextController.text);
  }

  Future<void> getReturnVouchersDetail(String returnVno) async {
    _returnVouchersDetail = null;
    _returnVouchersDetail =
        await _ggLuckDataApply.getReturnVouchersDetail(returnVno);
    notifyListeners();
  }

  Future<void> getMainStock() async {
    _isFilter = false;
    _mainStocks = await _ggLuckDataApply.getMainStock();
    notifyListeners();
  }

  void filterMainStocks() {
    if (_mainStocks == null) return;
    _isFilter = true;
    _filteredMainStocks = [];
    if (_searchTextController.text.isEmpty) {
      getMainStock();
    } else {
      for (var mainStock in mainStocks!) {
        if (mainStock.gglCode!
                .toLowerCase()
                .contains(_searchTextController.text.trim().toLowerCase()) ||
            mainStock.itemName!
                .toLowerCase()
                .contains(_searchTextController.text.trim().toLowerCase())) {
          _filteredMainStocks.add(mainStock);
        }
      }
    }
    notifyListeners();
    _availableReturnScrollController.jumpTo(0);
  }

  num getGoldPricesOfState(String stateId) {
    if (_goldPricesOfState != null) {
      for (var prices in _goldPricesOfState!) {
        if (prices.stateId == stateId) return prices.goldPrice ?? 0;
      }
    }
    return 0;
  }

  void getSelectedMainStocks() {
    _ggLuckDataApply.getMainStockFromDatabaseStream().listen((mainStocks) {
      _isHaveMainStock = false;
      _selectedMainStocks = mainStocks;
      if (mainStocks != null && mainStocks.isNotEmpty) {
        _isHaveMainStock = true;
      }
      notifyListeners();
    });
    goldPriceFor16k = getGoldPricesOfState("A0");
  }

  Future<void> deleteSelectedMainStocks() async {
    _ggLuckDataApply.deleteSelectedCustomer();
    await _ggLuckDataApply.deleteSelectedMainStocks();
  }

  Future<void> saveSelectMainStocks(String gglCode, String itemName,
      String stateId, String typeName, String stateName, String image) async {
    num gram16 = 0;
    num wasteGram = 0;
    wasteGram = UnitConverter.changeGoldWeightToGram(
        _wKTextController.text.textToNum(),
        _wPTextController.text.textToNum(),
        _wYTextController.text.textToNum());
    num tNetGram = _gramTextController.text.textToNum() + wasteGram;
    List<num> listNetKPY = UnitConverter.changeGramToGoldWeight(tNetGram);
    // num goldPrice =  getGoldPricesOfState(stateId);

    List<num> list16KPY = UnitConverter.changeGoldState(
        _kTextController.text.textToNum(),
        _pTextController.text.textToNum(),
        _yTextController.text.textToNum(),
        stateId);
    List<num> list16WKPY = UnitConverter.changeGoldState(
        _wKTextController.text.textToNum(),
        _wPTextController.text.textToNum(),
        _wYTextController.text.textToNum(),
        stateId);
    gram16 = (UnitConverter.changeGoldWeightToGram(
            list16KPY[0], list16KPY[1], list16KPY[2])) +
        (UnitConverter.changeGoldWeightToGram(
            list16WKPY[0], list16WKPY[1], list16WKPY[2]));
    List<num> goldWeight16KPY = UnitConverter.changeGramToGoldWeight(gram16);
    num totalAmt16State = UnitConverter.calculateTheTotalAmtForKPY(
        goldWeight16KPY[0],
        goldWeight16KPY[1],
        goldWeight16KPY[2],
        goldPriceFor16k);
    if (gglCode.startsWith('B-')) {
      gram16 = gram16 * kDamageValue;
      goldWeight16KPY = UnitConverter.changeGramToGoldWeight(gram16);
      totalAmt16State = UnitConverter.calculateTheTotalAmtForKPY(
          goldWeight16KPY[0],
          goldWeight16KPY[1],
          goldWeight16KPY[2],
          goldPriceFor16k);
      UnitConverter.calculateTheTotalAmtForKPY(goldWeight16KPY[0],
          goldWeight16KPY[1], goldWeight16KPY[2], goldPriceFor16k);
    }

    MainStock mainStock = MainStock(
        gglCode: gglCode,
        itemName: itemName,
        stateName: stateName,
        typeName: typeName,
        stateId: stateId,
        image: image,
        quantity: _quantityTextController.text.textToNum(),
        gram: _gramTextController.text.textToNum(),
        kyat: _kTextController.text.textToNum(),
        pae: _pTextController.text.textToNum(),
        yawe: _yTextController.text.textToNum(),
        wasteKyat: _wKTextController.text.textToNum(),
        wastePae: _wPTextController.text.textToNum(),
        wasteYawe: _wYTextController.text.textToNum(),
        wasteGram: wasteGram,
        kyat16: goldWeight16KPY[0],
        pae16: goldWeight16KPY[1],
        yawe16: goldWeight16KPY[2].toStringAsFixed(2).textToNum(),
        wKyat16: list16WKPY[0],
        wPae16: list16WKPY[1],
        wYawe16: list16WKPY[2].toStringAsFixed(2).textToNum(),
        gram16: gram16.toStringAsFixed(2).textToNum(),
        totalAmt16State: totalAmt16State,
        totalAmt: _totalAmountController.text.textToNum().floorAsFixedTwo(),
        tNetGram: tNetGram,
        goldPrice: _goldPriceController.text.textToNum(),
        tNetKyat: listNetKPY[0],
        tNetPae: listNetKPY[1],
        tNetYawe: listNetKPY[2]);
    await _ggLuckDataApply.saveMainStock(mainStock);
    clearText();
  }

  TotalValueVM changeMainStocksToTotalValue(List<MainStock> mainStocks,
      [bool isCreate = true]) {
    num tQty = 0;
    num tGram = 0;
    num tNetGram = 0;
    num tWasteGram = 0;
    num totalAmt = 0;
    num tGram16 = 0;
    for (int i = 0; i < mainStocks.length; i++) {
      tQty += mainStocks[i].quantity ?? 0;
      tGram += mainStocks[i].gram ?? 0;
      tGram16 += mainStocks[i].gram16 ?? 0;
      tWasteGram += mainStocks[i].wasteGram ?? 0;
      totalAmt += mainStocks[i].totalAmt ?? 0;

      ///TODO totalAmt16State or totalAmt make sure
    }
    tNetGram = tGram + tWasteGram;
    List<num> totalKPY = UnitConverter.changeGramToGoldWeight(tGram);
    List<num> totalWasteKPY = UnitConverter.changeGramToGoldWeight(tWasteGram);
    List<num> totalNetKPY = UnitConverter.changeGramToGoldWeight(tNetGram);
    List<num> total16KPY = UnitConverter.changeGramToGoldWeight(tGram16);
    final temp = TotalValueVM(
        tQty: tQty,
        tGram: tGram,
        tKyat: totalKPY[0],
        tPae: totalKPY[1],
        tYawe: totalKPY[2],
        tWKyat: totalWasteKPY[0],
        tWPae: totalWasteKPY[1],
        tWYawe: totalWasteKPY[2],
        tWasteGram: tWasteGram,
        tNetGram: tNetGram,
        tNetKyat: totalNetKPY[0],
        tNetPae: totalNetKPY[1],
        tNetYawe: totalNetKPY[2],
        tKyat16: total16KPY[0],
        tPae16: total16KPY[1],
        tYawe16: total16KPY[2],
        tGram16: tGram16,
        tAdjustableGram: tGram16,
        tAdjustableKyat: total16KPY[0],
        tAdjustablePae: total16KPY[1],
        tAdjustableYawe: total16KPY[2],
        totalAmt: totalAmt);
    if (isCreate) {
      _totalValueVM = temp;
    }
    return temp;
  }

  List<MainStock> changeDetailToMainStocks(
      List<ReturnVoucherDetailVM> returnVouchersDetail) {
    List<MainStock> mainStocks = returnVouchersDetail
        .map((e) => MainStock(
            gglCode: e.gglCode,
            stateName: e.stateName,
            typeName: e.typeName,
            itemName: e.itemName,
            image: e.image,
            kyat16: e.kyat16,
            pae16: e.pae16,
            yawe16: e.yawe16,
            wasteKyat: e.wasteKyat,
            wastePae: e.wastePae,
            wasteYawe: e.wasteYawe,
            kyat: e.kyat,
            pae: e.pae,
            yawe: e.yawe,
            quantity: e.qty,
            gram: UnitConverter.changeGoldWeightToGram(
                e.kyat ?? 0, e.pae ?? 0, e.yawe ?? 0),
            gram16: e.gram,
            totalAmt16State: e.totalAmt,
            wasteGram: UnitConverter.changeGoldWeightToGram(
                e.wasteKyat ?? 0, e.wastePae ?? 0, e.wasteYawe ?? 0)))
        .toList();
    return mainStocks;
  }

  TotalValueVM changeDetailToTotalValue(List<ReturnVoucherDetailVM> voDetail) {
    num totalGram = 0;
    num totalWasteGram = 0;
    num totalNetGram = 0;
    num total16KPYGram = 0;
    num totalQty = 0;
    num totalAmt = 0;

    for (int i = 0; i < voDetail.length; i++) {
      totalQty += voDetail[i].qty ?? 0;
      totalAmt += voDetail[i].totalAmt ?? 0;
      totalGram += UnitConverter.changeGoldWeightToGram(
          voDetail[i].kyat ?? 0, voDetail[i].pae ?? 0, voDetail[i].yawe ?? 0);
      totalWasteGram += UnitConverter.changeGoldWeightToGram(
          voDetail[i].wasteKyat ?? 0,
          voDetail[i].wastePae ?? 0,
          voDetail[i].wasteYawe ?? 0);
      totalNetGram += UnitConverter.changeGoldWeightToGram(
          voDetail[i].totalKyat ?? 0,
          voDetail[i].totalPae ?? 0,
          voDetail[i].totalYawe ?? 0);
      total16KPYGram += UnitConverter.changeGoldWeightToGram(
          voDetail[i].kyat16 ?? 0,
          voDetail[i].pae16 ?? 0,
          voDetail[i].yawe16 ?? 0);
    }
    List<num> totalKPY = UnitConverter.changeGramToGoldWeight(totalGram);
    List<num> wasteKPY = UnitConverter.changeGramToGoldWeight(totalWasteGram);
    List<num> netKPY = UnitConverter.changeGramToGoldWeight(totalNetGram);
    List<num> total16KPY = UnitConverter.changeGramToGoldWeight(total16KPYGram);
    TotalValueVM totalVal = TotalValueVM(
      tQty: totalQty,
      totalAmt: totalAmt,
      tGram: totalGram,
      tKyat: totalKPY[0],
      tPae: totalKPY[1],
      tYawe: totalKPY[2],
      tWasteGram: totalWasteGram,
      tWKyat: wasteKPY[0],
      tWPae: wasteKPY[1],
      tWYawe: wasteKPY[2],
      tNetGram: totalNetGram,
      tNetKyat: netKPY[0],
      tNetPae: netKPY[1],
      tNetYawe: netKPY[2],
      tGram16: total16KPYGram,
      tKyat16: total16KPY[0],
      tPae16: total16KPY[1],
      tYawe16: total16KPY[2],
    );
    return totalVal;
  }

  Future<void> createReturnVoucher(TotalValueVM totalValueVM) async {
    List<MainStock> damageItems = _selectedMainStocks!
        .where((element) => element.gglCode!.startsWith('B-'))
        .toList();
    String remark = _remarkForCreatingReturnController.text;
    if (damageItems.isNotEmpty) {
      for (var dItem in damageItems) {
        remark +=
            '${dItem.gglCode} x $kDamageValue ${dItem == damageItems.last ? "" : ", "}';
      }
    }
    final returnVoucherNo = DateTime.now().millisecondsSinceEpoch.toString();
    AccessToken? accessToken = AccessTokenDaoImpl().getTokenFromDatabase();
    AccessTokenUser? user = accessToken?.user;
    ReturnVoucherVM returnVoucherVM = ReturnVoucherVM(
        returnVno: returnVoucherNo,
        date: DateFormat("yyyy-MM-dd").format(DateTime.now()),
        customerId: _customerVM?.userId,
        lat: 1,
        long: 1,
        createBy: user?.id,
        kyat16: totalValueVM.tAdjustableKyat!.floorAsFixedTwo(),
        pae16: totalValueVM.tAdjustablePae!.floorAsFixedTwo(),
        yawe16: totalValueVM.tAdjustableYawe!.floorAsFixedTwo(),
        totalGram: totalValueVM.tAdjustableGram!.floorAsFixedTwo(),
        totalWasteKyat: totalValueVM.tWKyat!.floorAsFixedTwo(),
        totalWastePae: totalValueVM.tWPae!.floorAsFixedTwo(),
        totalWasteYawe: totalValueVM.tWYawe!.floorAsFixedTwo(),
        totalKyat: totalValueVM.tKyat!.floorAsFixedTwo(),
        totalPae: totalValueVM.tPae!.floorAsFixedTwo(),
        totalYawe: totalValueVM.tYawe!.floorAsFixedTwo(),
        remark: remark,
        totalAmt: totalValueVM.totalAmt!.floorAsFixedTwo(),

        ///TODO totalAmt16State or totalAmt make sure
        totalQty: totalValueVM.tQty,
        voucherDetailModel: _selectedMainStocks
            ?.map((e) => ReturnVoucherDetailVM(
                  returnVno: returnVoucherNo,
                  gglCode: e.gglCode,
                  itemName: e.itemName,
                  stateName: e.stateName,
                  kyat16: e.kyat16!.floorAsFixedTwo(),
                  pae16: e.pae16!.floorAsFixedTwo(),
                  yawe16: e.yawe16!.floorAsFixedTwo(),
                  kyat: e.kyat!.floorAsFixedTwo(),
                  pae: e.pae!.floorAsFixedTwo(),
                  yawe: e.yawe!.floorAsFixedTwo(),
                  typeName: e.typeName,
                  goldPrice: e.goldPrice,
                  gram: e.gram,
                  wasteKyat: e.wasteKyat!.floorAsFixedTwo(),
                  wastePae: e.wastePae!.floorAsFixedTwo(),
                  wasteYawe: e.wasteYawe!.floorAsFixedTwo(),
                  totalAmt: e.totalAmt!.floorAsFixedTwo(),
                  qty: e.quantity,
                  totalKyat: e.tNetKyat!.floorAsFixedTwo(),
                  totalPae: e.tNetPae!.floorAsFixedTwo(),
                  totalYawe: e.tNetYawe!.floorAsFixedTwo(),
                ))
            .toList());
    await _ggLuckDataApply.createReturnVoucher(returnVoucherVM);
  }

  void getSelectedCustomer() {
    _ggLuckDataApply.getCustomerFromStreamDataBase().listen((customerVM) {
      _isHaveCustomer = false;
      _customerVM = customerVM;
      _isHaveCustomer = customerVM != null;
      notifyListeners();
    });
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

  void clearText() {
    _quantityTextController.clear();
    _gramTextController.clear();
    _kTextController.clear();
    _pTextController.clear();
    _yTextController.clear();
    _wKTextController.clear();
    _wPTextController.clear();
    _wYTextController.clear();
    _totalAmountController.clear();
    _goldPriceController.clear();
    notifyListeners();
  }

  void filterReturnVoucherLocal(TextEditingController controller) {
    _isLoading = true;
    _isFilter = true;
    _filteredReturnVouchers = [];
    if (controller.text.isEmpty) {
      getReturnVouchers();
    } else {
      if (_todayReturnVoucher != null) {
        for (var voucher in _todayReturnVoucher!) {
          if (voucher.returnVno!
              .toLowerCase()
              .contains(controller.text.trim().toLowerCase().toString()))
            _filteredReturnVouchers.add(voucher);
        }
      }
    }
    _isLoading = false;
    notifyListeners();
    _returnScrollController.jumpTo(0);
  }

  void adjustGoldWeightValue([bool isIncrease = true]) {
    _totalValueVM = UnitConverter.adjustGoldWeight(
        _totalValueVM, value, isIncrease, goldPriceFor16k);
    notifyListeners();
  }

  @override
  void notifyListeners() {
    if (_isDispose) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _quantityTextController.dispose();
    _gramTextController.dispose();
    _kTextController.dispose();
    _pTextController.dispose();
    _yTextController.dispose();
    _wKTextController.dispose();
    _wPTextController.dispose();
    _wYTextController.dispose();
    _returnScrollController.dispose();
    _remarkReturnTextController.dispose();
    _availableReturnScrollController.dispose();
    _searchTextController.dispose();
    _remarkForCreatingReturnController.dispose();
    _totalAmountController.dispose();
    _goldPriceController.dispose();
    _isDispose = false;
    super.dispose();
  }
}
