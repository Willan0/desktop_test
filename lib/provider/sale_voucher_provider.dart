import 'package:flutter/material.dart';
import 'package:desktop_test/data/vms/gold_price/gold_price.dart';

import 'package:desktop_test/data/vms/issue_stock/issue_stock_vm.dart';
import 'package:desktop_test/data/vms/issue_stock/item_waste_vm.dart';
import 'package:desktop_test/data/vms/sale_voucher/grouped_sale_voucher.dart';
import 'package:desktop_test/data/vms/sale_voucher/total_value_vm.dart';
import 'package:desktop_test/data/vms/user/user.dart';
import 'package:desktop_test/utils/extension.dart';
import 'package:desktop_test/utils/unit_converter.dart';

import '../data/data_apply/data_apply/gg_luck_data_apply.dart';
import '../data/data_apply/data_apply/gg_luck_data_apply_imp.dart';
import '../data/vms/sale_voucher/sale_voucher.dart';
import '../data/vms/sale_voucher/sale_voucher_detail.dart';
import '../persistent/daos/user_dao/access_token_dao_impl.dart';

class SaleVoucherProvider extends ChangeNotifier {
  bool _isDispose = true;
  num value = 0;
  num goldPriceFor16k = 0;
  num goldPrice = 0;
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController gramController = TextEditingController();
  final TextEditingController kController = TextEditingController();
  final TextEditingController pController = TextEditingController();
  final TextEditingController yController = TextEditingController();
  final TextEditingController wKController = TextEditingController();
  final TextEditingController wPController = TextEditingController();
  final TextEditingController wYController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _saleScrollController = ScrollController();
  final ScrollController _availableSaleController = ScrollController();
  final TextEditingController _chargesController = TextEditingController();
  final TextEditingController _goldTotalAmountController =
      TextEditingController();
  final TextEditingController _totalAmountController = TextEditingController();
  final TextEditingController _remarkSaleTextController =
      TextEditingController();
  final TextEditingController _reportSearchTextEditingController =
      TextEditingController();
  final TextEditingController _remarkForCreatingSaleVoucher =
      TextEditingController();
  late TotalValueVM _totalValueVM;
  bool _isScroll = true;
  List<SaleVoucherVM>? _todaySaleVouchers;
  List<SaleVoucherVM> _filterTodaySaleVouchers = [];
  List<IssueStockVM>? _issuesList;
  List<IssueStockVM>? _selectedIssuesList;
  List<IssueStockVM> _filteredIssueStocks = [];
  List<GoldPrice>? _goldPricesOfState;
  List<SaleVoucherDetailVM>? _saleVouchersDetail;
  UserVM? _customerVM;
  bool _isHaveSelectedItem = false;
  bool _isHaveCustomer = false;
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();
  List<GroupedSaleVoucher>? _reportSaleVouchers;
  bool _isFilter = false;

  ScrollController get availableSaleController => _availableSaleController;

  List<GroupedSaleVoucher>? get reportSaleVouchers =>
      _reportSaleVouchers; // getter
  List<IssueStockVM>? get issues => _issuesList;

  List<SaleVoucherVM> get filteredSaleVouchers => _filterTodaySaleVouchers;

  TextEditingController get totalAmountController => _totalAmountController;

  List<SaleVoucherDetailVM>? get saleVouchersDetail => _saleVouchersDetail;

  TextEditingController get goldTotalAmountController =>
      _goldTotalAmountController;

  TextEditingController get chargesController => _chargesController;

  TextEditingController get remarkSaleTextController =>
      _remarkSaleTextController;
  TextEditingController get searchController => _searchController;

  TextEditingController get reportSearchTextEditingController =>
      _reportSearchTextEditingController;

  ScrollController get saleScrollController => _saleScrollController;

  List<SaleVoucherVM>? get todaySaleVoucher => _todaySaleVouchers;

  List<IssueStockVM>? get selectedIssues => _selectedIssuesList;

