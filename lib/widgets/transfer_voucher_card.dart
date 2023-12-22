import 'package:flutter/material.dart';
import 'package:desktop_test/utils/extension.dart';
import 'package:desktop_test/widgets/reuse_card_item.dart';

import '../constant/color.dart';
import '../constant/dimen.dart';
import '../data/vms/transfer_voucher/transfer_voucher.dart';
import '../pages/voucher_page_components/voucher_details.dart';
import '../persistent/daos/user_dao/access_token_dao_impl.dart';
import 'easy_button.dart';
import 'easy_text.dart';

class TransferVoucherCard extends StatelessWidget {
  const TransferVoucherCard(
      {super.key,
      required this.transferVm,
      this.isReceive = false,
      this.isReport = false});

  final TransferVoucherVM transferVm;
  final bool isReceive;
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
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const SizedBox(
            height: kAs3x,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              EasyText(text: transferVm.transferVno ?? ""),
              EasyQty(text: (transferVm.totalQty ?? 0).toString()),
            ],
          ),
          const SizedBox(
            height: kAs5x,
          ),
          AccessTokenDaoImpl().getTokenFromDatabase()!.user!.id ==
                  transferVm.transferUserId
              ? const SizedBox()
              : Row(
                  children: [
                    const EasyText(
                      text: 'Transfer From : ',
                      fontSize: kFs14x,
                    ),
                    Flexible(
                        child: EasyText(
                      text: '${transferVm.transferUserName}',
                      fontSize: kFs14x,
                    )),
                  ],
                ),
          isReceive
              ? const SizedBox()
              : Row(
                  children: [
                    const EasyText(
                      text: 'Transfer To : ',
                      fontSize: kFs14x,
                    ),
                    Flexible(
                        child: EasyText(
                      text: transferVm.recepentUserId == null
                          ? "Marketing"
                          : '${transferVm.recepentUser}',
                      fontSize: kFs14x,
                    )),
                  ],
                ),
          const SizedBox(
            height: kAs3x,
          ),
          ItemViewComponent(
              gram: transferVm.totalGram ?? 0,
              kyat: transferVm.kyat16 ?? 0,
              pae: transferVm.pae16 ?? 0,
              yawe: transferVm.yawe16 ?? 0),
          EasyButton(
            height: kAs45x,
            width: kAs180x,
            label: 'Voucher detail',
            onPressed: () {
              context.pushScreen(VoucherDetailForTransfer(
                transferVm: transferVm,
                isReceive: isReceive,
                isReport: isReport,
              ));
            },
          )
        ],
      ),
    );
  }
}
