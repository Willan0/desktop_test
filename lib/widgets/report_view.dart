import 'package:flutter/cupertino.dart';

import '../constant/color.dart';
import '../constant/dimen.dart';
import 'easy_text.dart';

class ReportView extends StatelessWidget {
  const ReportView({super.key, required this.isCollapse, required this.widgets, required this.count, required this.date, this.onTap});
  final bool isCollapse;
  final List<Widget> widgets;
  final String date;
  final void Function()? onTap;
  final int count;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: onTap,
            child: Container(
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color:  isCollapse?kSecondaryTextColor:kBackGroundColor))),
              padding: const EdgeInsets.only(bottom: kAs10x,top: kAs5x),
              child: Row(children: [
                EasyText(
                  text: date,
                  fontSize: kFs16x,
                ),
                const Spacer(),
                EasyText(
                  text: count.toString(),
                  fontSize: kFs18x,
                ),
                const SizedBox(width: kAs10x,),
                Icon(isCollapse?CupertinoIcons.chevron_forward:CupertinoIcons.chevron_down)
              ]),
            ),
          ),
          const SizedBox(
            height: kAs10x,
          ),
          Visibility(
            visible: !isCollapse,
            child: Wrap(
                spacing: kAs20x,
                children: widgets
            ),
          ),
        ],
      ),
    );
  }
}
