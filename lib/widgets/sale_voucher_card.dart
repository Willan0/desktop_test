import 'package:flutter/material.dart';
import 'package:desktop_test/data/vms/sale_voucher/sale_voucher.dart';
import 'package:desktop_test/utils/extension.dart';
import 'package:desktop_test/widgets/reuse_card_item.dart';

import '../constant/assets.dart';
import '../constant/color.dart';
import '../constant/dimen.dart';
import '../pages/voucher_page_components/voucher_details.dart';
import 'easy_button.dart';
import 'easy_text.dart';

class SaleVoucherCard extends StatelessWidget {
  const SaleVoucherCard(
      {super.key, required this.saleVoucher, this.isReport = false});

  final SaleVoucherVM saleVoucher;
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
                text: saleVoucher.saleVno ?? '',
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
                text: (saleVoucher.totalQty ?? 0).toString(),
              )
            ],
          ),
          EasyText(
            text: saleVoucher.customerName ?? '',
            fontSize: kFs14x,
            fontFamily: roboto,
          ),
          ItemViewComponent(
            gram: saleVoucher.totalGram ?? 0,
            kyat: saleVoucher.kyat16 ?? 0,
            pae: saleVoucher.pae16 ?? 0,
            yawe: saleVoucher.yawe16 ?? 0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ((saleVoucher.totalWasteKyat == null ||
                              saleVoucher.totalWasteKyat == 0) &&
                          (saleVoucher.totalWastePae == null ||
                              saleVoucher.totalWastePae == 0) &&
                          saleVoucher.totalWasteYawe == null ||
                      saleVoucher.totalWasteYawe == 0)
                  ? const SizedBox()
                  : RichText(
                      text: TextSpan(children: [
                      TextSpan(
                          text:
                              '${saleVoucher.totalWasteKyat! < 1 ? "" : '${saleVoucher.totalWasteKyat}K '}'
                              '${saleVoucher.totalWastePae! < 1 ? "" : "${saleVoucher.totalWastePae}P "}'
                              '${saleVoucher.totalWasteYawe! < 1 ? "" : '${saleVoucher.totalWasteYawe}Y'}',
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
                    saleVoucher: saleVoucher,
                    isReport: isReport,
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
