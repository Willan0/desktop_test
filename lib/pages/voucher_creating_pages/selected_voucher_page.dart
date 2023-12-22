import 'package:flutter/material.dart';
import 'package:desktop_test/constant/color.dart';
import 'package:desktop_test/constant/dimen.dart';
import 'package:desktop_test/data/vms/issue_stock/issue_stock_vm.dart';
import 'package:desktop_test/data/vms/issue_stock/main_stock.dart';
import 'package:desktop_test/pages/voucher_creating_pages/available_page.dart';
import 'package:desktop_test/provider/sale_voucher_provider.dart';
import 'package:desktop_test/provider/return_voucher_provider.dart';
import 'package:desktop_test/utils/extension.dart';
import 'package:desktop_test/utils/responsive_view.dart';
import 'package:desktop_test/widgets/easy_app_bar.dart';
import 'package:desktop_test/widgets/easy_button.dart';
import 'package:desktop_test/widgets/easy_text.dart';
import 'package:provider/provider.dart';

import '../../provider/transfer_voucher_provider.dart';
import '../../widgets/reuse_floating_button.dart';
import 'create_voucher.dart';

class SelectedVoucherPage extends StatefulWidget {
  const SelectedVoucherPage(
      {super.key, this.isSale = false, this.isTransfer = false});

  final bool isSale;
  final bool isTransfer;

  @override
  State<SelectedVoucherPage> createState() => _SelectedVoucherPageState();
}

class _SelectedVoucherPageState extends State<SelectedVoucherPage> {
  bool _isInitialized = false;
  late SaleVoucherProvider _saleVoucherProvider;
  late ReturnVoucherProvider _returnVoucherProvider;
  late TransferVoucherProvider _transferVoucherProvider;
  List<IssueStockVM> issues = [];
  List<MainStock> mainStocks = [];
  bool _isEmpty = true;
  bool _isCanBack = false;

  @override
  void initState() {
    _isInitialized = false;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    widget.isSale
        ? _saleVoucherProvider = context.watch<SaleVoucherProvider>()
        : widget.isTransfer
            ? _transferVoucherProvider =
                context.watch<TransferVoucherProvider>()
            : _returnVoucherProvider = context.watch<ReturnVoucherProvider>();
    if (!_isInitialized) {
      widget.isSale
          ? _loadDataForSale()
          : widget.isTransfer
              ? _loadDataForTransfer()
              : _loadDataForReturn();
    }
    widget.isSale
        ? issues = _saleVoucherProvider.selectedIssues ?? []
        : widget.isTransfer
            ? issues = _transferVoucherProvider.selectedIssuesList ?? []
            : mainStocks = _returnVoucherProvider.selectedMainStocks ?? [];
    _isEmpty = widget.isSale
        ? _saleVoucherProvider.isHaveSelectedIssue
        : widget.isTransfer
            ? _transferVoucherProvider.isHaveSelectedItem
            : _returnVoucherProvider.isHaveSelectedMainStocks;
    super.didChangeDependencies();
  }

  _loadDataForSale() async {
    await _saleVoucherProvider.getSelectedIssues();
  }

  _loadDataForReturn() {
    _returnVoucherProvider.getSelectedMainStocks();
  }

  _loadDataForTransfer() async {
    await _transferVoucherProvider.getSelectedIssues();
  }

  _deleteDialogForSale() {
    context.showWarningDialog(context,
        warningText: "Are you sure to go back?",
        textLeft: "No",
        textRight: "Yes",
        bottom: const EasyText(
          text: 'It will delete selected items',
          fontSize: kFs14x,
        ), onTextRight: () async {
      context.popScreen();
      context.popScreen();
      await _saleVoucherProvider.deleteSelectedVouchers();
      _isCanBack = true;
    });
  }

  _deleteDialogForTransfer() {
    context.showWarningDialog(context,
        warningText: "Are you sure to go back?",
        textLeft: "No",
        textRight: "Yes",
        bottom: const EasyText(
          text: 'It will delete selected items',
          fontSize: kFs14x,
        ), onTextRight: () async {
      context.popScreen();
      context.popScreen();
      await _transferVoucherProvider.deleteSelectedVouchers();
      _isCanBack = true;
    });
  }

  _deleteDialogForReturn() {
    context.showWarningDialog(context,
        warningText: "Are you sure to go back?",
        textLeft: "No",
        textRight: "Yes",
        bottom: const EasyText(
          text: 'It will delete selected items',
          fontSize: kFs14x,
        ), onTextRight: () async {
      context.popScreen();
      context.popScreen();
      await _returnVoucherProvider.deleteSelectedMainStocks();
      _isCanBack = true;
    });
  }