  List<IssueStockVM> get filteredIssueStocks => _filteredIssueStocks;

  UserVM? get getCustomer => _customerVM;

  TextEditingController get remarkForCreatingSaleVoucher =>
      _remarkForCreatingSaleVoucher;

  TotalValueVM get totalValueVM => _totalValueVM;

  bool get isHaveSelectedIssue => _isHaveSelectedItem;

  bool get isHaveCustomer => _isHaveCustomer;

  bool get getIsScroll => _isScroll;

  bool get isFilter => _isFilter;

  ///instance variable
  final GgLuckDataApply _ggLuckDataApply = GgLuckDataApplyImpl();

  SaleVoucherProvider() {
    value =
        AccessTokenDaoImpl().getTokenFromDatabase()!.adjustValues!.first.value!;
    _ggLuckDataApply.getGoldPrice().then((value) => _goldPricesOfState = value);
  }

  void calculateAndShowTotalAmount() {
    if (quantityController.text.isNotEmpty &&
        gramController.text.isNotEmpty &&
        kController.text.isNotEmpty &&
        pController.text.isNotEmpty &&
        yController.text.isNotEmpty &&
        goldPrice != 0) {
      num gram = UnitConverter.changeGoldWeightToGram(
          kController.text.textToNum(),
          pController.text.textToNum(),
          yController.text.textToNum());
      num wGram = UnitConverter.changeGoldWeightToGram(
          wKController.text.textToNum(),
          wPController.text.textToNum(),
          wYController.text.textToNum());
      List<num> totalKPY = UnitConverter.changeGramToGoldWeight(gram + wGram);
      _goldTotalAmountController.text =
          UnitConverter.calculateTheTotalAmtForKPY(
                  totalKPY[0], totalKPY[1], totalKPY[2], goldPrice)
              .toStringAsFixed(0);
      _totalAmountController.text =
          (_goldTotalAmountController.text.textToNum() +
                  _chargesController.text.textToNum())
              .toStringAsFixed(0);
    }
  }

  void deleteSelectedItem(String gglCode) {
    _ggLuckDataApply.deleteSelectIssue(gglCode);
    getSelectedIssues();
  }

  Future<void> getIssues() async {
    _isFilter = false;
    _issuesList = await _ggLuckDataApply.getIssues();
    notifyListeners();
  }

  void showSelectedGoldPrice(String stateId) {
    goldPrice = getGoldPricesOfState(stateId);
    // _goldPriceController.text = getGoldPricesOfState(stateId).toString();
  }

  void filterIssueStock() {
    if (_issuesList == null) return;
    _isFilter = true;
    _filteredIssueStocks = [];
    if (_searchController.text.isEmpty) {
      getIssues();
    } else {
      for (var issue in _issuesList!) {
        if (issue.gglCode!
                .trim()
                .toLowerCase()
                .contains(_searchController.text.trim().toLowerCase()) ||
            issue.itemName!
                .trim()
                .toLowerCase()
                .contains(_searchController.text.trim().toLowerCase())) {
          _filteredIssueStocks.add(issue);
        }
      }
    }
    notifyListeners();
    _availableSaleController.jumpTo(0);
  }

