import 'package:flutter/material.dart';

import '../constant/dimen.dart';

class CenterColumnWidget extends StatelessWidget {
  const CenterColumnWidget({
    super.key,
    this.widget,
  });

  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: kAs45x),
            child: widget,
          ),
        ],
      ),
    );
  }
}