  _willPopEmptyState() {
    _isCanBack = true;
  }

  @override
  Widget build(BuildContext context) {
    _isInitialized = true;
    return WillPopScope(
      onWillPop: () async {
        widget.isSale
            ? !_isEmpty
                ? await _willPopEmptyState()
                : await _deleteDialogForSale()
            : widget.isTransfer
                ? !_isEmpty
                    ? await _willPopEmptyState()
                    : await _deleteDialogForTransfer()
                : !_isEmpty
                    ? await _willPopEmptyState()
                    : await _deleteDialogForReturn();
        return _isCanBack;
      },
      child: Scaffold(
        backgroundColor: kBackGroundColor,
        appBar: PreferredSize(
          preferredSize: Size(getWidth(context), kToolbarHeight),
          child: Padding(
              padding: const EdgeInsets.only(top: kAs10x),
              child: EasyAppBar(
                text: widget.isSale
                    ? 'Select Sale Items'
                    : widget.isTransfer
                        ? "Select Transfer Items"
                        : "Select Main Stocks",
                leading: true,
                onPressed: widget.isSale
                    ? !_isEmpty
                        ? null
                        : () {
                            _deleteDialogForSale();
                          }
                    : widget.isTransfer
                        ? !_isEmpty
                            ? null
                            : () {
                                _deleteDialogForTransfer();
                              }
                        : !_isEmpty
                            ? null
                            : () {
                                _deleteDialogForReturn();
                              },
                action: widget.isSale
                    ? '${issues.length}'.addS()
                    : widget.isTransfer
                        ? '${issues.length}'.addS()
                        : '${mainStocks.length}'.addS(),
              )),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: ReuseFloatingActionButton(
          page: AvailablePage(
              isSale: widget.isSale, isTransfer: widget.isTransfer),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const SizedBox(
              height: kAs10x,
            ),
            Expanded(
                child: widget.isSale || widget.isTransfer
                    ? (issues.isEmpty)
                        ? const Center(
                            child: EasyText(
                              text: 'No items are selected',
                              fontSize: kFs16x,
                            ),
                          )
                        : context.responsive(
                            MobileListView(
                              list: issues,
                              isSelect: true,
                              isIssue: true,
                              isCanDelete: true,
                            ),
                            lg: TabletGridView(
                              list: issues,
                              childAspectRatio: 1.8,
                              isSelect: true,
                              crossAxisCount: 3,
                              isIssue: true,
                              isCanDelete: true,
                            ),
                            md: TabletGridView(
                                list: issues,
                                childAspectRatio: 1.6,
                                isSelect: true,
                                crossAxisCount: 2,
                                isCanDelete: true,
                                isIssue: true))
                    : mainStocks.isEmpty
                        ? const Center(
                            child: EasyText(
                              text: 'No items are selected',
                              fontSize: kFs16x,
                            ),
                          )
                        : context.responsive(
                            MobileListView(
                              list: mainStocks,
                              isCanDelete: true,
                            ),
                            lg: TabletGridView(
                              list: mainStocks,
                              childAspectRatio: 2.23,
                              crossAxisCount: 3,
                              isCanDelete: true,
                            ),
                            md: TabletGridView(
                              list: mainStocks,
                              childAspectRatio: 1.8,
                              crossAxisCount: 2,
                              isCanDelete: true,
                            ))),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kAs20x),
              child: EasyButton(
                label: 'Create Voucher',
                width: getWidth(context),
                onPressed: _isEmpty
                    ? widget.isSale
                        ? () async {
                            context.pushScreen(CreateVoucherPage(
                              isSale: widget.isSale,
                              issues: issues,
                            ));
                          }
                        : widget.isTransfer
                            ? () async {
                                context.pushScreen(CreateVoucherPage(
                                  isTransfer: widget.isTransfer,
                                  issues: issues,
                                ));
                              }
                            : () async {
                                context.pushScreen(CreateVoucherPage(
                                    mainStocks: mainStocks,
                                    isSale: widget.isSale));
                              }
                    : () {
                        context.showWarningDialog(context,
                            warningText: 'Please select item', textLeft: "Ok");
                      },
                isNotIcon: true,
              ),
            ),
            const SizedBox(
              height: kAs20x,
            ),
          ],
        ),
      ),
    );
  }
}
