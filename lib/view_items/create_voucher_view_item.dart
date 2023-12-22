// ignore_for_file: use_build_context_synchronously

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:desktop_test/data/vms/access_token/access_token.dart';
import 'package:desktop_test/data/vms/user/user.dart';
import 'package:desktop_test/persistent/daos/user_dao/access_token_dao_impl.dart';
import 'package:desktop_test/provider/customer_provider.dart';
import 'package:desktop_test/utils/extension.dart';
import 'package:desktop_test/widgets/easy_text_field.dart';
import 'package:desktop_test/widgets/issue_card.dart';
import 'package:provider/provider.dart';

import '../../data/vms/issue_stock/issue_stock_vm.dart';
import '../../utils/responsive_view.dart';
import '../../widgets/easy_button.dart';
import '../constant/assets.dart';
import '../constant/color.dart';
import '../constant/dimen.dart';
import '../data/data_apply/data_apply/gg_luck_data_apply_imp.dart';
import '../data/vms/issue_stock/main_stock.dart';
import '../data/vms/sale_voucher/total_value_vm.dart';
import '../widgets/customer_page.dart';
import '../provider/home_page_provider.dart';
import '../provider/return_voucher_provider.dart';
import '../provider/sale_voucher_provider.dart';
import '../provider/transfer_voucher_provider.dart';
import '../widgets/custom_drop_down_text_field.dart';
import '../widgets/customer_card.dart';
import '../widgets/easy_text.dart';

class ConfirmButtonView extends StatefulWidget {
  const ConfirmButtonView({
    super.key,
    required this.totalV,
    this.isSale = false,
    this.isTransfer = false,
  });

  final TotalValueVM totalV;
  final bool isSale;
  final bool isTransfer;

  @override
  State<ConfirmButtonView> createState() => _ConfirmButtonViewState();
}

class _ConfirmButtonViewState extends State<ConfirmButtonView> {
  late SaleVoucherProvider _saleVoucherProvider;
  late ReturnVoucherProvider _returnVoucherProvider;
  late TransferVoucherProvider _transferVoucherProvider;

  // bool _isInitialize = false;
  bool isCheck = false;