  Future<void> getSaleVouchers(
      {DateTime? startDate,
      DateTime? endDate,
      String? category,
      bool? isReport,
      int index = 0}) async {
    _isFilter = false;
    _startDate = startDate ?? DateTime.now();
    _endDate = endDate ?? DateTime.now();
    if (isReport == null) {
      final groupedSaleVoucher = await _ggLuckDataApply.getSaleVouchers(
          _startDate.formatForFilter(), _endDate.formatForFilter(), "", "");
      if (groupedSaleVoucher?.isEmpty ?? false) {
        _todaySaleVouchers = [];
        notifyListeners();
        return;
      }
      _todaySaleVouchers = groupedSaleVoucher![0]
          .saleVouchers
          ?.where((element) => element.deleteBy == null)
          .toList();
    } else {
      _reportSaleVouchers = await _ggLuckDataApply.getSaleVouchers(
          _startDate.formatForFilter(),
          _endDate.formatForFilter(),
          _reportSearchTextEditingController.text,
          category ?? '');

      List<GroupedSaleVoucher> activeGroupedSaleVouchers = [];
      List<GroupedSaleVoucher> deletedGroupedSaleVouchers = [];
      if (_reportSaleVouchers != null) {
        for (var groupedVoucher in _reportSaleVouchers!) {
          // Filter active vouchers
          List<SaleVoucherVM>? activeVouchers = groupedVoucher.saleVouchers!
              .where((voucher) => voucher.deleteBy == null)
              .toList();

          // Filter deleted vouchers
          List<SaleVoucherVM> deletedVouchers = groupedVoucher.saleVouchers!
              .where((voucher) => voucher.deleteBy != null)
              .toList();

          // Create new GroupedSaleVoucher objects with filtered lists
          if (activeVouchers.isNotEmpty) {
            activeGroupedSaleVouchers.add(GroupedSaleVoucher(
              activeVouchers.length,
              groupedVoucher.date,
              activeVouchers,
              groupedVoucher.isCollapse,
            ));
          }

          if (deletedVouchers.isNotEmpty) {
            deletedGroupedSaleVouchers.add(GroupedSaleVoucher(
              deletedVouchers.length,
              groupedVoucher.date,
              deletedVouchers,
              groupedVoucher.isCollapse,
            ));
          }
        }
      }
      index == 0
          ? _reportSaleVouchers = activeGroupedSaleVouchers
          : _reportSaleVouchers = deletedGroupedSaleVouchers;
    }
    notifyListeners();
  }

  Future<void> getSelectedIssues() async {
    _ggLuckDataApply.getGoldPrice().then((value) => _goldPricesOfState = value);
    _ggLuckDataApply.getSelectedIssues().listen((selectedIssues) {
      _isHaveSelectedItem = false;
      _selectedIssuesList = selectedIssues;
      if (selectedIssues != null && selectedIssues.isNotEmpty) {
        _isHaveSelectedItem = true;
      }
      notifyListeners();
    });
    goldPriceFor16k = getGoldPricesOfState("A0");
  }

  Future<void> getSaleVouchersDetail(String saleVno) async {
    goldPriceFor16k = getGoldPricesOfState("A0");
    _saleVouchersDetail = null;
    _saleVouchersDetail = await _ggLuckDataApply.getSaleVouchersDetail(saleVno);
    notifyListeners();
  }

  void getSelectedCustomer() {
    _ggLuckDataApply.getCustomerFromStreamDataBase().listen((event) {
      _isHaveCustomer = false;
      _customerVM = event;
      _isHaveCustomer = event != null;
      notifyListeners();
    });
  }

  num getGoldPricesOfState(String stateId) {
    if (_goldPricesOfState?.isNotEmpty ?? false) {
      for (var prices in _goldPricesOfState!) {
        if (prices.stateId == stateId) return prices.goldPrice ?? 1;
      }
    }
    return 0;
  }

  void checkScroll(bool visibility) {
    visibility == false ? _isScroll = true : _isScroll = false;
    notifyListeners();
  }

  void autoFillWasteDependOnQuantity(
      int inputQty, List<ItemWasteVM> itemWastes) {
    if (inputQty == 0) {
      wKController.text = '0';
      wPController.text = '0';
      wYController.text = '0';
      notifyListeners();
    } else {
      if (itemWastes.isEmpty) {
        wKController.text = '0';
        wPController.text = '0';
        wYController.text = '0';
        notifyListeners();
      }
      for (int i = 0; i < itemWastes.length; i++) {
        if (inputQty >= itemWastes[i].minQty! &&
            inputQty <= itemWastes[i].maxQty!) {
          wKController.text = (itemWastes[i].wasteKyat ?? 0).toString();
          wPController.text = (itemWastes[i].wastePae ?? 0).toString();
          wYController.text = (itemWastes[i].wasteYawe ?? 0).toString();
          notifyListeners();
        }
      }
    }
  }

