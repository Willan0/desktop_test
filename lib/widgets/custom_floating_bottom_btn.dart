import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:desktop_test/utils/extension.dart';

import '../constant/color.dart';
import '../constant/dimen.dart';

class CustomFloatingBottomButton extends StatelessWidget {
  const CustomFloatingBottomButton(
      {super.key,
      required this.items,
      required this.onTap,
      required this.index});

  final List<FloatingNavbarItem> items;
  final void Function(int? index) onTap;
  final int index;
  @override
  Widget build(BuildContext context) {
    return FloatingNavbar(
      margin: EdgeInsets.all(context.responsive(0, lg: 8, md: 8)),
      backgroundColor: kWhiteColor,
      unselectedItemColor: kUnSelectedItemColor,
      selectedBackgroundColor: kWhiteColor,
      width: context.responsive(getWidth(context),
          lg: getWidth(context) * 0.4, md: getWidth(context) * 0.7),
      currentIndex: index,
      onTap: (value) => onTap(value),
      items: items,
    );
  }
}
