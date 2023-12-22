import 'package:flutter/material.dart';
import 'package:desktop_test/constant/color.dart';

import '../constant/dimen.dart';
import 'bottom_sheet_indicator.dart';
import 'easy_button.dart';
import 'easy_text.dart';

class DeleteDialogWidget extends StatelessWidget {
  const DeleteDialogWidget({
    super.key,
    this.onPressed,
  });
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxHeight: kAs150x,
      ),
      padding: const EdgeInsets.symmetric(horizontal: kAs20x),
      decoration: const BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(kBr10x),
              topLeft: Radius.circular(kBr10x))),
      child: Column(
        children: [
          const SizedBox(
            height: kAs5x,
          ),
          const BottomSheetIndicator(),
          const SizedBox(
            height: kAs10x,
          ),
          const EasyText(
            text: "Are you suer to delete ?",
            fontSize: kFs16x,
          ),
          const SizedBox(
            height: kAs5x,
          ),
          const Divider(
            thickness: 2,
          ),
          const SizedBox(
            height: kAs5x,
          ),
          SizedBox(
              width: getWidth(context),
              child: EasyButton(
                label: "Yes",
                isNotIcon: true,
                onPressed: onPressed,
              )),
        ],
      ),
    );
  }
}