  bool checkInsufficientQuantityOrNot(int inputQty, num qty) {
    if (inputQty > qty) {
      quantityController.clear();
      return false;
    }
    return true;
  }

  bool checkInsufficientGramOrNot(num gram) {
    if (gramController.text.textToNum() > gram) {
      gramController.clear();
      return false;
    }
    return true;
  }

  void changeGramToGoldWeight() {
    List<num> goldWeightList =
        UnitConverter.changeGramToGoldWeight(gramController.text.textToNum());
    kController.text = goldWeightList[0].toString();
    pController.text = goldWeightList[1].toString();
    yController.text = goldWeightList[2].floorAsFixedTwo().toString();
    notifyListeners();
  }

  void addCharges() {
    _totalAmountController.text = (_goldTotalAmountController.text.textToNum() +
            _chargesController.text.textToNum())
        .toStringAsFixed(0);
    notifyListeners();
  }

  void changeGoldWeightToGram() {
    gramController.text = UnitConverter.changeGoldWeightToGram(
            kController.text.textToNum(),
            pController.text.textToNum(),
            yController.text.textToNum())
        .floorAsFixedTwo()
        .toString();
    notifyListeners();
  }

  bool checkDoubleOrInteger() {
    if (kController.text.contains('.') || pController.text.contains(".")) {
      kController.text = kController.text.split(".").first;
      pController.text = pController.text.split('.').first;
      return false;
    }
    return true;
  }

  void clearText() {
    quantityController.clear();
    gramController.clear();
    kController.clear();
    yController.clear();
    pController.clear();
    wKController.clear();
    wYController.clear();
    wPController.clear();
    chargesController.clear();
    goldTotalAmountController.clear();
    notifyListeners();
  }

