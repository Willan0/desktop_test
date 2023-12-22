// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:desktop_test/constant/color.dart';
import 'package:desktop_test/constant/dimen.dart';
import 'package:desktop_test/data/vms/issue_stock/main_stock.dart';
import 'package:desktop_test/provider/transfer_voucher_provider.dart';
import 'package:desktop_test/utils/extension.dart';
import 'package:desktop_test/data/vms/sale_voucher/total_value_vm.dart';
import 'package:desktop_test/widgets/easy_text.dart';
import 'package:provider/provider.dart';

import '../../data/vms/issue_stock/issue_stock_vm.dart';
import '../../provider/return_voucher_provider.dart';
import '../../provider/sale_voucher_provider.dart';
import '../../view_items/create_voucher_view_item.dart';
import '../../widgets/draggable_bottom_sheet.dart';

class CreateVoucherPage extends StatefulWidget {
  const CreateVoucherPage({
    super.key,
    this.isSale = false,
    this.isTransfer = false,
    this.issues,
    this.mainStocks,
  });

  final bool isSale;
  final List<IssueStockVM>? issues;
  final List<MainStock>? mainStocks;
  final bool isTransfer;

  @override
  State<CreateVoucherPage> createState() => _CreateVoucherPageState();
}

class _CreateVoucherPageState extends State<CreateVoucherPage> {
  bool _isInitialized = false;
  late SaleVoucherProvider _saleVoucherProvider;
  late ReturnVoucherProvider _returnVoucherProvider;
  late TransferVoucherProvider _transferVoucherProvider;
  late TotalValueVM totalValue;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
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
    totalValue = widget.isSale
        ? _saleVoucherProvider.totalValueVM
        : widget.isTransfer
            ? _transferVoucherProvider.totalValueVM
            : _returnVoucherProvider.totalValueVM;
  }

  _loadDataForSale() {
    _saleVoucherProvider.changeIssuesToTotalValue(widget.issues ?? []);
  }

  _loadDataForTransfer() {
    _transferVoucherProvider.changeIssuesToTotalValue(widget.issues ?? []);
  }

  _loadDataForReturn() {
    _returnVoucherProvider
        .changeMainStocksToTotalValue(widget.mainStocks ?? []);
  }

  @override
  Widget build(BuildContext context) {
    _isInitialized = true;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(getWidth(context), kToolbarHeight),
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: AppBar(
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarIconBrightness: Brightness.dark,
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: const EasyText(
                text: 'Create Voucher',
                fontSize: kFs16x,
                fontWeight: FontWeight.bold,
              ),
              centerTitle: false,
              leadingWidth: kAs50x,
              leading: Padding(
                padding: const EdgeInsets.only(left: 18),
                child: IconButton(
                    onPressed: () {
                      context.popScreen();
                    },
                    icon: const Icon(
                      CupertinoIcons.arrow_left,
                      color: Colors.black,
                    )),
              ),
            ),
          )),
      backgroundColor: kBackGroundColor,
      body: Stack(children: [
        widget.isTransfer
            ? AvailableItemViewForTransfer(
                transferVoucherProvider:
                    context.watch<TransferVoucherProvider>())
            : AvailableItemView(isSale: widget.isSale),
        DraggableBottomSheetView(
          minSize: context.responsiveHeight(0.22, md: 0.21, xl: 0.15),
          initialSize: context.responsiveHeight(0.22, md: 0.21, xl: 0.15),
          maxSize: context.responsiveHeight(
            widget.isTransfer
                ? 0.5
                : widget.isSale
                    ? 0.76
                    : 0.7,
            xl: widget.isTransfer
                ? 0.274
                : widget.isSale
                    ? 0.42
                    : 0.39,
            lg: widget.isTransfer
                ? 0.45
                : widget.isSale
                    ? 0.66
                    : 0.61,
            md: widget.isTransfer
                ? 0.48
                : widget.isSale
                    ? 0.7
                    : 0.652,
            sm: widget.isTransfer
                ? 0.465
                : widget.isSale
                    ? 0.72
                    : 0.67,
          ),
          isTransfer: widget.isTransfer,
          totalValueVM: totalValue,
          incrementFunction: () {
            widget.isSale
                ? _saleVoucherProvider.adjustGoldWeightValue()
                : widget.isTransfer
                    ? _transferVoucherProvider.adjustGoldWeightValue()
                    : _returnVoucherProvider.adjustGoldWeightValue();
          },
          decrementFunction: () {
            widget.isSale
                ? _saleVoucherProvider.adjustGoldWeightValue(false)
                : widget.isTransfer
                    ? _transferVoucherProvider.adjustGoldWeightValue(false)
                    : _returnVoucherProvider.adjustGoldWeightValue(false);
          },
          isSale: widget.isSale,
          isDetail: false,
        ),
        ConfirmButtonView(
          totalV: totalValue,
          isSale: widget.isSale,
          isTransfer: widget.isTransfer,
        ),
      ]),
    );
  }
}
