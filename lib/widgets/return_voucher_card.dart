import 'package:flutter/material.dart';
import 'package:desktop_test/data/vms/return_voucher/return_voucher.dart';
import 'package:desktop_test/utils/extension.dart';
import 'package:desktop_test/widgets/reuse_card_item.dart';

import '../constant/assets.dart';
import '../constant/color.dart';
import '../constant/dimen.dart';
import '../pages/voucher_page_components/voucher_details.dart';
import 'easy_button.dart';
import 'easy_text.dart';

class ReturnVoucherCard extends StatelessWidget {
  const ReturnVoucherCard(
      {super.key, required this.returnVoucher, this.isReport = false});

  final ReturnVoucherVM returnVoucher;
  final bool isReport;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.responsive(getWidth(context), lg: 370, md: 350),
      padding: const EdgeInsets.all(kAs10x),
      margin: const EdgeInsets.only(bottom: kAs10x),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 3,
              offset: const Offset(0, 0.9))
        ],
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(kBr10x),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              EasyText(
                text: returnVoucher.returnVno ?? '',
                fontFamily: roboto,
                fontSize: kFs12x,
              ),
              const EasyText(
                text: ' ● ',
                fontColor: kSecondaryTextColor,
                fontSize: kFs10x,
              ),
              const EasyText(
                text: ' Bangle',
                fontSize: kFs12x,
                fontFamily: roboto,
              ),
              const Spacer(),
              EasyQty(
                text: (returnVoucher.totalQty ?? 0).toString(),
              )
            ],
          ),
          EasyText(
            text: returnVoucher.customerId ?? '',
            fontSize: kFs14x,
            fontFamily: roboto,
          ),
          ItemViewComponent(
            gram: returnVoucher.totalGram ?? 0,
            kyat: returnVoucher.kyat16 ?? 0,
            pae: returnVoucher.pae16 ?? 0,
            yawe: returnVoucher.yawe16 ?? 0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ((returnVoucher.totalWasteKyat == null ||
                              returnVoucher.totalWasteKyat == 0) &&
                          (returnVoucher.totalWastePae == null ||
                              returnVoucher.totalWastePae == 0) &&
                          returnVoucher.totalWasteYawe == null ||
                      returnVoucher.totalWasteYawe == 0)
                  ? const SizedBox()
                  : RichText(
                      text: TextSpan(children: [
                      TextSpan(
                          text:
                              '${returnVoucher.totalWasteKyat! < 1 ? "" : "${returnVoucher.totalWasteKyat}K "}'
                              '${returnVoucher.totalWastePae! < 1 ? "" : "${returnVoucher.totalWastePae}P"}'
                              '${returnVoucher.totalWasteYawe! < 1 ? "" : '${returnVoucher.totalWasteYawe!.toStringAsFixed(2)}Y'}',
                          style: const TextStyle(
                              fontSize: kFs16x,
                              color: kPrimaryTextColor,
                              fontFamily: roboto)),
                      const TextSpan(
                          text: '    waste',
                          style: TextStyle(
                              fontSize: kFs12x,
                              color: kSecondaryTextColor,
                              fontFamily: roboto))
                    ])),
              EasyButton(
                height: kAs30x,
                width: kAs170x,
                label: 'Voucher Details',
                onPressed: () async {
                  context.pushScreen(VoucherDetail(
                    isReport: isReport,
                    returnVoucherVM: returnVoucher,
                    isSale: false,
                  ));
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