  Future<void> saveSelectedIssues(IssueStockVM issue) async {
    List<num> gold16KPY = UnitConverter.changeGoldState(
        kController.text.textToNum(),
        pController.text.textToNum(),
        yController.text.textToNum(),
        issue.stateId ?? '');
    List<num> wGold16KPY = UnitConverter.changeGoldState(
        wKController.text.textToNum(),
        wPController.text.textToNum(),
        wYController.text.textToNum(),
        issue.stateId ?? '');

    num gold16Gram = UnitConverter.changeGoldWeightToGram(

        /// 16 gold state
        gold16KPY[0],
        gold16KPY[1],
        gold16KPY[2]);
    num wGold16Gram = UnitConverter.changeGoldWeightToGram(
        wGold16KPY[0], wGold16KPY[1], wGold16KPY[2]);
    num total16Gram = gold16Gram + wGold16Gram;
    List<num> total16KPY = UnitConverter.changeGramToGoldWeight(total16Gram);
    num totalAmt16State = UnitConverter.calculateTheTotalAmtForKPY(
        total16KPY[0], total16KPY[1], total16KPY[2], goldPriceFor16k);

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
      kyat: kController.text.textToNum(),
      pae: pController.text.textToNum(),
      yawe: yController.text.textToNum(),
      gram: gramController.text.textToNum(),
      qty: quantityController.text.textToNum(),
      kyat16: total16KPY[0],
      pae16: total16KPY[1],
      yawe16: total16KPY[2],
      gram16: total16Gram,
      goldPrice: goldPrice,
      charges: _chargesController.text.textToNum(),
      totalAmt: _totalAmountController.text.textToNum(),
      totalAmt16State: totalAmt16State.toStringAsFixed(0).textToNum(),
      itemWasteList: [
        ItemWasteVM(
            wasteKyat: wKController.text.textToNum(),
            wastePae: wPController.text.textToNum(),
            wasteYawe: wYController.text.textToNum(),
            wasteGram: UnitConverter.changeGoldWeightToGram(
                wKController.text.textToNum(),
                wPController.text.textToNum(),
                wYController.text.textToNum()))
      ],
    );
    _ggLuckDataApply.saveSelectedIssueItem(selectedIssue);
  }

  TotalValueVM changeIssuesToTotalValue(List<IssueStockVM> issues,
      [bool isCreate = true]) {
    num tQty = 0;
    num tGram = 0;
    num total16Gram = 0;
    num totalAmt = 0;
    num totalWGram = 0;
    num totalCharges = 0;
    for (int i = 0; i < issues.length; i++) {
      tQty += issues[i].qty ?? 0;
      tGram += issues[i].gram ?? 0;
      total16Gram += issues[i].gram16 ?? 0;
      totalAmt += issues[i].totalAmt ?? 0;

      ///TODO totalAmt16State or totalAmt make sure
      totalWGram += issues[i].itemWasteList?[0].wasteGram ?? 0;
      totalCharges += issues[i].charges ?? 0;
    }
    List<num> totalKPYCharges =
        UnitConverter.calculateTotalToKPY(totalCharges, goldPriceFor16k);
    num totalGramCharges = UnitConverter.changeGoldWeightToGram(
        totalKPYCharges[0], totalKPYCharges[1], totalKPYCharges[2]);
    num tNetGram = tGram + totalWGram + totalGramCharges;
    total16Gram = totalGramCharges + total16Gram;
    List<num> total16KPY = UnitConverter.changeGramToGoldWeight(total16Gram);
    List<num> totalKPY = UnitConverter.changeGramToGoldWeight(tGram);
    List<num> netKPY = UnitConverter.changeGramToGoldWeight(tNetGram);
    List<num> totalWKPY = UnitConverter.changeGramToGoldWeight(totalWGram);

    final temp = TotalValueVM(
      tQty: tQty,
      tGram: tGram.floorAsFixedTwo(),
      tKyat: totalKPY[0],
      tPae: totalKPY[1],
      tYawe: totalKPY[2].floorAsFixedTwo(),
      tWKyat: totalWKPY[0],
      tWPae: totalWKPY[1],
      tWYawe: totalWKPY[2].floorAsFixedTwo(),
      tWasteGram: totalWGram.floorAsFixedTwo(),
      tNetGram: tNetGram.floorAsFixedTwo(),
      tNetKyat: netKPY[0],
      tNetPae: netKPY[1],
      tNetYawe: netKPY[2].floorAsFixedTwo(),
      tGram16: total16Gram.floorAsFixedTwo(),
      tKyat16: total16KPY[0],
      tPae16: total16KPY[1],
      tYawe16: total16KPY[2].floorAsFixedTwo(),
      tAdjustableGram: total16Gram.floorAsFixedTwo(),
      tAdjustableKyat: total16KPY[0],
      tAdjustablePae: total16KPY[1],
      tAdjustableYawe: total16KPY[2].floorAsFixedTwo(),
      tCGram: totalGramCharges.floorAsFixedTwo(),
      tCKyat: totalKPYCharges[0],
      tCPae: totalKPYCharges[1],
      tCYawe: totalKPYCharges[2].floorAsFixedTwo(),
      totalAmt: totalAmt,
    );
    if (isCreate) {
      _totalValueVM = temp;
    }
    return temp;
  }

  Future<void> createSaleVoucher(TotalValueVM totalV) async {
    var salVno = (DateTime.now().microsecondsSinceEpoch).toString();

    SaleVoucherVM saleVoucher = SaleVoucherVM(
        saleVno: 'SaleVno$salVno',
        totalQty: totalV.tQty,
        kyat16: totalV.tAdjustableKyat!,
        pae16: totalV.tAdjustablePae!,
        yawe16: totalV.tAdjustableYawe!.floorAsFixedTwo(),
        totalGram: totalV.tAdjustableGram!.floorAsFixedTwo(),
        totalWasteKyat: totalV.tWKyat!,
        totalWastePae: totalV.tWPae!,
        totalWasteYawe: totalV.tWYawe!.floorAsFixedTwo(),
        totalKyat: totalV.tKyat!,
        totalPae: totalV.tPae!,
        totalYawe: totalV.tYawe!.floorAsFixedTwo(),
        lat: 0,
        long: 0,
        remark: _remarkForCreatingSaleVoucher.text,
        totalAmount: totalV.totalAmt!.toStringAsFixed(0).textToNum(),
        customerId: _customerVM?.userId,
        saleVoucherDetail: _selectedIssuesList?.map((issue) {
          num? wasteKyat = issue.itemWasteList?[0].wasteKyat ?? 0;
          num? wastePae = issue.itemWasteList?[0].wastePae ?? 0;
          num? wasteYawe = issue.itemWasteList?[0].wasteYawe ?? 0;
          num wasteGram = UnitConverter.changeGoldWeightToGram(
              wasteKyat, wastePae, wasteYawe);
          num kPYGram = UnitConverter.changeGoldWeightToGram(
              issue.kyat!, issue.pae!, issue.yawe!);
          List<num> totalKPY =
              UnitConverter.changeGramToGoldWeight(wasteGram + kPYGram);
          return SaleVoucherDetailVM(
            saleVno: 'SaleVno$salVno',
            gglCode: issue.gglCode,
            kyat: issue.kyat,
            pae: issue.pae,
            gram: issue.gram!.floorAsFixedTwo(),
            qty: issue.qty,
            yawe: issue.yawe!.floorAsFixedTwo(),
            charges: issue.charges,
            kyat16: issue.kyat16,
            pae16: issue.pae16,
            yawe16: issue.yawe16!.floorAsFixedTwo(),
            goldPrice: issue.goldPrice,
            totalAmt: issue.totalAmt,

            ///TODO totalAmt16State or totalAmt make sure
            wasteKyat: wasteKyat,
            wastePae: wastePae,
            wasteYawe: wasteYawe.floorAsFixedTwo(),
            totalKyat: totalKPY[0],
            totalPae: totalKPY[1],
            totalYawe: totalKPY[2].floorAsFixedTwo(),
          );
        }).toList());
    await _ggLuckDataApply.postSaleVoucher(saleVoucher);
  }

  List<IssueStockVM> changeDetailToIssues(
      List<SaleVoucherDetailVM> saleVoucher) {
    List<IssueStockVM>? issueList = saleVoucher.map((detail) {
      return IssueStockVM(
        gglCode: detail.gglCode,
        qty: detail.qty,
        stateName: detail.stateName,
        image: detail.image,
        goldPrice: detail.goldPrice,
        typeName: detail.typeName,
        gram: detail.gram,
        gram16: UnitConverter.changeGoldWeightToGram(
            detail.kyat16 ?? 0, detail.pae16 ?? 01, detail.yawe16 ?? 0),
        kyat: detail.kyat,
        pae: detail.pae,
        charges: detail.charges,
        totalAmt16State: detail.totalAmt,
        yawe: detail.yawe,
        kyat16: detail.kyat16,
        pae16: detail.pae16,
        itemWasteList: detail.wasteKyat == 0 &&
                detail.wastePae == 0 &&
                detail.wasteYawe == 0
            ? null
            : [
                ItemWasteVM(
                    wasteGram: UnitConverter.changeGoldWeightToGram(
                      detail.wasteKyat ?? 0,
                      detail.wastePae ?? 0,
                      detail.wasteYawe ?? 0,
                    ),
                    wasteKyat: detail.wasteKyat,
                    wastePae: detail.wastePae,
                    wasteYawe: detail.wasteYawe)
              ],
        yawe16: detail.yawe16,
        itemName: detail.itemName,
        itemGemList: detail.itemGemList,
      );
    }).toList();
    return issueList;
  }

  TotalValueVM changeDetailToTotalVal(List<SaleVoucherDetailVM> voDetail) {
    num totalGram = 0;
    num totalWasteGram = 0;
    num totalNetGram = 0;
    num total16KPYGram = 0;
    num totalQty = 0;
    num totalAmt = 0;
    num totalCharges = 0;
    for (int i = 0; i < voDetail.length; i++) {
      totalQty += voDetail[i].qty ?? 0;
      totalAmt += voDetail[i].totalAmt ?? 0;
      totalCharges += voDetail[i].charges ?? 0;
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
    List<num> totalKPYCharges =
        UnitConverter.calculateTotalToKPY(totalCharges, goldPriceFor16k);
    num totalGramCharges = UnitConverter.changeGoldWeightToGram(
        totalKPYCharges[0], totalKPYCharges[1], totalKPYCharges[2]);
    List<num> totalKPY = UnitConverter.changeGramToGoldWeight(totalGram);
    List<num> wasteKPY = UnitConverter.changeGramToGoldWeight(totalWasteGram);
    totalNetGram = totalGramCharges + totalNetGram;
    List<num> netKPY = UnitConverter.changeGramToGoldWeight(totalNetGram);
    List<num> total16KPY = UnitConverter.changeGramToGoldWeight(total16KPYGram);
    TotalValueVM totalVal = TotalValueVM(
      tQty: totalQty,
      totalAmt: totalAmt,
      tGram: totalGram.toStringAsFixed(2).textToNum(),
      tKyat: totalKPY[0],
      tPae: totalKPY[1],
      tYawe: totalKPY[2].toStringAsFixed(2).textToNum(),
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
      tCGram: totalGramCharges.floorAsFixedTwo(),
      tCKyat: totalKPYCharges[0],
      tCPae: totalKPYCharges[1],
      tCYawe: totalKPYCharges[2].floorAsFixedTwo(),
    );
    return totalVal;
  }

  Future<void> deleteSelectedVouchers() async {
    _ggLuckDataApply.deleteSelectedCustomer();
    await _ggLuckDataApply.deleteSelectedIssues();
  }

  Future<void> deleteSaleVoucher(String voucherNo) async {
    await _ggLuckDataApply.deleteSaleVoucher(
        voucherNo, _remarkSaleTextController.text.toString());
  }

  void filterSaleVoucherLocal(TextEditingController textEditingController) {
    if (_todaySaleVouchers == null) return;
    _isFilter = true;
    _filterTodaySaleVouchers = [];
    if (textEditingController.text.isEmpty) {
      getSaleVouchers();
    }
    if (textEditingController.text.isNotEmpty) {
      for (var element in _todaySaleVouchers!) {
        if (element.saleVno!
                .trim()
                .toLowerCase()
                .contains(textEditingController.text.trim().toLowerCase()) ||
            element.customerName!.trim().toLowerCase().contains(
                    textEditingController.text.trim().toLowerCase()) &&
                element.deleteBy == null) {
          _filterTodaySaleVouchers.add(element);
        }
      }
    }
    notifyListeners();
    _saleScrollController.jumpTo(0);
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
    quantityController.dispose();
    gramController.dispose();
    kController.dispose();
    yController.dispose();
    pController.dispose();
    wKController.dispose();
    wPController.dispose();
    wYController.dispose();
    _remarkForCreatingSaleVoucher.dispose();
    _availableSaleController.dispose();
    _searchController.dispose();
    _saleScrollController.dispose();
    _reportSearchTextEditingController.dispose();
    _remarkSaleTextController.dispose();
    _goldTotalAmountController.dispose();
    _totalAmountController.dispose();
    _chargesController.dispose();
    _isDispose = false;
    super.dispose();
  }
}