  @override
  void didChangeDependencies() {
    widget.isSale
        ? _saleVoucherProvider = context.watch<SaleVoucherProvider>()
        : widget.isTransfer
            ? _transferVoucherProvider =
                context.watch<TransferVoucherProvider>()
            : _returnVoucherProvider = context.watch<ReturnVoucherProvider>();
    if (!widget.isTransfer) {
      isCheck = widget.isSale
          ? _saleVoucherProvider.isHaveCustomer
          : _returnVoucherProvider.isHaveCustomer;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // _isInitialize = true;
    return Positioned(
      bottom: 10,
      left: 0,
      right: 0,
      child: Container(
        color: kWhiteColor,
        padding:
            const EdgeInsets.only(left: kAs20x, right: kAs20x, bottom: kAs10x),
        child: EasyButton(
          onPressed: widget.isTransfer
              ? _transferVoucherProvider.transferType == TransferType.wareHouse
                  ? () {
                      context.showLoadingDialog();
                      _transferVoucherProvider
                          .createTransferVoucher(widget.totalV)
                          .then((value) {
                        GgLuckDataApplyImpl().deleteSelectedCustomer();
                        GgLuckDataApplyImpl().deleteSelectedIssues();
                        _transferVoucherProvider.getIssues().then((value) {
                          context.popScreen();
                          context.popScreen();
                          context.popScreen();
                        });
                      }).catchError((e) {
                        context.popScreen();
                      });
                    }
                  : () {
                      if (_transferVoucherProvider.recepentUserId != null) {
                        context.showLoadingDialog();
                        _transferVoucherProvider
                            .createTransferVoucher(widget.totalV)
                            .then((value) {
                          GgLuckDataApplyImpl().deleteSelectedCustomer();
                          GgLuckDataApplyImpl().deleteSelectedIssues();
                          _transferVoucherProvider.getIssues().then((value) {
                            context.popScreen();
                            context.popScreen();
                            context.popScreen();
                          });
                        }).catchError((e) {
                          context.popScreen();
                        });
                      } else {
                        context.showWarningDialog(context,
                            warningText: 'Please choose marketing user',
                            textLeft: 'Ok');
                      }
                    }
              : isCheck
                  ? widget.isSale
                      ? () {
                          _saleVoucherProvider.remarkForCreatingSaleVoucher
                              .clear();
                          context.showWarningDialog(context,
                              warningText: "Create Sale Voucher",
                              bottom: EasyTextField(
                                  controller: _saleVoucherProvider
                                      .remarkForCreatingSaleVoucher,
                                  hintText: "Enter remark"),
                              textRight: "Yes", onTextRight: () async {
                            context.popScreen();
                            context.showLoadingDialog();
                            final homepageProvider =
                                context.read<HomePageProvider>();
                            await _saleVoucherProvider
                                .createSaleVoucher(widget.totalV);

                            await _saleVoucherProvider.getSaleVouchers();
                            await homepageProvider.getIssuesStocks();
                            GgLuckDataApplyImpl().deleteSelectedCustomer();
                            GgLuckDataApplyImpl().deleteSelectedIssues();
                            context.popScreen();
                            context.popScreen();
                            context.popScreen();
                          });
                        }
                      : () async {
                          _returnVoucherProvider
                              .remarkForCreatingReturnController
                              .clear();
                          context.showWarningDialog(context,
                              warningText: "Create return voucher",
                              textRight: "Yes",
                              bottom: EasyTextField(
                                  controller: _returnVoucherProvider
                                      .remarkForCreatingReturnController,
                                  hintText: "Enter remark"),
                              onTextRight: () async {
                            context.popScreen();
                            context.showLoadingDialog();
                            await _returnVoucherProvider
                                .createReturnVoucher(widget.totalV);
                            await _returnVoucherProvider.getReturnVouchers();
                            await _returnVoucherProvider
                                .deleteSelectedMainStocks();
                            context.popScreen();
                            context.popScreen();
                            context.popScreen();
                          });
                        }
                  : () {
                      context.showWarningDialog(context,
                          warningText: 'Please Select Customer',
                          textLeft: "Ok");
                    },
          label: 'Confirm',
          width: getWidth(context),
          isNotIcon: true,
        ),
      ),
    );
  }
}

class AvailableItemView extends StatelessWidget {
  const AvailableItemView({
    super.key,
    required this.isSale,
  });

