import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constant/color.dart';
import '../constant/dimen.dart';
import 'easy_text.dart';

class EasyButton extends StatelessWidget {
  const EasyButton(
      {super.key,
      this.onPressed,
      required this.label,
      this.isNotIcon = false,
      this.width = 100,
      this.height = kAs45x,  this.isValidate = false});
  final void Function()? onPressed;
  final String label;
  final bool isNotIcon;
  final double width;
  final double height;
  final bool isValidate;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () => onPressed!(),
        style: ElevatedButton.styleFrom(
          // backgroundColor: isValidate?Colors.blue:Colors.blueGrey.withOpacity(0.8),
            fixedSize: Size(width, height),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(kBr10x))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            EasyText(
              text: label,
              fontSize: kFs12x,
              fontColor: kWhiteColor,
            ),
            const SizedBox(
              width: kAs5x,
            ),
            isNotIcon
                ? const SizedBox()
                : const Icon(CupertinoIcons.arrow_right)
          ],
        ));
  }
}
