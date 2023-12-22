import 'package:flutter/material.dart';
import 'package:desktop_test/constant/color.dart';
import 'package:desktop_test/constant/dimen.dart';
import 'package:desktop_test/widgets/easy_text.dart';

class FakeEasyTextField extends StatelessWidget {
  const FakeEasyTextField({super.key, required this.text, this.onTap});

  final String text;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap == null ? () {} : () => onTap!(),
      child: Container(
        height: kAs50x,
        padding: const EdgeInsets.only(left: 8),
        alignment: Alignment.centerLeft,
        width: getWidth(context),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 0.2),
            color: kWhiteColor,
            borderRadius: BorderRadius.circular(kBr10x)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.search),
            const SizedBox(
              width: kAs10x,
            ),
            EasyText(
              text: text,
              fontColor: kSecondaryTextColor,
            ),
          ],
        ),
      ),
    );
  }
}
