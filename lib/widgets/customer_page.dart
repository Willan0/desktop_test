import 'package:flutter/material.dart';
import 'package:desktop_test/constant/color.dart';
import 'package:desktop_test/data/vms/user/user.dart';
import 'package:desktop_test/pages/profile_page_components/customer_detail_page.dart';
import 'package:desktop_test/provider/return_voucher_provider.dart';
import 'package:desktop_test/provider/sale_voucher_provider.dart';
import 'package:desktop_test/provider/customer_provider.dart';
import 'package:desktop_test/utils/extension.dart';
import 'package:desktop_test/widgets/bottom_sheet_indicator.dart';
import 'package:desktop_test/widgets/center_column_widget.dart';
import 'package:desktop_test/widgets/customer_card.dart';
import 'package:desktop_test/widgets/easy_button.dart';
import 'package:desktop_test/widgets/easy_sliver_app_bar.dart';
import 'package:desktop_test/widgets/easy_text.dart';
import 'package:desktop_test/widgets/easy_text_field.dart';
import 'package:provider/provider.dart';

import '../constant/dimen.dart';

class CustomerPage extends StatefulWidget {
  const CustomerPage(
      {super.key,
      this.isSale = true,
      this.isCreate = true,
      this.isPayment = false});

  final bool isSale;
  final bool isCreate;
  final bool isPayment;

