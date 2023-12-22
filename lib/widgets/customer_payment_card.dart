import 'package:flutter/material.dart';
import 'package:desktop_test/constant/color.dart';
import 'package:desktop_test/data/vms/customer_payment/customer_payment.dart';
import 'package:desktop_test/provider/customer_provider.dart';
import 'package:desktop_test/utils/extension.dart';
import 'package:desktop_test/widgets/easy_button.dart';
import 'package:desktop_test/widgets/easy_text.dart';
import 'package:desktop_test/widgets/reuse_card_item.dart';
import 'package:provider/provider.dart';

import '../constant/dimen.dart';
import 'easy_text_field.dart';

class CustomerPaymentCard extends StatelessWidget {
  const CustomerPaymentCard(
      {super.key, required this.customerPayment, this.isReport = false});

  final CustomerPayment customerPayment;
  final bool isReport;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.responsive(getWidth(context), lg: 370, md: 350),
      padding: const EdgeInsets.all(kAs20x),
      margin: const EdgeInsets.only(bottom: kAs10x),
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(kBr10x),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EasyText(text: customerPayment.paymentVno ?? ''),
          ItemViewComponent(
              gram: customerPayment.gram ?? 0,
              kyat: customerPayment.kyat ?? 0,
              pae: customerPayment.pae ?? 0,
              yawe: customerPayment.yawe ?? 0),
          const SizedBox(
            height: kAs10x,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  height: kAs50x,
                  child: EasyText(
                    text: customerPayment.customerName ?? '',
                    fontSize: kFs14x,
                  )),
              isReport
                  ? const SizedBox()
                  : customerPayment.deleteBy != null
                      ? const SizedBox()
                      : EasyButton(
                          height: kAs45x,
                          width: kAs100x,
                          label: 'Delete',
                          isNotIcon: true,
                          onPressed: () {
                            context
                                .read<CustomerProvider>()
                                .remarkCustomerPayment
                                .clear();
                            context.showWarningDialog(context,
                                warningText: "Are you sure to delete?",
                                textLeft: 'Cancel',
                                bottom: EasyTextField(
                                    controller: context
                                        .read<CustomerProvider>()
                                        .remarkCustomerPayment,
                                    hintText: 'Enter remark'),
                                textRight: 'Yes', onTextRight: () async {
                              final customerProvider =
                                  context.read<CustomerProvider>();
                              await customerProvider.deleteCustomerPayment(
                                  customerPayment.paymentVno ?? '');
                              await customerProvider.getTodayStatementReport();
                              // ignore: use_build_context_synchronously
                              // ignore: use_build_context_synchronously
                              context.popScreen();
                            });
                          },
                        ),
            ],
          )
        ],
      ),
    );
  }
}
