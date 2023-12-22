import 'package:flutter/material.dart';
import 'package:desktop_test/constant/dimen.dart';
import 'package:desktop_test/data/vms/user/user.dart';
import 'package:desktop_test/utils/extension.dart';
import 'package:desktop_test/widgets/easy_text.dart';
import 'package:desktop_test/widgets/reuse_card_item.dart';

import '../constant/color.dart';

class CustomerCard extends StatelessWidget {
  const CustomerCard({
    super.key,
    required this.customerVM,
    this.onTap,
  });

  final UserVM customerVM;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    // bool select = special ? !customerVM.isSelect : customerVM.isSelect;
    bool select = customerVM.isSelect;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(kAs20x),
        margin: EdgeInsets.only(
            left: kAs20x,
            right: context.responsive(kAs20x, lg: 0, md: 0),
            bottom: kAs10x),
        foregroundDecoration: select
            ? BoxDecoration(
                border: Border.all(color: kSelectedItemColor),
                borderRadius: BorderRadius.circular(kBr10x),
                color: kSelectedItemColor.withOpacity(
                  0.1,
                ))
            : null,
        constraints: const BoxConstraints(maxWidth: kAs350x),
        decoration: BoxDecoration(
            color: kWhiteColor, borderRadius: BorderRadius.circular(kBr10x)),
        child: Stack(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const EasyText(text: '# BG0029-02'),
                  customerVM.balance == null
                      ? const SizedBox()
                      : Flexible(
                          child: EasyText(
                            text:
                                "Balance : ${(customerVM.balance ?? 0).toString().separateMoney()}",
                            fontColor: (customerVM.balance ?? 0)
                                    .toString()
                                    .startsWith("0")
                                ? kPrimaryTextColor
                                : (customerVM.balance ?? 0)
                                        .toString()
                                        .startsWith("-")
                                    ? Colors.greenAccent
                                    : Colors.redAccent,
                          ),
                        ),
                ],
              ),
              const SizedBox(
                height: kAs5x,
              ),
              EasyText(
                text: customerVM.fullName ?? "",
                fontWeight: FontWeight.bold,
                fontSize: kFs14x,
                maxLine: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                      child: EasyText(text: customerVM.detailAddress ?? '')),
                  const SizedBox(
                    width: kAs20x,
                  ),
                  ItemViewComponent(
                      isUser: true,
                      gram: customerVM.gram ?? 0,
                      kyat: customerVM.kyat ?? 0,
                      pae: customerVM.pae ?? 0,
                      yawe: customerVM.yawe ?? 0)
                ],
              ),
              const SizedBox(
                height: kAs3x,
              ),
              const SizedBox(
                height: kAs3x,
              ),
              customerVM.phone == null
                  ? const SizedBox()
                  : RichText(
                      text: TextSpan(children: [
                      TextSpan(
                          text: customerVM.phone,
                          style: const TextStyle(
                              color: kPrimaryTextColor, fontSize: kFs16x)),
                      const TextSpan(
                          text: '  ●  ',
                          style: TextStyle(
                              fontSize: kFs12x, color: kSecondaryTextColor)),
                      TextSpan(
                          text: customerVM.phone,
                          style: const TextStyle(
                              color: kPrimaryTextColor, fontSize: kFs16x)),
                    ]))
            ],
          ),
          select
              ? const Positioned(
                  right: 0,
                  top: 0,
                  child: Icon(
                    Icons.check_circle_rounded,
                    color: kSelectedIconColor,
                  ))
              : const SizedBox()
        ]),
      ),
    );
  }
}
