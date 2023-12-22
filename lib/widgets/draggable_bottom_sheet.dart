import 'package:flutter/material.dart';
import 'package:desktop_test/data/vms/sale_voucher/total_value_vm.dart';
import 'package:desktop_test/utils/extension.dart';
import 'package:desktop_test/widgets/reuse_card_item.dart';
import '../constant/color.dart';
import '../constant/dimen.dart';
import '../constant/assets.dart';
import 'bottom_sheet_indicator.dart';
import 'easy_text.dart';

class DraggableBottomSheetView extends StatelessWidget {
  const DraggableBottomSheetView({
    super.key,
    this.totalValueVM,
    this.isDetail = true,
    this.incrementFunction,
    this.decrementFunction,
    this.isReport = false,
    this.isSale = false,
    this.gram,
    this.kyat16,
    this.pae16,
    this.yawe16,
    this.totalAmt,
    this.isTransfer = false,
    required this.maxSize,
    required this.minSize,
    required this.initialSize,
  });
  final bool isReport;
  final Function()? incrementFunction;
  final Function()? decrementFunction;
  final TotalValueVM? totalValueVM;
  final bool isTransfer;
  final double maxSize;
  final double minSize;
  final double initialSize;
  final num? gram;
  final num? kyat16;
  final num? pae16;
  final num? yawe16;
  final num? totalAmt;
  final bool isDetail;
  final bool isSale;
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      snap: true,
      initialChildSize: initialSize,
      minChildSize: minSize,
      maxChildSize: maxSize,
      builder: (context, scrollController) =>
          LayoutBuilder(builder: (context, constraint) {
        return Container(
            padding: const EdgeInsets.fromLTRB(kAs20x, kAs20x, kAs20x, kAs30x),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      blurRadius: 3,
                      offset: const Offset(0, -3))
                ],
                color: kWhiteColor,
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(kBr20x),
                    topLeft: Radius.circular(kBr20x))),
            child: ListView(controller: scrollController, children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const BottomSheetIndicator(),
                  const SizedBox(
                    height: kAs10x,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // grand summary
                      SizedBox(
                        width: getWidth(context),
                        child: const EasyText(
                          text: 'Grand Summary',
                          fontSize: kFs16x,
                          fontFamily: roboto,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: kAs10x,
                      ),
                      constraint.maxHeight <= getHeight(context) * 0.2
                          ? const SizedBox()
                          : Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: kAs15x, vertical: kAs10x),
                              decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(kBr10x)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const SizedBox(
                                    height: kAs10x,
                                  ),
                                  Row(
                                    children: [
                                      const EasyText(
                                        text: 'Quantity',
                                        fontFamily: roboto,
                                        fontSize: kFs16x,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      const Spacer(),
                                      EasyQty(
                                        text: totalValueVM?.tQty?.toString() ??
                                            '',
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: kAs20x,
                                  ),
                                  isTransfer
                                      ? Table(
                                          children: [
                                            _tableRow(
                                                label: '',
                                                gram: 'Gram',
                                                k: 'K',
                                                p: 'P',
                                                y: 'Y'),
                                            _tableRow(
                                                label: 'Weight',
                                                gram: totalValueVM?.tGram!
                                                        .floorAsFixedTwo()
                                                        .toString() ??
                                                    '',
                                                k: totalValueVM?.tKyat
                                                        .toString() ??
                                                    '',
                                                p: totalValueVM?.tPae
                                                        .toString() ??
                                                    '',
                                                y: totalValueVM?.tYawe!
                                                        .floorAsFixedTwo()
                                                        .toString() ??
                                                    ''),
                                            _tableRow(
                                                label: '16P Weight',
                                                gram: isDetail
                                                    ? (gram ?? 0)
                                                        .toStringAsFixed(2)
                                                    : totalValueVM?.tGram16!
                                                            .floorAsFixedTwo()
                                                            .toString() ??
                                                        "0",
                                                k: isDetail
                                                    ? (kyat16 ?? 0).toString()
                                                    : totalValueVM?.tKyat16
                                                            .toString() ??
                                                        '',
                                                p: isDetail
                                                    ? (pae16 ?? 0).toString()
                                                    : totalValueVM?.tPae16
                                                            ?.toString() ??
                                                        '',
                                                y: isDetail
                                                    ? (yawe16 ?? 0)
                                                        .toStringAsFixed(2)
                                                    : totalValueVM?.tYawe16!
                                                            .floorAsFixedTwo()
                                                            .toString() ??
                                                        ''),
                                          ],
                                        )
                                      : Table(
                                          defaultVerticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          columnWidths: const {
                                            0: FlexColumnWidth(3),
                                            1: FlexColumnWidth(3),
                                            2: FlexColumnWidth(1),
                                            3: FlexColumnWidth(1),
                                            4: FlexColumnWidth(1.5),
                                            5: FlexColumnWidth(1)
                                          },
                                          children: [
                                            ///label
                                            _tableRow(
                                                label: '',
                                                gram: 'Gram',
                                                k: 'K',
                                                p: 'P',
                                                y: 'Y'),

                                            /// real weight
                                            _tableRow(
                                                label: 'Weight',
                                                gram: totalValueVM?.tGram!
                                                        .floorAsFixedTwo()
                                                        .toString() ??
                                                    '',
                                                k: totalValueVM?.tKyat
                                                        .toString() ??
                                                    '',
                                                p: totalValueVM?.tPae
                                                        .toString() ??
                                                    '',
                                                y: totalValueVM?.tYawe!
                                                        .floorAsFixedTwo()
                                                        .toString() ??
                                                    ''),

                                            /// waste weight
                                            _tableRow(
                                                label: 'Waste',
                                                gram: totalValueVM?.tWasteGram!
                                                        .floorAsFixedTwo()
                                                        .toString() ??
                                                    '0',
                                                k:
                                                    "${totalValueVM?.tWKyat ?? '0'}",
                                                p:
                                                    "${totalValueVM?.tWPae ?? '0'}",
                                                y: totalValueVM?.tWYawe!
                                                        .floorAsFixedTwo()
                                                        .toString() ??
                                                    '0'),

                                            isSale
                                                ? _tableRow(
                                                    label: "Charges",
                                                    gram:
                                                        (totalValueVM?.tCGram ??
                                                                0)
                                                            .toString(),
                                                    k: (totalValueVM?.tCKyat ??
                                                            0)
                                                        .toString(),
                                                    p: (totalValueVM?.tCPae ??
                                                            0)
                                                        .toString(),
                                                    y: (totalValueVM?.tCYawe ??
                                                            0)
                                                        .toString())
                                                : const TableRow(children: [
                                                    SizedBox(),
                                                    SizedBox(),
                                                    SizedBox(),
                                                    SizedBox(),
                                                    SizedBox(),
                                                  ]),

                                            /// net weight
                                            _tableRow(
                                                label: 'Net Weight',
                                                gram: totalValueVM?.tNetGram!
                                                        .floorAsFixedTwo()
                                                        .toString() ??
                                                    '0',
                                                k:
                                                    "${totalValueVM?.tNetKyat ?? '0'}",
                                                p:
                                                    "${totalValueVM?.tNetPae ?? '0'}",
                                                y: totalValueVM?.tNetYawe!
                                                        .floorAsFixedTwo()
                                                        .toString() ??
                                                    '0'),

                                            _tableRow(
                                                label: '16P Weight',
                                                gram: isDetail
                                                    ? (gram ?? 0)
                                                        .floorAsFixedTwo()
                                                        .toString()
                                                    : totalValueVM?.tGram16!
                                                            .floorAsFixedTwo()
                                                            .toString() ??
                                                        "0",
                                                k: isDetail
                                                    ? (kyat16 ?? 0).toString()
                                                    : totalValueVM?.tKyat16
                                                            .toString() ??
                                                        '',
                                                p: isDetail
                                                    ? (pae16 ?? 0).toString()
                                                    : totalValueVM?.tPae16
                                                            ?.toString() ??
                                                        '',
                                                y: isDetail
                                                    ? (yawe16 ?? 0)
                                                        .floorAsFixedTwo()
                                                        .toString()
                                                    : totalValueVM?.tYawe16!
                                                            .floorAsFixedTwo()
                                                            .toString() ??
                                                        ''),

                                            /// adjustable weight
                                            /// 16 weight
                                            isDetail
                                                ? const TableRow(children: [
                                                    SizedBox(),
                                                    SizedBox(),
                                                    SizedBox(),
                                                    SizedBox(),
                                                    SizedBox(),
                                                  ])
                                                : _tableRow(
                                                    label: 'Adjustable Weight',
                                                    gram: totalValueVM
                                                            ?.tAdjustableGram!
                                                            .floorAsFixedTwo()
                                                            .toString() ??
                                                        '',
                                                    k: totalValueVM
                                                            ?.tAdjustableKyat
                                                            .toString() ??
                                                        '',
                                                    widget: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Expanded(
                                                          flex: context
                                                              .responsive(1,
                                                                  lg: 0, md: 1),
                                                          child: IconButton(
                                                              onPressed:
                                                                  incrementFunction,
                                                              icon: const Icon(
                                                                Icons
                                                                    .add_circle_outline,
                                                                size: kAs24x,
                                                              )),
                                                        ),
                                                        Expanded(
                                                          flex: context
                                                              .responsive(1,
                                                                  lg: 0, md: 1),
                                                          child: IconButton(
                                                              onPressed:
                                                                  decrementFunction,
                                                              icon: const Icon(
                                                                Icons
                                                                    .remove_circle_outline,
                                                                size: kAs24x,
                                                              )),
                                                        ),
                                                        SizedBox(
                                                          width: kAs45x,
                                                          child: EasyText(
                                                            text: totalValueVM
                                                                    ?.tAdjustableGram!
                                                                    .floorAsFixedTwo()
                                                                    .toString() ??
                                                                '',
                                                            textAlign:
                                                                TextAlign.right,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    p: totalValueVM
                                                            ?.tAdjustablePae
                                                            .toString() ??
                                                        '',
                                                    y: totalValueVM
                                                            ?.tAdjustableYawe!
                                                            .floorAsFixedTwo()
                                                            .toString() ??
                                                        ''),
                                          ],
                                        ),
                                  isTransfer
                                      ? const SizedBox()
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                              const Expanded(
                                                flex: 2,
                                                child: EasyText(
                                                  text: 'Total Amount : ',
                                                  fontSize: kFs14x,
                                                  fontWeight: FontWeight.bold,
                                                  textAlign: TextAlign.right,
                                                ),
                                              ),
                                              Expanded(
                                                  flex: 2,
                                                  child: EasyText(
                                                    text: (isDetail
                                                            ? totalAmt ?? 0
                                                            : totalValueVM
                                                                    ?.totalAmt ??
                                                                0)
                                                        .floor()
                                                        .toString()
                                                        .separateMoney(),
                                                    textAlign: TextAlign.right,
                                                  ))
                                            ]),
                                ],
                              ))
                    ],
                  ),
                  // isReport?const SizedBox():const Padding(padding:  EdgeInsets.only(bottom: kAs50x))
                ],
              )
            ]));
      }),
    );
  }

  TableRow _tableRow({
    required String label,
    required String gram,
    Widget? widget,
    required String k,
    required String p,
    required String y,
  }) {
    return TableRow(children: [
      Padding(
        padding: const EdgeInsets.only(bottom: kAs10x),
        child: EasyText(
          text: label,
          fontSize: kFs14x,
          fontWeight: FontWeight.bold,
        ),
      ),
      widget ??
          EasyText(
            text: gram,
            textAlign: TextAlign.right,
          ),
      EasyText(
        text: k,
        textAlign: TextAlign.right,
      ),
      EasyText(
        text: p,
        textAlign: TextAlign.right,
      ),
      EasyText(
        text: y,
        textAlign: TextAlign.right,
      ),
    ]);
  }
}
