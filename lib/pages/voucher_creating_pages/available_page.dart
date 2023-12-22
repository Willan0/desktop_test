// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:desktop_test/constant/color.dart';
import 'package:desktop_test/data/vms/issue_stock/issue_stock_vm.dart';
import 'package:desktop_test/provider/sale_voucher_provider.dart';
import 'package:desktop_test/provider/return_voucher_provider.dart';
import 'package:desktop_test/provider/transfer_voucher_provider.dart';
import 'package:desktop_test/utils/extension.dart';
import 'package:desktop_test/widgets/bottom_sheet_indicator.dart';
import 'package:desktop_test/widgets/easy_button.dart';
import 'package:desktop_test/widgets/easy_sliver_app_bar.dart';
import 'package:desktop_test/widgets/issue_card.dart';
import 'package:provider/provider.dart';

import '../../constant/dimen.dart';
import '../../data/vms/issue_stock/item_waste_vm.dart';
import '../../data/vms/issue_stock/main_stock.dart';
import '../../view_items/available_view_item.dart';
import '../../widgets/easy_text.dart';
import '../../widgets/main_stock_card.dart';

class AvailablePage extends StatefulWidget {
  const AvailablePage(
      {super.key, this.isSale = false, this.isTransfer = false});

  final bool isSale;
  final bool isTransfer;

  @override
  State<AvailablePage> createState() => _AvailablePageState();
}

class _AvailablePageState extends State<AvailablePage> {
  bool isSale = false;
  bool _isInitialized = false;
  bool _isLoading = true;
  bool isTransfer = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late SaleVoucherProvider _saleVoucherProvider;
  late ReturnVoucherProvider _returnVoucherProvider;
  late TransferVoucherProvider _transferVoucherProvider;

  List<IssueStockVM> issues = [];
  List<MainStock> mainStocks = [];

  @override
  void initState() {
    issues = [];
    _isInitialized = false;
    _isLoading = true;
    isSale = widget.isSale;
    isTransfer = widget.isTransfer;

    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (isSale) {
      _saleVoucherProvider = context.watch<SaleVoucherProvider>();
      issues = _saleVoucherProvider.isFilter
          ? _saleVoucherProvider.filteredIssueStocks
          : _saleVoucherProvider.issues ?? [];
    } else if (isTransfer) {
      _transferVoucherProvider = context.watch<TransferVoucherProvider>();
      issues = _transferVoucherProvider.isFilter
          ? _transferVoucherProvider.filteredIssueList
          : _transferVoucherProvider.issuesList ?? [];
    } else {
      _returnVoucherProvider = context.watch<ReturnVoucherProvider>();
      mainStocks = _returnVoucherProvider.isFilter
          ? _returnVoucherProvider.filteredMainStocks
          : _returnVoucherProvider.mainStocks ?? [];
    }

    if (!_isInitialized) {
      isSale
          ? _loadDataForSale()
          : isTransfer
              ? _loadDataForTransfer()
              : _loadDataForReturn();
    }

    super.didChangeDependencies();
  }

  void _loadDataForSale() async {
    _saleVoucherProvider.searchController.clear();
    await _saleVoucherProvider.getIssues();
    _isLoading = false;
  }

  void _loadDataForTransfer() async {
    _transferVoucherProvider.searchController.clear();
    await _transferVoucherProvider.getIssues();
    _isLoading = false;
  }