  final bool isSale;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: kAs20x,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: kAs20x),
          padding: const EdgeInsets.all(kAs15x),
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.3),
              borderRadius: BorderRadius.circular(kBr10x)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EasyText(
                    text: 'Choose Customer',
                    fontFamily: roboto,
                    fontWeight: FontWeight.bold,
                    fontSize: kFs18x,
                  ),
                  SizedBox(
                    height: kAs10x,
                  ),
                  EasyText(
                    text: 'Tap here to customer with ID',
                    fontSize: kFs14x,
                    fontFamily: roboto,
                  )
                ],
              ),
              Container(
                width: kAs45x,
                height: kAs45x,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: kWhiteColor,
                ),
                child: IconButton(
                    onPressed: () {
                      context
                          .read<CustomerProvider>()
                          .customerSearchController
                          .clear();
                      context.pushScreen(CustomerPage(
                        isSale: isSale,
                      ));
                    },
                    splashColor: Colors.transparent,
                    icon: const Icon(
                      Icons.add,
                      size: kAs20x,
                      color: Colors.blue,
                    )),
              )
            ],
          ),
        ),
        const SizedBox(
          height: kAs15x,
        ),
        isSale
            ? Selector<SaleVoucherProvider, UserVM?>(
                selector: (_, provider) => provider.getCustomer,
                builder: (context, customer, child) {
                  if (customer == null) {
                    return const SizedBox();
                  }
                  customer.isSelect = false;
                  return SizedBox(
                    width: getWidth(context),
                    child: CustomerCard(
                      customerVM: customer,
                    ),
                  );
                },
              )
            : Selector<ReturnVoucherProvider, UserVM?>(
                selector: (_, provider) => provider.customer,
                builder: (context, customer, child) {
                  if (customer == null) {
                    return const SizedBox();
                  }
                  customer.isSelect = false;
                  return SizedBox(
                    width: getWidth(context),
                    child: CustomerCard(
                      customerVM: customer,
                    ),
                  );
                },
              ),
        // divider
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: kAs20x),
          child: Divider(
            color: kSecondaryTextColor,
          ),
        ),
        const SizedBox(
          height: kAs10x,
        ),
        Expanded(
            child: isSale
                ? Selector<SaleVoucherProvider, List<IssueStockVM>?>(
                    selector: (_, provider) => provider.selectedIssues,
                    builder: (context, issues, child) {
                      if (issues == null) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (issues.isEmpty) {
                        return const Center(
                          child: EasyText(text: 'There is no selected items'),
                        );
                      }
                      return context.responsive(
                          MobileListView(
                            list: issues,
                            isSelect: true,
                            isIssue: true,
                          ),
                          lg: TabletGridView(
                            list: issues,
                            isSale: true,
                            isSelect: true,
                            childAspectRatio: 1.8,
                            crossAxisCount: 3,
                            isIssue: true,
                          ),
                          md: TabletGridView(
                              list: issues,
                              isSale: true,
                              isSelect: true,
                              childAspectRatio: 1.6,
                              crossAxisCount: 2,
                              isIssue: true));
                    })
                : Selector<ReturnVoucherProvider, List<MainStock>?>(
                    selector: (_, provider) => provider.selectedMainStocks,
                    builder: (context, selectedMainStocks, child) {
                      if (selectedMainStocks == null) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (selectedMainStocks.isEmpty) {
                        return const Center(
                          child: EasyText(text: 'There is no selected items'),
                        );
                      }
                      return context.responsive(
                          MobileListView(list: selectedMainStocks),
                          lg: TabletGridView(
                            list: selectedMainStocks,
                            childAspectRatio: 2.1,
                            crossAxisCount: 3,
                          ),
                          md: TabletGridView(
                              list: selectedMainStocks,
                              childAspectRatio: 1.8,
                              crossAxisCount: 2));
                    })),
        const SizedBox(
          height: kAs150x,
        ),
      ],
    );
  }
}

enum TransferType { marketing, wareHouse }

class AvailableItemViewForTransfer extends StatelessWidget {
  const AvailableItemViewForTransfer(
      {super.key, required this.transferVoucherProvider});

  final TransferVoucherProvider transferVoucherProvider;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.responsive(0, lg: kAs20x, md: kAs20x),
      ),
      child: context.responsive(
          MobileTransferItemView(
              transferVoucherProvider: transferVoucherProvider),
          lg: TabletTransferItemView(
              transferVoucherProvider: transferVoucherProvider),
          md: TabletTransferItemView(
              transferVoucherProvider: transferVoucherProvider)),
    );
  }
}

class MobileTransferItemView extends StatelessWidget {
  const MobileTransferItemView({
    super.key,
    required this.transferVoucherProvider,
  });

  final TransferVoucherProvider transferVoucherProvider;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const SizedBox(
          height: kAs10x,
        ),
        TransferTypeChooserView(
          transferVoucherProvider: transferVoucherProvider,
        ),
        const SizedBox(
          height: kAs10x,
        ),
        transferVoucherProvider.transferType == TransferType.marketing
            ? ChooseMarketingView(
                transferVoucherProvider: transferVoucherProvider,
              )
            : const SizedBox(),
        const SizedBox(
          height: kAs10x,
        ),
        Expanded(
            child: transferVoucherProvider.selectedIssuesList == null
                ? context.showLoading()
                : transferVoucherProvider.selectedIssuesList!.isEmpty
                    ? const Center(
                        child: EasyText(text: 'There is no selected issues'),
                      )
                    : ListView.builder(
                        itemCount:
                            (transferVoucherProvider.selectedIssuesList ?? [])
                                .length,
                        itemBuilder: (context, index) => IssueStocksCard(
                            issue: transferVoucherProvider
                                .selectedIssuesList![index]),
                      )),
        SizedBox(
          height: getHeight(context) * 0.19,
        )
      ],
    );
  }
}

