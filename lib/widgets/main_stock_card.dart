import 'package:flutter/material.dart';
import 'package:desktop_test/provider/return_voucher_provider.dart';
import 'package:desktop_test/utils/extension.dart';
import 'package:desktop_test/widgets/delete_dialog_widget.dart';
import 'package:desktop_test/widgets/reuse_card_item.dart';
import 'package:provider/provider.dart';

import '../constant/color.dart';
import '../constant/dimen.dart';
import '../data/vms/issue_stock/main_stock.dart';
import 'easy_image.dart';
import 'easy_text.dart';

class MainStocksCard extends StatelessWidget {
  const MainStocksCard(
      {super.key, required this.mainStock, this.isCanDelete = false});

  final MainStock mainStock;
  final bool isCanDelete;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        if (isCanDelete) {
          showModalBottomSheet(
            backgroundColor: Colors.transparent,
            context: context,
            builder: (context) => DeleteDialogWidget(
              onPressed: () {
                context
                    .read<ReturnVoucherProvider>()
                    .deleteSelectedMainStock(mainStock.gglCode ?? "");
                context.popScreen();
              },
            ),
          );
        }
      },
      child: Container(
        foregroundDecoration: mainStock.isSelect
            ? BoxDecoration(
                color: kSelectedIconColor.withOpacity(0.05),
                borderRadius: BorderRadius.circular(kBr10x),
                border: Border.all(color: kSelectedIconColor),
              )
            : null,
        // padding: const EdgeInsets.symmetric(horizontal: kAs20x, vertical: kAs10x),
        margin: EdgeInsets.symmetric(
            horizontal: context.responsive(kAs20x, lg: 0, md: 0),
            vertical: kAs5x),
        decoration: BoxDecoration(
            color: kWhiteColor, borderRadius: BorderRadius.circular(kBr10x)),
        child: Stack(children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(kBr10x),
                        bottomLeft: Radius.circular(kBr10x)),
                    child: EasyImage(
                      url: mainStock.image ?? '',
                    )),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(kAs20x),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          EasyText(text: mainStock.gglCode ?? ''),
                          mainStock.quantity == null
                              ? const SizedBox()
                              : EasyQty(
                                  text: (mainStock.quantity ?? 0).toString(),
                                )
                        ],
                      ),
                      const SizedBox(
                        height: kAs5x,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                              child: EasyText(
                            text: mainStock.itemName ?? '',
                            maxLine: 2,
                            overflow: TextOverflow.ellipsis,
                          )),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: kAs10x,
                            ),
                            decoration: BoxDecoration(
                                color: kContainerColor.withOpacity(
                                    _colorMaker(mainStock.stateName!) / 16),
                                borderRadius: BorderRadius.circular(20)),
                            child: EasyText(text: mainStock.stateName ?? ''),
                          )
                        ],
                      ),
                      mainStock.totalAmt == null
                          ? const SizedBox()
                          : EasyText(
                              text:
                                  "${(mainStock.totalAmt).toString().separateMoney()} kyats"),
                      ItemViewComponent(
                          gram: mainStock.gram16 ?? 0,
                          kyat: mainStock.kyat16 ?? 0,
                          pae: mainStock.pae16 ?? 0,
                          yawe: mainStock.yawe16 ?? 0),
                      (mainStock.wasteGram == null || mainStock.wasteGram == 0)
                          ? const SizedBox()
                          : Row(
                              children: [
                                KyatPaeYaweChecker(
                                    checker: mainStock.wasteKyat ?? 0,
                                    type: ' K'),
                                KyatPaeYaweChecker(
                                    checker: mainStock.wastePae ?? 0,
                                    type: ' P'),
                                KyatPaeYaweChecker(
                                    checker: mainStock.wasteYawe ?? 0,
                                    type: ' Y'),
                                const EasyText(
                                  text: 'waste',
                                  fontColor: kSecondaryTextColor,
                                  fontSize: kFs12x,
                                )
                              ],
                            )
                    ],
                  ),
                ),
              ),
            ],
          ),
          mainStock.isSelect
              ? const Positioned(
                  right: 30,
                  top: 10,
                  child: Icon(
                    Icons.check_circle_rounded,
                    color: kSelectedIconColor,
                  ),
                )
              : const SizedBox()
        ]),
      ),
    );
  }

  num _colorMaker(String itemName) {
    return itemName.split('ပဲ').first.textToNum();
  }
}