  @override
  State<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  late CustomerProvider _customerProvider;
  bool _isInitialized = false;
  List<UserVM>? _customers;
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    _customerProvider = context.watch<CustomerProvider>();
    if (!_isInitialized) {
      await _customerProvider.getCustomers();
    }
    _customers = _customerProvider.isFiltered
        ? _customerProvider.filteredCustomers
        : _customerProvider.customers;
  }

  @override
  Widget build(BuildContext context) {
    _isInitialized = true;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: kBackGroundColor,
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            EasySliverAppBar(
              textEditingController: _customerProvider.customerSearchController,
              title: widget.isPayment
                  ? "Create Customer Payment"
                  : widget.isCreate
                      ? 'Choose Customer'
                      : "Customers",
              expandedHeight: kAs120x,
              hintText: 'Search Customer',
              leading: true,
              onChange: (value) {
                _customerProvider.filterCustomersLocal();
              },
            )
          ],
          body: Column(
            children: [
              _customers == null
                  ? Expanded(child: context.showLoading())
                  : (_customers!.isEmpty)
                      ? const CenterColumnWidget(
                          widget: EasyText(
                            text: "There is no customers",
                            fontSize: kFs16x,
                          ),
                        )
                      : Expanded(
                          child: context.responsive(
                              ListView.builder(
                                  controller: _customerProvider
                                      .customerScrollController,
                                  itemCount: _customers!.length,
                                  itemBuilder: (context, index) {
                                    return CustomerCard(
                                      onTap: () {
                                        if (widget.isPayment) {
                                          _customerProvider.setSelect(index);
                                          _showModelBottomSheet(index);
                                        } else if (widget.isCreate) {
                                          _customerProvider.setSelect(index);
                                        } else {
                                          context.pushScreen(CustomerDetailPage(
                                            customer: _customers![index],
                                          ));
                                        }
                                      },
                                      customerVM: _customers![index],
                                    );
                                  }),
                              lg: Padding(
                                padding: const EdgeInsets.only(right: kAs20x),
                                child: GridView.builder(
                                  controller: _customerProvider
                                      .customerScrollController,
                                  itemCount: _customers!.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          childAspectRatio: 2.4),
                                  itemBuilder: (context, index) => CustomerCard(
                                      onTap: () {
                                        if (widget.isPayment) {
                                          _customerProvider.setSelect(index);
                                          _showModelBottomSheet(index);
                                        } else if (widget.isCreate) {
                                          _customerProvider.setSelect(index);
                                        } else {
                                          context.pushScreen(CustomerDetailPage(
                                            customer: _customers![index],
                                          ));
                                        }
                                      },
                                      customerVM: _customers![index]),
                                ),
                              ),
                              md: Padding(
                                padding: const EdgeInsets.only(right: kAs20x),
                                child: GridView.builder(
                                  controller: _customerProvider
                                      .customerScrollController,
                                  itemCount: _customers!.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          childAspectRatio: 2.3),
                                  itemBuilder: (context, index) => CustomerCard(
                                      onTap: () {
                                        if (widget.isPayment) {
                                          _customerProvider.setSelect(index);
                                          _showModelBottomSheet(index);
                                        } else if (widget.isCreate) {
                                          _customerProvider.setSelect(index);
                                        } else {
                                          context.pushScreen(CustomerDetailPage(
                                            customer: _customers![index],
                                          ));
                                        }
                                      },
                                      customerVM: _customers![index]),
                                ),
                              )),
                        ),
              widget.isPayment
                  ? const SizedBox()
                  : widget.isCreate
                      ? Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: kAs20x),
                          child: EasyButton(
                            label: 'OK',
                            onPressed: () {
                              _customerProvider.chooseCustomer();
                              context.popScreen();
                              widget.isSale
                                  ? context
                                      .read<SaleVoucherProvider>()
                                      .getSelectedCustomer()
                                  : context
                                      .read<ReturnVoucherProvider>()
                                      .getSelectedCustomer();
                            },
                            isNotIcon: true,
                            width: getWidth(context),
                          ),
                        )
                      : const SizedBox(),
              widget.isPayment
                  ? const SizedBox()
                  : widget.isCreate
                      ? const SizedBox(
                          height: kAs10x,
                        )
                      : const SizedBox()
            ],
          ),
        ),
        floatingActionButton: widget.isCreate
            ? const SizedBox()
            : FloatingActionButton(
                onPressed: () {
                  _customerProvider.customerSearchController.clear();
                  context.pushScreen(const CustomerPage(
                    isPayment: true,
                  ));
                },
                child: const Icon(Icons.add),
              ),
      ),
    );
  }

  _showModelBottomSheet(int index) {
    _customerProvider.setPayWithGold = false;
    _customerProvider.setDiscount = false;

    // _customerProvider.goldPriceController.clear();
    _customerProvider.getGoldPrices();
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => Form(
        key: _customerProvider.formKey,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: kAs20x),
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
                children: [
                  const SizedBox(
                    height: kAs5x,
                  ),
                  const BottomSheetIndicator(),
                  const SizedBox(
                    height: kAs10x,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      EasyText(
                        text: _customers![index].fullName ?? '',
                        fontSize: kFs18x,
                        fontWeight: FontWeight.bold,
                      ),
                      EasyText(
                        text:
                            'Balance : ${_customers![index].balance!.toString().separateMoney()}',
                        fontColor: (_customers![index].balance ?? '')
                                .toString()
                                .startsWith("0")
                            ? kPrimaryTextColor
                            : (_customers![index].balance ?? '')
                                    .toString()
                                    .startsWith("-")
                                ? Colors.greenAccent
                                : Colors.redAccent,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: kAs10x,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Selector<CustomerProvider, bool>(
                        selector: (_, provider) => provider.isPayWithGold,
                        builder: (context, isPayWithGold, child) => Checkbox(
                          value: _customerProvider.isPayWithGold,
                          onChanged: (value) {
                            _customerProvider.checkPayWithGoldOrNot();
                          },
                        ),
                      ),
                      const SizedBox(
                        width: kAs10x,
                      ),
                      const EasyText(
                        text: 'Pay with gold',
                        fontSize: kFs16x,
                      ),
                      const SizedBox(
                        width: kAs10x,
                      ),
                      Selector<CustomerProvider, bool>(
                        selector: (_, provider) => provider.isDiscount,
                        builder: (context, isPayWithGold, child) => Checkbox(
                          value: _customerProvider.isDiscount,
                          onChanged: (value) {
                            _customerProvider.checkIsDiscountOrNot();
                          },
                        ),
                      ),
                      const EasyText(
                        text: 'Discount',
                        fontSize: kFs16x,
                      ),
                    ],
                  ),

                  /// Gold Price
                  CustomerPageViewItem(
                      text: 'Gold Price',
                      widget: EasyTextField(
                        controller: _customerProvider.goldPriceController,
                        hintText: 'Enter Gold Price',
                        inputType: TextInputType.number,
                        validator: (value) {
                          if (value?.isEmpty ?? false) {
                            return "GoldPrice is empty";
                          }
                          if (value!.contains('.')) {
                            return "GoldPrice can't be decimal";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          _customerProvider.setGoldPriceManually();
                          _customerProvider.formKey.currentState?.validate();
                        },
                      )),
                  const SizedBox(
                    height: kAs10x,
                  ),

                  /// total amt
                  CustomerPageViewItem(
                      text: 'Total Amount',
                      widget: EasyTextField(
                          inputType: const TextInputType.numberWithOptions(
                              decimal: true),
                          controller:
                              _customerProvider.totalAmtPaymentController,
                          onChanged: (value) {
                            _customerProvider.changeTotalAmtToGramAndKYP();
                            _customerProvider.formKey.currentState?.validate();
                          },
                          validator: (value) =>
                              _validate("Total Amount is empty", value ?? ''),
                          hintText: "Enter Total Amount")),
                  const SizedBox(
                    height: kAs10x,
                  ),

                  /// gram
                  CustomerPageViewItem(
                      text: "Gram",
                      widget: EasyTextField(
                          // inputType: TextInputType.number,
                          isReadOnly: true,
                          // onChanged: (v) {
                          //   _customerProvider
                          //       .changeGramToKyatPaeYaweAndTotalAmt();
                          //   _customerProvider.formKey.currentState!.validate();
                          // },
                          // validator: (value)=>  _validate("Gram is empty",value ?? '' ),
                          controller: _customerProvider.gramPaymentController,
                          hintText: "Enter Gram")),
                  const SizedBox(
                    height: kAs10x,
                  ),

                  /// k/p/y
                  CustomerPageViewItem(
                      text: 'K/P/Y',
                      widget: Row(
                        children: [
                          Expanded(
                              child: EasyTextField(
                                  inputType: TextInputType.number,
                                  onChanged: (v) {
                                    _customerProvider
                                        .changeKyatPaeYaweToGramAndTotalAmt();
                                    _customerProvider.formKey.currentState
                                        ?.validate();
                                  },
                                  validator: (value) {
                                    if (value?.isEmpty ?? false) {
                                      return "kyat is Empty";
                                    }
                                    if (value!.contains(".") ||
                                        value.contains("+") ||
                                        value.contains("-")) {
                                      return "Only integer is supported";
                                    }
                                    return null;
                                  },
                                  controller:
                                      _customerProvider.kyatPaymentController,
                                  hintText: "Enter Kyat")),
                          const SizedBox(
                            width: kAs5x,
                          ),
                          Expanded(
                              child: EasyTextField(
                                  inputType: TextInputType.number,
                                  onChanged: (v) {
                                    if (v.textToNum() > 16) {
                                      context.showSimpleWarningDialog(context,
                                          "Pae can't be greater than 16");
                                      _customerProvider.paePaymentController
                                          .clear();
                                    }
                                    _customerProvider
                                        .changeKyatPaeYaweToGramAndTotalAmt();
                                    _customerProvider.formKey.currentState
                                        ?.validate();
                                  },
                                  validator: (value) {
                                    if (value?.isEmpty ?? false) {
                                      // return null;
                                      return "Pae is Empty";
                                    }
                                    if (value!.contains(".") ||
                                        value.contains("+") ||
                                        value.contains("-")) {
                                      return "Only integer is supported";
                                    }
                                    return null;
                                  },
                                  controller:
                                      _customerProvider.paePaymentController,
                                  hintText: "Enter Pae")),
                          const SizedBox(
                            width: kAs5x,
                          ),
                          Expanded(
                              child: EasyTextField(
                                  inputType: TextInputType.number,
                                  onChanged: (v) {
                                    if (v.textToNum() > 8) {
                                      context.showSimpleWarningDialog(context,
                                          "Yawe can't be greater than 8");
                                      _customerProvider.yawePaymentController
                                          .clear();
                                    }
                                    _customerProvider
                                        .changeKyatPaeYaweToGramAndTotalAmt();
                                    _customerProvider.formKey.currentState
                                        ?.validate();
                                  },
                                  validator: (value) {
                                    if (value?.isEmpty ?? false) {
                                      // return null;
                                      return "Yawe is Empty";
                                    }
                                    if (!RegExp(r'^\d+(\.\d{0,2})?$')
                                        .hasMatch(value!)) {
                                      return "only two decimal are allowed";
                                    }
                                    return null;
                                  },
                                  controller:
                                      _customerProvider.yawePaymentController,
                                  hintText: "Enter Yawe")),
                        ],
                      )),
                  const SizedBox(
                    height: kAs10x,
                  ),

                  EasyButton(
                    width: getWidth(context),
                    label: "Create",
                    isNotIcon: true,
                    onPressed: () {
                      if (_customerProvider.formKey.currentState?.validate() ??
                          false) {
                        _customerProvider.remarkForCreatingCustomerPayment
                            .clear();
                        context.showWarningDialog(context,
                            warningText: "Create Customer Payment",
                            textRight: "Yes",
                            bottom: EasyTextField(
                                controller: _customerProvider
                                    .remarkForCreatingCustomerPayment,
                                hintText: "Enter remark"),
                            onTextRight: () async {
                          context.showLoadingDialog();
                          await _customerProvider
                              .createCustomerPayment(_customers![index])
                              .then((value) {
                            context.popScreen();
                            context.popScreen();
                            context.popScreen();
                            context.popScreen();
                          });
                          await _customerProvider.getCustomers();
                        });
                      }
                    },
                  ),
                  const SizedBox(
                    height: kAs10x,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ).then((value) => _customerProvider.cancelSelect());
  }

  _validate(String errorMessage, String value) {
    if (value.isEmpty) {
      return errorMessage;
    }
    if (value.contains('.')) {
      return "Total Amount can't be decimal";
    }
    return null;
  }
}

class CustomerPageViewItem extends StatelessWidget {
  const CustomerPageViewItem(
      {super.key, required this.text, required this.widget});
  final String text;
  final Widget widget;
  @override
  Widget build(BuildContext context) {
    return context.responsive(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EasyText(
              text: text,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(
              height: kAs10x,
            ),
            widget
          ],
        ),
        lg: Row(
          children: [
            Expanded(
                flex: 1,
                child: EasyText(
                  text: text,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(
              width: kAs10x,
            ),
            Expanded(flex: 10, child: widget),
          ],
        ),
        md: Row(
          children: [
            Expanded(
                flex: 1,
                child: EasyText(
                  text: text,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(
              width: kAs10x,
            ),
            Expanded(flex: 6, child: widget),
          ],
        ));
  }
}
