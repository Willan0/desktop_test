import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:desktop_test/utils/extension.dart';

import '../constant/color.dart';
import '../constant/dimen.dart';
import 'easy_text.dart';
import 'easy_text_field.dart';

class EasySliverAppBar extends StatelessWidget {
  const EasySliverAppBar(
      {super.key,
      required this.title,
      this.hintText,
      this.bottom,
      this.action,
      this.leading,
      this.isPinned = true,
      required this.expandedHeight,
      this.textEditingController,
      this.onChange});
  final String title;
  final String? hintText;
  final PreferredSizeWidget? bottom;
  final bool? leading;
  final String? action;
  final bool isPinned;
  final double expandedHeight;
  final Function(String value)? onChange;
  final TextEditingController? textEditingController;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      centerTitle: false,
      floating: true,
      elevation: 0,
      expandedHeight: expandedHeight,
      leadingWidth: 50,
      actions: action == null
          ? []
          : [
              Center(
                child: EasyText(
                  text: action ?? '0',
                  fontSize: kFs12x,
                ),
              ),
              const SizedBox(
                width: kAs5x,
              )
            ],
      leading: leading == null
          ? null
          : Padding(
              padding: const EdgeInsets.only(left: kFs10x),
              child: IconButton(
                  onPressed: () {
                    context.popScreen();
                  },
                  icon: const Icon(
                    CupertinoIcons.arrow_left,
                    color: Colors.black,
                  )),
            ),
      flexibleSpace: hintText == null
          ? null
          : FlexibleSpaceBar(
              background: Stack(
                children: [
                  Positioned(
                      bottom: 10,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: kAs20x),
                        child: EasyTextField(
                          iconData: Icons.search,
                          controller:
                              textEditingController ?? TextEditingController(),
                          hintText: hintText ?? '',
                          onChanged: (value) =>
                              onChange == null ? (value) {} : onChange!(value),
                        ),
                      ))
                ],
              ),
            ),
      pinned: isPinned,
      snap: true,
      toolbarHeight: kToolbarHeight,
      backgroundColor: kBackGroundColor,
      title: Padding(
        padding: EdgeInsets.only(left: leading == null ? kAs10x : 0),
        child: EasyText(
          text: title,
          fontSize: leading == null ? kFs20x : kFs16x,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
