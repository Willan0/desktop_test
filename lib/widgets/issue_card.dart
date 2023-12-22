import 'package:flutter/material.dart';
import 'package:desktop_test/constant/color.dart';
import 'package:desktop_test/constant/dimen.dart';
import 'package:desktop_test/constant/assets.dart';
import 'package:desktop_test/data/vms/issue_stock/issue_stock_vm.dart';
import 'package:desktop_test/provider/sale_voucher_provider.dart';
import 'package:desktop_test/utils/extension.dart';
import 'package:desktop_test/widgets/delete_dialog_widget.dart';
import 'package:desktop_test/widgets/easy_image.dart';
import 'package:desktop_test/widgets/easy_text.dart';
import 'package:provider/provider.dart';

import 'reuse_card_item.dart';

class IssueStocksCard extends StatelessWidget {
  const IssueStocksCard(
      {super.key, this.isSelect = false, this.issue, this.isCanDelete = false});

  final IssueStockVM? issue;
  final bool isSelect;
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
                    .read<SaleVoucherProvider>()
                    .deleteSelectedItem(issue?.gglCode ?? '');
                context.popScreen();
              },
            ),
          );
        }
      },
      child: Stack(children: [
        Container(
          foregroundDecoration: issue?.isSelect ?? false
              ? BoxDecoration(
                  color: kSelectedIconColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(kBr10x),
                  border: Border.all(color: kSelectedIconColor),
                )
              : null,
          margin: EdgeInsets.only(
              bottom: kAs15x,
              left: context.responsive(kAs20x, md: 0, lg: 0),
              right: context.responsive(kAs20x, md: 0, lg: 0)),
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
          child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(kBr10x),
                          bottomLeft: Radius.circular(kBr10x)),
                      child: EasyImage(
                        url: issue?.image ?? '',
                        height: context.responsive(
                            issue?.itemWasteList == null ||
                                    issue!.itemWasteList!.isEmpty
                                ? 150
                                : issue?.itemGemList == null ||
                                        issue!.itemGemList!.isEmpty
                                    ? 180
                                    : 210,
                            lg: 210,
                            md: issue?.totalAmt == 0 ? 200 : 220),
                      )),
                ),
                Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const EasyText(
                                text: '●',
                                fontSize: kFs10x,
                                fontColor: kSecondaryTextColor,
                              ),
                              EasyText(
                                text: issue?.gglCode ?? '',
                                fontSize: kFs12x,
                              ),
                              const SizedBox(
                                width: kAs30x,
                              ),
                              EasyQty(
                                text: ' ${issue?.qty ?? 0}',
                              )
                            ],
                          ),
                          const SizedBox(
                            height: kAs10x,
                          ),

                          //name and item name
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: EasyText(
                                  text: issue?.itemName ?? '',
                                  fontFamily: roboto,
                                  fontWeight: FontWeight.bold,
                                  fontSize: kFs14x,
                                  overflow: TextOverflow.ellipsis,
                                  maxLine: 2,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: kAs10x,
                                ),
                                decoration: BoxDecoration(
                                    color: kContainerColor.withOpacity(
                                        _colorMaker(issue!.stateName!) / 16),
                                    borderRadius: BorderRadius.circular(20)),
                                child: EasyText(
                                    text: issue?.stateName.toString() ?? ''),
                              )
                            ],
                          ),
                          issue?.itemGemList == null ||
                                  issue!.itemGemList!.isEmpty
                              ? const SizedBox()
                              : const SizedBox(
                                  height: kAs10x,
                                ),
                          issue?.itemGemList == null ||
                                  issue!.itemGemList!.isEmpty
                              ? const SizedBox()
                              : RichText(
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  text: TextSpan(
                                      children: issue?.itemGemList
                                          ?.map((gem) => TextSpan(
                                              text: '${gem.particular} \t',
                                              style: const TextStyle(
                                                  color: kPrimaryTextColor)))
                                          .toList())),
                          const SizedBox(
                            height: kAs5x,
                          ),
                          issue?.totalAmt == null
                              ? const SizedBox()
                              : EasyText(
                                  text:
                                      "${(issue?.totalAmt).toString().separateMoney()} kyats"),
                          // gram kyat pae yawe
                          ItemViewComponent(
                            gram: issue?.gram ?? 0,
                            kyat: issue?.kyat ?? 0,
                            pae: issue?.pae ?? 0,
                            yawe: issue?.yawe ?? 0,
                          ),
                          const SizedBox(
                            height: kAs5x,
                          ),
                          (issue?.itemWasteList == null ||
                                  issue!.itemWasteList!.isEmpty)
                              ? const SizedBox()
                              : isSelect
                                  ? (issue?.itemWasteList![0].wasteKyat == 0 &&
                                          issue?.itemWasteList![0].wastePae ==
                                              0 &&
                                          issue?.itemWasteList![0].wasteYawe ==
                                              0)
                                      ? const SizedBox()
                                      : Row(
                                          children: [
                                            KyatPaeYaweChecker(
                                                checker: issue
                                                        ?.itemWasteList?[0]
                                                        .wasteKyat ??
                                                    0,
                                                type: ' K'),
                                            KyatPaeYaweChecker(
                                                checker: issue
                                                        ?.itemWasteList?[0]
                                                        .wastePae ??
                                                    0,
                                                type: ' P'),
                                            KyatPaeYaweChecker(
                                                checker: issue
                                                        ?.itemWasteList?[0]
                                                        .wasteYawe ??
                                                    0,
                                                type: ' Y'),
                                            const EasyText(
                                              text: 'waste',
                                              fontColor: kSecondaryTextColor,
                                              fontSize: kFs12x,
                                            )
                                          ],
                                        )
                                  : ItemViewComponentTwo(
                                      wasteList: issue?.itemWasteList ?? [],
                                    )
                        ],
                      ),
                    ))
              ]),
        ),
        issue?.isSelect ?? false
            ? const Positioned(
                left: 30,
                top: 10,
                child: Icon(
                  Icons.check_circle_rounded,
                  color: kSelectedIconColor,
                ),
              )
            : const SizedBox()
      ]),
    );
  }

  num _colorMaker(String itemName) {
    return itemName.split('ပဲ').first.trim().textToNum();
  }
}
