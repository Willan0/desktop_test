// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:desktop_test/constant/color.dart';
import 'package:desktop_test/constant/assets.dart';
import 'package:desktop_test/data/vms/return_voucher/return_voucher.dart';
import 'package:desktop_test/data/vms/return_voucher/return_voucher_detail_vm.dart';
import 'package:desktop_test/data/vms/sale_voucher/sale_voucher.dart';
import 'package:desktop_test/data/vms/sale_voucher/sale_voucher_detail.dart';
import 'package:desktop_test/data/vms/transfer_voucher/transfer_voucher.dart';
import 'package:desktop_test/data/vms/transfer_voucher/transfer_voucher_detail.dart';
import 'package:desktop_test/data/vms/user/user.dart';
import 'package:desktop_test/pages/gg_luck.dart';
import 'package:desktop_test/pages/voucher_page_components/print_page.dart';
import 'package:desktop_test/provider/home_page_provider.dart';
import 'package:desktop_test/provider/return_voucher_provider.dart';
import 'package:desktop_test/provider/sale_voucher_provider.dart';
import 'package:desktop_test/provider/transfer_voucher_provider.dart';
import 'package:desktop_test/utils/extension.dart';
import 'package:desktop_test/utils/responsive_view.dart';
import 'package:desktop_test/widgets/customer_card.dart';
import 'package:desktop_test/widgets/easy_app_bar.dart';
import 'package:desktop_test/widgets/easy_button.dart';
import 'package:desktop_test/widgets/easy_text_field.dart';
import 'package:provider/provider.dart';

import '../../constant/dimen.dart';
import '../../widgets/draggable_bottom_sheet.dart';
import '../../widgets/easy_text.dart';

class VoucherDetail extends StatefulWidget {
  const VoucherDetail(
      {super.key,
      this.saleVoucher,
      this.isSale = true,
      this.returnVoucherVM,
      required this.isReport});

  final SaleVoucherVM? saleVoucher;
  final ReturnVoucherVM? returnVoucherVM;
  final bool isSale;
  final bool isReport;

  @override
  State<VoucherDetail> createState() => _VoucherDetailState();
}

class _VoucherDetailState extends State<VoucherDetail> {
  late SaleVoucherProvider _saleVoucherProvider;
  late ReturnVoucherProvider _returnVoucherProvider;
  List<SaleVoucherDetailVM>? _saleVouchersDetail;
  List<ReturnVoucherDetailVM>? _returnVouchersDetail;
  bool _isInitialize = false;
  bool _isLoading = true;

