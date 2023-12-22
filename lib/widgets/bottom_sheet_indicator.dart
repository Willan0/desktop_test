import 'package:flutter/material.dart';

class BottomSheetIndicator extends StatelessWidget {
  const BottomSheetIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 5,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.grey.withOpacity(0.3)),
    );
  }
}