class TabletTransferItemView extends StatelessWidget {
  const TabletTransferItemView(
      {super.key, required this.transferVoucherProvider});
  final TransferVoucherProvider transferVoucherProvider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: context.responsive(MainAxisAlignment.start,
              lg: MainAxisAlignment.spaceBetween,
              md: MainAxisAlignment.spaceBetween),
          children: [
            transferVoucherProvider.transferType == TransferType.marketing
                ? ChooseMarketingView(
                    transferVoucherProvider: transferVoucherProvider)
                : const SizedBox(),
            SizedBox(
                width: context.responsive(getWidth(context), lg: 700, md: 500),
                child: TransferTypeChooserView(
                    transferVoucherProvider: transferVoucherProvider)),
          ],
        ),
        const SizedBox(
          height: kAs10x,
        ),
        Expanded(
            child: GridView.builder(
          itemCount: transferVoucherProvider.selectedIssuesList!.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 2.3,
              crossAxisCount: context.responsive(0, lg: 3, md: 2)),
          itemBuilder: (context, index) => IssueStocksCard(
              issue: transferVoucherProvider.selectedIssuesList![index]),
        )),
        SizedBox(
          height: getHeight(context) * 0.2,
        )
      ],
    );
  }
}

class ChooseMarketingView extends StatefulWidget {
  const ChooseMarketingView({
    super.key,
    required this.transferVoucherProvider,
  });

  final TransferVoucherProvider transferVoucherProvider;

  @override
  State<ChooseMarketingView> createState() => _ChooseMarketingViewState();
}

class _ChooseMarketingViewState extends State<ChooseMarketingView> {
  bool _isInitialize = false;
  AccessToken? accessToken = AccessTokenDaoImpl().getTokenFromDatabase();
  @override
  void didChangeDependencies() {
    if (!_isInitialize) {
      widget.transferVoucherProvider.getMarketingUsers();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    _isInitialize = true;
    return SizedBox(
      height: kAs45x,
      width: kAs200x,
      child: CustomDropDownTextField(
        hintText: "Choose Marketing",
        dropDownList: (widget.transferVoucherProvider.marketingUsers ?? [])
            .where((element) => element.userId != accessToken!.user!.id)
            .map((e) => DropDownValueModel(
                name: e.fullName ?? "", value: e.userId ?? ''))
            .toList(),
        onChange: (value) {
          if (value != null && value != "") {
            widget.transferVoucherProvider.setRecepentUserId = value.value;
          } else {
            widget.transferVoucherProvider.setRecepentUserId = "";
          }
        },
      ),
    );
  }
}

class TransferTypeChooserView extends StatelessWidget {
  const TransferTypeChooserView({
    super.key,
    required this.transferVoucherProvider,
  });

  final TransferVoucherProvider transferVoucherProvider;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: context.responsive(kAs20x, lg: 0, md: 0)),
      padding: const EdgeInsets.all(kAs5x),
      decoration: BoxDecoration(
          color: kWhiteColor, borderRadius: BorderRadius.circular(kBr10x)),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Radio(
                  value: TransferType.marketing,
                  groupValue: transferVoucherProvider.transferType,
                  onChanged: (value) {
                    transferVoucherProvider.setTransferType = value;
                  },
                ),
                const EasyText(text: 'Marketing')
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Radio(
                  value: TransferType.wareHouse,
                  groupValue: transferVoucherProvider.transferType,
                  onChanged: (value) {
                    transferVoucherProvider.setTransferType = value;
                  },
                ),
                const EasyText(text: "WareHouse")
              ],
            ),
          ),
        ],
      ),
    );
  }
}
