import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:desktop_test/data/vms/issue_stock/item_waste_vm.dart';

import '../constant/color.dart';
import '../constant/dimen.dart';
import '../constant/assets.dart';
import 'easy_text.dart';

class EasyQty extends StatelessWidget {
  const EasyQty({
    super.key,
    required this.text,
  });

  final String text;
  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(children: [
      const TextSpan(
          text: 'Qty - ',
          style: TextStyle(
              color: kSecondaryTextColor,
              fontFamily: roboto,
              fontSize: kFs12x)),
      TextSpan(
          text: text,
          style: const TextStyle(color: kPrimaryTextColor, fontSize: kFs16x))
    ]));
  }
}

class ItemViewComponent extends StatelessWidget {
  const ItemViewComponent({
    super.key,
    required this.gram,
    required this.kyat,
    required this.pae,
    required this.yawe,
    this.isUser = false,
  });
  final num gram;
  final num kyat;
  final num pae;
  final num yawe;
  final bool isUser;

  @override
  Widget build(BuildContext context) {
    return gram == 0
        ? const SizedBox()
        : Row(
            children: [
              EasyText(
                text: gram.toString(),
                fontSize: kFs12x,
                fontWeight: FontWeight.w500,
              ),
              EasyText(
                text: gram < 2 ? ' gram ' : ' grams ',
                fontSize: kFs12x,
                fontColor: kSecondaryTextColor,
                fontWeight: FontWeight.w500,
              ),
              const EasyText(
                text: ' ● ',
                fontColor: kSecondaryTextColor,
                fontSize: kFs10x,
              ),
              KyatPaeYaweChecker(
                checker: kyat,
                type: 'K',
                isUser: isUser,
              ),
              KyatPaeYaweChecker(
                checker: pae,
                type: 'P',
                isUser: isUser,
              ),
              KyatPaeYaweChecker(
                checker: yawe,
                type: 'Y',
                isUser: isUser,
              )
            ],
          );
  }
}

class ItemViewComponentTwo extends StatelessWidget {
  const ItemViewComponentTwo({
    super.key,
    required this.wasteList,
  });

  final List<ItemWasteVM> wasteList;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: wasteList[0].minQty == null && wasteList[0].maxQty == null
            ? 29
            : 45,
        width: getWidth(context),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: wasteList.length,
          itemBuilder: (context, index) {
            if (wasteList.isEmpty) {
              return const SizedBox();
            }
            return Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        KyatPaeYaweChecker(
                            checker: wasteList[index].wasteKyat ?? 0,
                            type: 'K'),
                        KyatPaeYaweChecker(
                            checker: wasteList[index].wastePae ?? 0, type: 'P'),
                        KyatPaeYaweChecker(
                            checker: wasteList[index].wasteYawe ?? 0,
                            type: 'Y'),
                        const SizedBox(
                          width: kAs10x,
                        ),
                        // const EasyText(text: "waste"),
                      ],
                    ),
                    wasteList[index].minQty == null &&
                            wasteList[index].maxQty == null
                        ? const SizedBox()
                        : EasyText(
                            text:
                                '${wasteList[index].minQty ?? 0} - ${wasteList[index].maxQty ?? 0}   ')
                  ],
                ),
                const SizedBox(
                  width: kAs15x,
                ),
                index == (wasteList.length - 1)
                    ? const SizedBox()
                    : Container(
                        color: kPrimaryTextColor,
                        width: 1,
                        height: kAs20x,
                      ),
                index == (wasteList.length - 1)
                    ? const SizedBox()
                    : const SizedBox(
                        width: kAs15x,
                      ),
              ],
            );
          },
        ));
  }
}

class KyatPaeYaweChecker extends StatelessWidget {
  const KyatPaeYaweChecker(
      {super.key,
      required this.checker,
      required this.type,
      this.isUser = false});
  final num checker;
  final String type;
  final bool isUser;

  @override
  Widget build(BuildContext context) {
    return isUser
        ? EasyText(
            text: ' $checker $type ',
            fontColor: kPrimaryTextColor,
            fontSize: kFs12x,
          )
        : checker == 0
            ? const SizedBox()
            : EasyText(
                text: '$checker$type ',
                fontColor: kPrimaryTextColor,
                fontSize: kFs12x,
              );
  }
}
