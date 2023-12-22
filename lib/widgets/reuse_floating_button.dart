import 'package:flutter/material.dart';
import 'package:desktop_test/utils/extension.dart';

import '../constant/dimen.dart';

class ReuseFloatingActionButton extends StatelessWidget {
  const ReuseFloatingActionButton(
      {super.key, required this.page, this.padding = kAs70x});

  final Widget page;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: padding),
      child: FloatingActionButton(
        heroTag: null,
        onPressed: () {
          context.pushScreen(page);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