  @override
  void didChangeDependencies() async {
    widget.isSale
        ? _saleVoucherProvider = context.watch<SaleVoucherProvider>()
        : _returnVoucherProvider = context.watch<ReturnVoucherProvider>();

    if (!_isInitialize) {
      widget.isSale
          ? await _saleVoucherProvider
              .getSaleVouchersDetail(widget.saleVoucher?.saleVno ?? '')
          : await _returnVoucherProvider
              .getReturnVouchersDetail(widget.returnVoucherVM?.returnVno ?? '');
      _isLoading = false;
    }
    widget.isSale
        ? _saleVouchersDetail = _saleVoucherProvider.saleVouchersDetail
        : _returnVouchersDetail = _returnVoucherProvider.returnVouchersDetail;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    _isInitialize = true;
    return Scaffold(
      backgroundColor: kBackGroundColor,
      appBar: PreferredSize(
          preferredSize: Size(getWidth(context), kToolbarHeight),
          child: EasyAppBar(
            text:
                widget.isSale ? 'Sale Voucher Detail' : 'Return Voucher Detail',
            leading: true,
          )),
      body: _isLoading
          ? context.showLoading()
          : Stack(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: kAs20x,
                  ),

                  /// customer
                  const Padding(
                    padding: EdgeInsets.only(left: kAs20x),
                    child: EasyText(
                      text: 'Customer',
                      fontFamily: roboto,
                      fontSize: kFs18x,
                    ),
                  ),
                  const SizedBox(
                    height: kAs15x,
                  ),
                  SizedBox(
                    width: getWidth(context),
                    child: CustomerCard(
                        customerVM: UserVM(
                            detailAddress: widget.isSale
                                ? _saleVouchersDetail![0].detailAddress
                                : _returnVouchersDetail?[0].detailAddress,
                            fullName: widget.isSale
                                ? _saleVouchersDetail![0].customerName
                                : _returnVouchersDetail?[0].customerName,
                            phone: widget.isSale
                                ? widget.saleVoucher?.phone
                                : _returnVouchersDetail?[0].phone,
                            userId: widget.isSale
                                ? _saleVouchersDetail![0].saleVno
                                : _returnVouchersDetail?[0].returnVno)),
                  ),
                  const Divider(
                    indent: 20,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    height: kAs10x,
                  ),

                  /// item list
                  widget.isSale
                      ? Expanded(
                          child: _saleVouchersDetail == null
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : context.responsive(
                                  MobileListView(
                                    list: _saleVoucherProvider
                                        .changeDetailToIssues(
                                            _saleVouchersDetail ?? []),
                                    isIssue: true,
                                    isSelect: true,
                                  ),
                                  lg: TabletGridView(
                                      list: _saleVoucherProvider
                                          .changeDetailToIssues(
                                              _saleVouchersDetail ?? []),
                                      isIssue: true,
                                      isSelect: true,
                                      childAspectRatio: 2,
                                      crossAxisCount: 3),
                                  md: TabletGridView(
                                      list: _saleVoucherProvider
                                          .changeDetailToIssues(
                                              _saleVouchersDetail ?? []),
                                      isIssue: true,
                                      isSelect: true,
                                      childAspectRatio: 1.8,
                                      crossAxisCount: 2)))
                      : Expanded(
                          child: _returnVouchersDetail == null
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : context.responsive(
                                  MobileListView(
                                    list: _returnVoucherProvider
                                        .changeDetailToMainStocks(
                                            _returnVouchersDetail ?? []),
                                  ),
                                  lg: TabletGridView(
                                      list: _returnVoucherProvider
                                          .changeDetailToMainStocks(
                                              _returnVouchersDetail ?? []),
                                      childAspectRatio: 2.2,
                                      crossAxisCount: 3),
                                  md: TabletGridView(
                                      list: _returnVoucherProvider
                                          .changeDetailToMainStocks(
                                              _returnVouchersDetail ?? []),
                                      childAspectRatio: 2,
                                      crossAxisCount: 2))),
                  SizedBox(
                    height: (widget.isReport)
                        ? context.responsive(getHeight(context) * 0.14,
                            md: getHeight(context) * 0.1)
                        : getHeight(context) *
                            context.responsiveHeight(0.17, sm: 0.185),
                  ),
                ],
              ),

