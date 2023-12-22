import 'package:flutter/cupertino.dart';
import 'package:desktop_test/data/data_apply/data_apply/gg_luck_data_apply_imp.dart';
import 'package:desktop_test/data/vms/issue_stock/issue_stock_vm.dart';
import 'package:desktop_test/data/vms/issue_stock/item_type.dart';

import '../data/data_apply/data_apply/gg_luck_data_apply.dart';

class HomePageProvider extends ChangeNotifier {
  bool _isDispose = false;
  HomePageProvider._();
  bool _isContain = true;
  final TextEditingController _searchController = TextEditingController();
  static final HomePageProvider _singleton = HomePageProvider._();
  factory HomePageProvider() => _singleton;
  final ScrollController _scrollController = ScrollController();

  bool get isContain => _isContain;

  TextEditingController get searchController => _searchController;
  ScrollController get scrollController => _scrollController;

  /// instant variables
  final GgLuckDataApply _ggLuckDataApply = GgLuckDataApplyImpl();
  List<IssueStockVM>? _issuesStocks;
  List<IssueStockVM> filteredIssueStocks = [];
  List<ItemType>? itemTypes;

  List<IssueStockVM>? get issuesStock => _issuesStocks;
  Future<void> getIssuesStocks({bool isRefresh = false}) async {
    if (isRefresh) {
      _issuesStocks = null;
      notifyListeners();
    }
    _issuesStocks = await _ggLuckDataApply.getIssues();
    notifyListeners();
  }

  Future<void> getItemTypes() async {
    itemTypes = await _ggLuckDataApply.getItemType();
    notifyListeners();
  }

  void searchIssues() {
    filteredIssueStocks = [];
    if (_searchController.text.isEmpty) {
      _isContain = true;
      getIssuesStocks();
    }
    if (_searchController.text.isNotEmpty) {
      for (var issue in _issuesStocks!) {
        if (issue.gglCode!
                .toLowerCase()
                .contains(_searchController.text.toLowerCase()) ||
            issue.itemName!
                .toLowerCase()
                .contains(_searchController.text.toLowerCase())) {
          filteredIssueStocks.add(issue);
        }
      }
      if (filteredIssueStocks.isEmpty) {
        _isContain = false;
      } else {
        _isContain = true;
      }
    }
    notifyListeners();
    scrollController.jumpTo(0);
  }

  @override
  void notifyListeners() {
    if (!_isDispose) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _isDispose = true;
    super.dispose();
  }
}