  void _loadDataForReturn() async {
    _returnVoucherProvider.searchTextController.clear();
    await _returnVoucherProvider.getMainStock();
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    _isInitialized = true;
    return Scaffold(
      backgroundColor: kBackGroundColor,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          EasySliverAppBar(
            title: isSale
                ? 'Available Sale Items'
                : isTransfer
                    ? "Available Transfer Items "
                    : 'Available Main Stocks',
            hintText: 'Type GGL code or name...',
            leading: true,
            textEditingController: isSale
                ? _saleVoucherProvider.searchController
                : isTransfer
                    ? _transferVoucherProvider.searchController
                    : _returnVoucherProvider.searchTextController,
            expandedHeight: kAs120x,
            onChange: (value) {
              isSale
                  ? _saleVoucherProvider.filterIssueStock()
                  : isTransfer
                      ? _transferVoucherProvider.filterIssuesStock()
                      : _returnVoucherProvider.filterMainStocks();
            },
          )
        ],
        body: _isLoading
            ? context.showLoading()
            : isSale || isTransfer
                ? issues.isEmpty
                    ? const Center(
                        child: EasyText(
                          text: "There is no issue stocks",
                          fontSize: kFs16x,
                        ),
                      )
                    : context.responsive(
                        ListView.builder(
                            controller: isSale
                                ? _saleVoucherProvider.availableSaleController
                                : _transferVoucherProvider
                                    .transferScrollController,
                            itemCount: issues.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    issues[index].isSelect = true;
                                  });
                                  isTransfer
                                      ? _transferVoucherProvider.clearText()
                                      : _saleVoucherProvider.clearText();
                                  _buildDialogForSelectedAvailablePage(
                                          context, index)
                                      .then((value) {
                                    if (mounted) {
                                      setState(() {
                                        issues[index].isSelect = false;
                                      });
                                    }
                                  });
                                },
                                child: IssueStocksCard(
                                  issue: issues[index],
                                ),
                              );
                            }),
                        lg: Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: kAs20x),
                          child: GridView.builder(
                              controller: isSale
                                  ? _saleVoucherProvider.availableSaleController
                                  : _transferVoucherProvider
                                      .transferScrollController,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisSpacing: kAs20x,
                                      childAspectRatio: 1.8,
                                      crossAxisCount: 3),
                              itemCount: isSale || isTransfer
                                  ? issues.length
                                  : mainStocks.length,
                              itemBuilder: (context, index) => GestureDetector(
                                  onTap: () {
                                    if (mounted) {
                                      setState(() {
                                        issues[index].isSelect = true;
                                      });
                                    }
                                    isTransfer
                                        ? _transferVoucherProvider.clearText()
                                        : _saleVoucherProvider.clearText();
                                    _buildDialogForSelectedAvailablePage(
                                            context, index)
                                        .then((value) {
                                      if (mounted) {
                                        setState(() {
                                          issues[index].isSelect = false;
                                        });
                                      }
                                    });
                                  },
                                  child: IssueStocksCard(
                                    issue: issues[index],
                                  ))),
                        ),
                        md: Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: kAs20x),
                          child: GridView.builder(
                              controller: isSale
                                  ? _saleVoucherProvider.availableSaleController
                                  : _transferVoucherProvider
                                      .transferScrollController,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisSpacing: kAs20x,
                                      childAspectRatio: 1.72,
                                      crossAxisCount: 2),
                              itemCount: issues.length,
                              itemBuilder: (context, index) => GestureDetector(
                                  onTap: () {
                                    if (mounted) {
                                      setState(() {
                                        issues[index].isSelect = true;
                                      });
                                    }
                                    isTransfer
                                        ? _transferVoucherProvider.clearText()
                                        : _saleVoucherProvider.clearText();
                                    _buildDialogForSelectedAvailablePage(
                                            context, index)
                                        .then((value) {
                                      if (mounted) {
                                        setState(() {
                                          issues[index].isSelect = false;
                                        });
                                      }
                                    });
                                  },
                                  child: IssueStocksCard(
                                    issue: issues[index],
                                  ))),
                        ))
                : mainStocks.isEmpty
                    ? const Center(
                        child: EasyText(text: "There is no main stocks"),
                      )
                    : context.responsive(
                        ListView.builder(
                            controller: _returnVoucherProvider
                                .availableReturnScrollController,
                            itemCount: mainStocks.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  if (mounted) {
                                    setState(() {
                                      mainStocks[index].isSelect = true;
                                    });
                                  }
                                  _returnVoucherProvider.clearText();
                                  _buildDialogForSelectedAvailablePage(
                                          context, index)
                                      .then((value) {
                                    if (mounted) {
                                      setState(() {
                                        mainStocks[index].isSelect = false;
                                      });
                                    }
                                  });
                                },
                                child: MainStocksCard(
                                    mainStock: mainStocks[index]),
                              );
                            }),
                        lg: Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: kAs20x),
                          child: GridView.builder(
                              controller: _returnVoucherProvider
                                  .availableReturnScrollController,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisSpacing: kAs20x,
                                      childAspectRatio: 2.2,
                                      crossAxisCount: 3),
                              itemCount: mainStocks.length,
                              itemBuilder: (context, index) => GestureDetector(
                                    onTap: () {
                                      if (mounted) {
                                        setState(() {
                                          mainStocks[index].isSelect = true;
                                        });
                                      }
                                      _returnVoucherProvider.clearText();
                                      _buildDialogForSelectedAvailablePage(
                                              context, index)
                                          .then((value) {
                                        if (mounted) {
                                          setState(() {
                                            mainStocks[index].isSelect = false;
                                          });
                                        }
                                      });
                                    },
                                    child: MainStocksCard(
                                        mainStock: mainStocks[index]),
                                  )),
                        ),
                        md: Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: kAs20x),
                          child: GridView.builder(
                              controller: _returnVoucherProvider
                                  .availableReturnScrollController,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisSpacing: kAs20x,
                                      childAspectRatio: 2,
                                      crossAxisCount: 2),
                              itemCount: mainStocks.length,
                              itemBuilder: (context, index) => GestureDetector(
                                    onTap: () {
                                      if (mounted) {
                                        setState(() {
                                          mainStocks[index].isSelect = true;
                                        });
                                      }
                                      _returnVoucherProvider.clearText();
                                      _buildDialogForSelectedAvailablePage(
                                              context, index)
                                          .then((value) {
                                        if (mounted) {
                                          setState(() {
                                            mainStocks[index].isSelect = false;
                                          });
                                        }
                                      });
                                    },
                                    child: MainStocksCard(
                                        mainStock: mainStocks[index]),
                                  )),
                        )),
      ),
    );
  }

  Future<void> _buildDialogForSelectedAvailablePage(
      BuildContext context, int index) {
    isSale
        ? _saleVoucherProvider
            .showSelectedGoldPrice(issues[index].stateId ?? '')
        : isTransfer
            ? const SizedBox()
            : _returnVoucherProvider
                .showSelectedGoldPrice(mainStocks[index].stateId ?? '');
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(kAs20x),
              decoration: const BoxDecoration(
                  color: kWhiteColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(kBr20x),
                      topRight: Radius.circular(kBr20x))),
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const BottomSheetIndicator(),
                    const SizedBox(
                      height: kAs20x,
                    ),

                    isSale
                        ? EasyText(
                            text:
                                "Gold Price : ${(_saleVoucherProvider.goldPrice).toString().separateMoney()}",
                            fontSize: kFs16x,
                            fontWeight: FontWeight.normal,
                          )
                        : const SizedBox(),

                    SizedBox(
                      height: isSale ? kAs10x : 0,
                    ),
                    isTransfer
                        ? OneTextFieldRow(
                            textEditingController:
                                _transferVoucherProvider.qTextController,
                            header: "Quantity",
                            hintText: "Enter Quantity",
                            onChanged: (value) {
                              _formKey.currentState?.validate();
                              _saleVoucherProvider
                                  .calculateAndShowTotalAmount();
                            },
                            validator: (value) => _quantityValidate(
                                value, issues[index].qty ?? 0),
                          )
                        : TwoTextFieldRow(
                            header: "Quantity/ \n Gram",
                            firstHintText: "Enter Quantity",
                            secondHintText: "Enter Gram",
                            firstController: isSale
                                ? _saleVoucherProvider.quantityController
                                : _returnVoucherProvider.quantityTextController,
                            secondController: isSale
                                ? _saleVoucherProvider.gramController
                                : _returnVoucherProvider.gramTextController,
                            firstValidate: (value) => _quantityValidate(
                                value, !isSale ? 0 : issues[index].qty ?? 0),
                            firstOnChange: (value) {
                              if (isSale) {
                                List<ItemWasteVM> itemWastes =
                                    issues[index].itemWasteList ?? [];
                                if (value!.contains('.') ||
                                    value.contains('-') ||
                                    value.contains('+') ||
                                    value.contains('#') ||
                                    value.contains('\$')) {
                                  context.showSimpleWarningDialog(
                                      context, "Only integer are allowed");
                                  _saleVoucherProvider.quantityController
                                      .clear();
                                  _saleVoucherProvider.wKController.clear();
                                  _saleVoucherProvider.wPController.clear();
                                  _saleVoucherProvider.wYController.clear();
                                } else if (_saleVoucherProvider
                                    .checkInsufficientQuantityOrNot(
                                        int.parse(
                                            value == "" ? "0" : value.trim()),
                                        issues[index].qty ?? 0)) {
                                  _saleVoucherProvider
                                      .autoFillWasteDependOnQuantity(
                                          int.parse(
                                              value == "" ? "0" : value.trim()),
                                          itemWastes);
                                  _saleVoucherProvider
                                      .calculateAndShowTotalAmount();
                                } else {
                                  context.showSimpleWarningDialog(
                                      context, 'Insufficient Quantity');
                                  _saleVoucherProvider.quantityController
                                      .clear();
                                  _saleVoucherProvider.wKController.clear();
                                  _saleVoucherProvider.wPController.clear();
                                  _saleVoucherProvider.wYController.clear();
                                }
                              } else {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  _returnVoucherProvider
                                      .calculateAndShowTotalAmount();
                                }
                              }
                              _formKey.currentState?.validate();
                            },
                            secondOnChange: (value) {
                              if (isSale) {
                                if (_saleVoucherProvider
                                    .checkInsufficientGramOrNot(
                                        issues[index].gram ?? 0)) {
                                  _saleVoucherProvider.changeGramToGoldWeight();
                                  _formKey.currentState?.validate();
                                  _saleVoucherProvider
                                      .calculateAndShowTotalAmount();
                                } else {
                                  context.showSimpleWarningDialog(
                                      context, "Insufficient Gram");
                                  _saleVoucherProvider.kController.clear();
                                  _saleVoucherProvider.pController.clear();
                                  _saleVoucherProvider.yController.clear();
                                  _saleVoucherProvider.gramController.clear();
                                }
                              } else {
                                _returnVoucherProvider.changeGramToGoldWeight();
                                _formKey.currentState?.validate();
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  _returnVoucherProvider
                                      .calculateAndShowTotalAmount();
                                }
                              }
                            },
                            secondValidate: (value) => _gramValidate(
                                value, !isSale ? 0 : issues[index].gram ?? 0),
                            isReadMode: false,
                          ),
                    const SizedBox(
                      height: kAs10x,
                    ),

                    /// Gram
                    isTransfer
                        ? OneTextFieldRow(
                            header: "Gram",
                            hintText: "Enter Gram",
                            textEditingController:
                                _transferVoucherProvider.gramTextController,
                            onChanged: (value) {
                              _transferVoucherProvider.changeGramToGoldWeight();
                              _formKey.currentState?.validate();
                            },
                            validator: (value) =>
                                _gramValidate(value, issues[index].gram ?? 0),
                          )
                        : const SizedBox(),

                    SizedBox(
                      height: isTransfer ? kAs10x : 0,
                    ),

                    /// K/ P /Y
                    isSale
                        ? KyatPaeYaweItemView(
                            kController: _saleVoucherProvider.kController,
                            yController: _saleVoucherProvider.yController,
                            pController: _saleVoucherProvider.pController,
                            onChange: (value) {
                              if (_saleVoucherProvider.checkDoubleOrInteger()) {
                                _saleVoucherProvider.changeGoldWeightToGram();
                                _formKey.currentState?.validate();
                                _saleVoucherProvider
                                    .calculateAndShowTotalAmount();
                                if (!_saleVoucherProvider
                                    .checkInsufficientGramOrNot(
                                        issues[index].gram ?? 0)) {
                                  context.showSimpleWarningDialog(
                                      context, "Insufficient Gram");
                                }
                              } else {
                                context.showSimpleWarningDialog(context,
                                    'Only Integer are supported for kyat and pae');
                              }
                            },
                          )
                        : isTransfer
                            ? KyatPaeYaweItemView(
                                kController:
                                    _transferVoucherProvider.kTextController,
                                pController:
                                    _transferVoucherProvider.pTextController,
                                yController:
                                    _transferVoucherProvider.yTextController,
                                onChange: (value) {
                                  _transferVoucherProvider
                                      .changeGoldWeightToGram();
                                  _formKey.currentState?.validate();
                                })
                            : KyatPaeYaweItemView(
                                kController:
                                    _returnVoucherProvider.kTextController,
                                yController:
                                    _returnVoucherProvider.yTextController,
                                pController:
                                    _returnVoucherProvider.pTextController,
                                onChange: (v) {
                                  _returnVoucherProvider
                                      .changeGoldWeightToGram();
                                  _formKey.currentState?.validate();
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    _returnVoucherProvider
                                        .calculateAndShowTotalAmount();
                                  }
                                }),
                    const SizedBox(
                      height: kAs10x,
                    ),

                    /// Wk /Wp/ Wy
                    isSale
                        ? WasteKyatPaeYaweItemView(
                            wKController: _saleVoucherProvider.wKController,
                            wPController: _saleVoucherProvider.wPController,
                            wYController: _saleVoucherProvider.wYController,
                            onYaweValidate: (value) {
                              if (value?.isEmpty ?? false) {
                                return null;
                              }
                              if (!RegExp(r'^\d+(\.\d{0,2})?$')
                                  .hasMatch(value!)) {
                                return "only two decimal are allowed";
                              }
                              return null;
                            },
                            onChange: (value) {
                              _formKey.currentState?.validate();
                              _saleVoucherProvider
                                  .calculateAndShowTotalAmount();
                            },
                            onValidate: (value) {
                              if (value!.contains(".") ||
                                  value.contains("+") ||
                                  value.contains("-")) {
                                return "Only integer are supported";
                              }
                              return null;
                            },
                          )
                        : isTransfer
                            ? const SizedBox()
                            : WasteKyatPaeYaweItemView(
                                wKController:
                                    _returnVoucherProvider.wKTextController,
                                wYController:
                                    _returnVoucherProvider.wYTextController,
                                wPController:
                                    _returnVoucherProvider.wPTextController,
                                onYaweValidate: (value) {
                                  if (value?.isEmpty ?? false) {
                                    return null;
                                  }
                                  if (!RegExp(r'^\d+(\.\d{0,2})?$')
                                      .hasMatch(value!)) {
                                    return "only two decimal are allowed";
                                  }
                                  return null;
                                },
                                onChange: (value) {
                                  _formKey.currentState?.validate();
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    _returnVoucherProvider
                                        .calculateAndShowTotalAmount();
                                  }
                                },
                                onValidate: (value) {
                                  if (value!.contains(".") ||
                                      value.contains("+") ||
                                      value.contains("-")) {
                                    return "Only integer are supported";
                                  }
                                },
                              ),
                    const SizedBox(
                      height: kAs10x,
                    ),

                    isTransfer
                        ? const SizedBox()
                        : TwoTextFieldRow(
                            header: isSale
                                ? "Charges/\nTotal Amount"
                                : "Gold Price/\nTotal Amount",
                            firstHintText:
                                isSale ? "Enter Charges" : "Gold Price",
                            secondHintText:
                                isSale ? "GoldPrice Amount" : "Total Amount",
                            firstController: isSale
                                ? _saleVoucherProvider.chargesController
                                : _returnVoucherProvider.goldPriceController,
                            secondController: isSale
                                ? _saleVoucherProvider.goldTotalAmountController
                                : _returnVoucherProvider.totalAmountController,
                            firstValidate: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Charges is Empty';
                              }
                              if (!RegExp(r'^\d+$').hasMatch(value)) {
                                return "no integer";
                              }
                              return null;
                            },
                            firstOnChange: (value) {
                              if (isSale) _saleVoucherProvider.addCharges();
                              _formKey.currentState?.validate();
                            },
                            secondValidate: (value) => null,
                            isCharges: isSale ? false : true,
                            isReadMode: true,
                          ),
                    SizedBox(
                      height: isTransfer ? 0 : kAs10x,
                    ),

                    /// ok
                    EasyButton(
                      label: 'OK',
                      width: getWidth(context),
                      isValidate: _formKey.currentState?.validate() ?? false,
                      isNotIcon: true,
                      onPressed: () => isSale || isTransfer
                          ? _saveIssueStock(index)
                          : _saveMainStock(index),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  _quantityValidate(String? value, num maxQty) {
    if (value?.isEmpty ?? false) {
      return "Quantity is Empty";
    }
    if (!RegExp(r'^\d+$').hasMatch(value!)) {
      return "no integer";
    }
    if (maxQty == 0) {
      return null;
    }
    if (value.textToNum() > maxQty) {
      return "insufficient quantity";
    }
    return null;
  }

  _gramValidate(String? value, num maxGram) {
    if (value == null || value.isEmpty) {
      return 'Gram is Empty';
    }
    if (!RegExp(r'^\d+(\.\d{0,2})?$').hasMatch(value)) {
      return "only two decimal are allowed";
    }
    if (maxGram == 0) {
      return null;
    }
    if (value.textToNum() > maxGram) {
      return "insufficient gram";
    }
    return null;
  }

  void _saveIssueStock(int index) async {
    if (_formKey.currentState?.validate() ?? false) {
      context.showLoadingDialog();
      isSale
          ? await _saleVoucherProvider.saveSelectedIssues(issues[index])
          : _transferVoucherProvider.saveSelectedIssues(issues[index]);
      context.popScreen();
      context.popScreen();
      context.popScreen();
      isSale
          ? await _saleVoucherProvider.getSelectedIssues()
          : await _transferVoucherProvider.getSelectedIssues();
    }
  }

  Future<void> _saveMainStock(int index) async {
    if (_formKey.currentState?.validate() ?? false) {
      context.showLoadingDialog();
      await _returnVoucherProvider.saveSelectMainStocks(
          mainStocks[index].gglCode ?? '',
          mainStocks[index].itemName ?? '',
          mainStocks[index].stateId ?? '',
          mainStocks[index].typeName ?? '',
          mainStocks[index].stateName ?? '',
          mainStocks[index].image ?? '');
      _returnVoucherProvider.getSelectedMainStocks();
      context.popScreen();
      context.popScreen();
      context.popScreen();
    } else {}
  }
}