              /// grand summary
              DraggableBottomSheetView(
                isSale: widget.isSale,
                initialSize: context.responsiveHeight(
                    widget.isReport ? 0.15 : 0.2,
                    xl: widget.isReport ? 0.12 : 0.15,
                    lg: widget.isReport ? 0.16 : 0.17,
                    md: widget.isReport ? 0.15 : 0.19),
                minSize: context.responsiveHeight(widget.isReport ? 0.15 : 0.2,
                    xl: widget.isReport ? 0.12 : 0.15,
                    lg: widget.isReport ? 0.16 : 0.17,
                    md: widget.isReport ? 0.15 : 0.19),
                maxSize: context.responsiveHeight(
                    (widget.isReport && widget.isSale)
                        ? 0.6
                        : widget.isReport
                            ? 0.55
                            : widget.isSale
                                ? 0.66
                                : 0.61,
                    xl: (widget.isReport && widget.isSale)
                        ? 0.36
                        : widget.isReport
                            ? 0.31
                            : widget.isSale
                                ? 0.37
                                : 0.343,
                    lg: (widget.isReport && widget.isSale)
                        ? 0.52
                        : widget.isReport
                            ? 0.48
                            : widget.isSale
                                ? 0.57
                                : 0.52,
                    md: (widget.isReport && widget.isSale)
                        ? 0.56
                        : widget.isReport
                            ? 0.51
                            : widget.isSale
                                ? 0.61
                                : 0.556,
                    sm: (widget.isReport && widget.isSale)
                        ? 0.58
                        : widget.isReport
                            ? 0.53
                            : widget.isSale
                                ? 0.63
                                : 0.58),
                gram: widget.isSale
                    ? widget.saleVoucher?.totalGram
                    : widget.returnVoucherVM?.totalGram,
                kyat16: widget.isSale
                    ? widget.saleVoucher?.kyat16
                    : widget.returnVoucherVM?.kyat16,
                pae16: widget.isSale
                    ? widget.saleVoucher?.pae16
                    : widget.returnVoucherVM?.pae16,
                yawe16: widget.isSale
                    ? widget.saleVoucher?.yawe16
                    : widget.returnVoucherVM?.yawe16,
                totalAmt: widget.isSale
                    ? widget.saleVoucher?.totalAmount
                    : widget.returnVoucherVM?.totalAmt,
                isReport: widget.isReport,
                totalValueVM: widget.isSale
                    ? _saleVoucherProvider
                        .changeDetailToTotalVal(_saleVouchersDetail ?? [])
                    : _returnVoucherProvider
                        .changeDetailToTotalValue(_returnVouchersDetail ?? []),
              ),

              /// delete and print button
              widget.isReport
                  ? const SizedBox()
                  : Positioned(
                      bottom: 10,
                      left: 0,
                      right: 0,
                      child: DeleteAndPrintView(
                        isDeleted: widget.isSale
                            ? widget.saleVoucher?.deleteBy != null
                            : widget.returnVoucherVM?.deleteBy != null,
                        deleteFunction: () {
                          _deleteFunction(() async {
                            widget.isSale
                                ? await _saleVoucherProvider.deleteSaleVoucher(
                                    _saleVouchersDetail?[0].saleVno ?? '')
                                : await _returnVoucherProvider
                                    .deleteReturnVoucher(
                                        _returnVouchersDetail?[0].returnVno ??
                                            '');
                          },
                              widget.isSale
                                  ? _saleVoucherProvider
                                      .remarkSaleTextController
                                  : _returnVoucherProvider
                                      .remarkReturnTextController);
                        },
                        printFunction: () {},
                      ))
            ]),
    );
  }

  _deleteFunction(
      Future<void> Function() onDelete, TextEditingController controller) {
    widget.isSale
        ? _saleVoucherProvider.remarkSaleTextController.clear()
        : _returnVoucherProvider.remarkReturnTextController.clear();
    context.showWarningDialog(context,
        warningText: "Are you sure to delete?",
        textLeft: 'Cancel',
        bottom: EasyTextField(controller: controller, hintText: 'Enter remark'),
        textRight: 'Yes', onTextRight: () async {
      context.showLoadingDialog();
      final homepageProvider = context.read<HomePageProvider>();
      await homepageProvider.getIssuesStocks();
      await onDelete();
      // await saleProvider.getSaleVouchers();
      context.popScreen();
      Navigator.of(context).popUntil((route) => route.isFirst);
      context.pushReplacement(const GgLuck(
        index: 1,
      ));
    });
  }
}

class VoucherDetailForTransfer extends StatefulWidget {
  const VoucherDetailForTransfer(
      {super.key,
      required this.transferVm,
      required this.isReceive,
      this.isReport = false});

  final TransferVoucherVM transferVm;
  final bool isReceive;
  final bool isReport;
  @override
  State<VoucherDetailForTransfer> createState() =>
      _VoucherDetailForTransferState();
}

class _VoucherDetailForTransferState extends State<VoucherDetailForTransfer> {
  late TransferVoucherProvider _transferVoucherProvider;
  List<TransferVoucherDetailVM> _transferVouchersDetail = [];
  bool _isInitialized = false;
  bool _isLoading = true;
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    _transferVoucherProvider = context.watch<TransferVoucherProvider>();
    if (!_isInitialized) {
      await _transferVoucherProvider
          .getTransferVouchersDetail(widget.transferVm.transferVno ?? '');
      _isLoading = false;
    }
    _transferVouchersDetail =
        _transferVoucherProvider.transferVouchersDetail ?? [];
  }

  @override
  Widget build(BuildContext context) {
    _isInitialized = true;
    return Scaffold(
      backgroundColor: kBackGroundColor,
      appBar: PreferredSize(
          preferredSize: Size(getWidth(context), kToolbarHeight),
          child: const EasyAppBar(
            text: 'Transfer Voucher Detail',
            leading: true,
          )),
      body: _isLoading
          ? context.showLoading()
          : Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: kAs20x),
                      padding: const EdgeInsets.all(kAs10x),
                      decoration: BoxDecoration(
                          color: kWhiteColor,
                          borderRadius: BorderRadius.circular(kBr20x)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          EasyText(
                            text: _transferVouchersDetail[0].transferVno ?? '',
                            fontSize: kFs14x,
                          ),
                          EasyText(
                            text:
                                "TransferUser : ${_transferVouchersDetail[0].transferUserName ?? ''}",
                            fontSize: kFs16x,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: kAs10x,
                    ),
                    const Divider(
                      indent: 20,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      height: kAs10x,
                    ),
                    Expanded(
                        child: context.responsive(
                            MobileListView(
                                isIssue: true,
                                list: _transferVoucherProvider
                                    .changeDetailToIssues(
                                        _transferVouchersDetail)),
                            lg: TabletGridView(
                                isIssue: true,
                                list: _transferVoucherProvider
                                    .changeDetailToIssues(
                                        _transferVouchersDetail),
                                childAspectRatio: 2.5,
                                crossAxisCount: 3),
                            md: TabletGridView(
                                isIssue: true,
                                list: _transferVoucherProvider
                                    .changeDetailToIssues(
                                        _transferVouchersDetail),
                                childAspectRatio: 2.05,
                                crossAxisCount: 2))),
                    SizedBox(
                      height: getHeight(context) *
                          context.responsiveHeight(0.2, sm: 0.194),
                    )
                  ],
                ),
                DraggableBottomSheetView(
                  minSize: context.responsiveHeight(
                      widget.isReceive ? 0.2 : 0.18,
                      xl: 0.16,
                      lg: 0.22,
                      md: 0.22,
                      sm: 0.21),
                  initialSize: context.responsiveHeight(
                      widget.isReceive ? 0.2 : 0.2,
                      xl: 0.16,
                      lg: 0.22,
                      md: 0.22,
                      sm: 0.21),
                  maxSize: context.responsiveHeight(
                      widget.isReceive ? 0.48 : 0.47,
                      xl: 0.265,
                      lg: 0.44,
                      md: 0.47,
                      sm: widget.isReceive ? 0.46 : 0.45),
                  isTransfer: true,
                  gram: widget.transferVm.totalGram,
                  kyat16: widget.transferVm.kyat16,
                  pae16: widget.transferVm.pae16,
                  yawe16: widget.transferVm.yawe16,
                  isReport: widget.isReport,
                  totalValueVM: _transferVoucherProvider
                      .changeDetailToTotalVal(_transferVouchersDetail),
                ),
                Positioned(
                    bottom: 10,
                    left: 0,
                    right: 0,
                    child: widget.isReceive
                        ? Padding(
                            padding: const EdgeInsets.only(
                              left: kAs20x,
                              right: kAs20x,
                            ),
                            child: EasyButton(
                              height: kAs45x,
                              label: 'Receive',
                              isNotIcon: true,
                              width: getWidth(context),
                              onPressed: () async {
                                _transferVoucherProvider.receiveRemarkController
                                    .clear();
                                context.showWarningDialog(context,
                                    warningText: 'Are you sure to received? ',
                                    textLeft: 'Cancel',
                                    textRight: 'Yes',
                                    bottom: EasyTextField(
                                        controller: _transferVoucherProvider
                                            .receiveRemarkController,
                                        hintText: "Enter remark"),
                                    onTextRight: () async {
                                  context.popScreen();
                                  context.showLoadingDialog();
                                  await _transferVoucherProvider
                                      .receiveTransferVoucher(
                                          widget.transferVm.transferVno ?? '');
                                  await _transferVoucherProvider
                                      .getReceivedTransferVouchers();
                                  await context
                                      .read<HomePageProvider>()
                                      .getIssuesStocks();
                                  context.popScreen();
                                  context.popScreen();
                                });
                              },
                            ),
                          )
                        : widget.transferVm.receivedBy != null
                            ? Padding(
                                padding: const EdgeInsets.only(
                                  left: kAs20x,
                                  right: kAs20x,
                                ),
                                child: EasyButton(
                                  height: kAs45x,
                                  label: 'Print',
                                  isNotIcon: true,
                                  onPressed: () {
                                    context.pushScreen(const PrintPage());
                                  },
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: kAs20x),
                                child: TextButton.icon(
                                    style: TextButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                      side: const BorderSide(color: Colors.red),
                                      borderRadius:
                                          BorderRadius.circular(kBr10x),
                                    )),
                                    onPressed: () {
                                      _transferVoucherProvider
                                          .receivedPendingDeleteController
                                          .clear();
                                      context.showWarningDialog(context,
                                          warningText:
                                              'Are you sure to delete? ',
                                          textLeft: 'Cancel',
                                          textRight: 'Yes',
                                          bottom: EasyTextField(
                                              controller: _transferVoucherProvider
                                                  .receivedPendingDeleteController,
                                              hintText: "Enter remark"),
                                          onTextRight: () async {
                                        context.popScreen();
                                        context.showLoadingDialog();
                                        await _transferVoucherProvider
                                            .deleteTransferVoucher(
                                                widget.transferVm.transferVno ??
                                                    '');
                                        _transferVoucherProvider
                                            .getTransferVouchersReport(
                                                _transferVoucherProvider
                                                    .startDate,
                                                _transferVoucherProvider
                                                    .endDate,
                                                _transferVoucherProvider.type ??
                                                    "")
                                            .then((value) {
                                          context.popScreen();
                                          context.popScreen();
                                        });
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    label: const EasyText(
                                      text: 'Delete',
                                      fontColor: Colors.red,
                                    )),
                              ))
              ],
            ),
    );
  }
}

class DeleteAndPrintView extends StatelessWidget {
  const DeleteAndPrintView(
      {super.key,
      required this.deleteFunction,
      required this.printFunction,
      this.isDeleted = false});

  final Function() deleteFunction;
  final Function() printFunction;
  final bool isDeleted;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: kAs50x,
      color: kWhiteColor,
      width: getWidth(context),
      child: Row(
        children: [
          const SizedBox(
            width: kAs20x,
          ),
          isDeleted
              ? const SizedBox()
              : Expanded(
                  child: TextButton.icon(
                      style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(kBr10x),
                      )),
                      onPressed: deleteFunction,
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      label: const EasyText(
                        text: 'Delete',
                        fontColor: Colors.red,
                      )),
                ),
          isDeleted
              ? const SizedBox()
              : const SizedBox(
                  width: kAs10x,
                ),
          Expanded(
            child: ElevatedButton.icon(
                onPressed: printFunction,
                icon: const Icon(Icons.print),
                label: const Text('Print')),
          ),
          const SizedBox(
            width: kAs20x,
          ),
        ],
      ),
    );
  }
}
