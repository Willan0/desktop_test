import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:desktop_test/constant/dimen.dart';
import 'package:desktop_test/constant/assets.dart';
import 'package:desktop_test/widgets/easy_button.dart';
import 'package:desktop_test/widgets/easy_text.dart';
import 'package:intl/intl.dart';

extension ContextExtesion on BuildContext {
  T responsive<T>(
    T defaultVal, {
    T? sm,
    T? md,
    T? lg,
    T? xl,
  }) {
    final wd = MediaQuery.of(this).size.width;
    return wd >= 1280
        ? (xl ?? lg ?? md ?? sm ?? defaultVal)
        : wd >= 1024
            ? (lg ?? md ?? sm ?? defaultVal)
            : wd >= 768
                ? (md ?? sm ?? defaultVal)
                : wd >= 640
                    ? (sm ?? defaultVal)
                    : defaultVal;
  }

  responsiveHeight<T>(
    T defaultVal, {
    T? sm,
    T? md,
    T? lg,
    T? xl,
  }) {
    final hd = MediaQuery.of(this).size.height;
    return hd >= 1200
        ? (xl ?? lg ?? md ?? sm ?? defaultVal)
        : hd >= 760
            ? (lg ?? md ?? sm ?? defaultVal)
            : hd >= 753
                ? (md ?? sm ?? defaultVal)
                : hd >= 720
                    ? (sm ?? defaultVal)
                    : defaultVal;
  }

  void pushScreen(Widget widget) {
    Navigator.of(this).push(MaterialPageRoute(builder: (_) => widget));
  }

  void popScreen() {
    Navigator.of(this).pop();
  }

  void pushReplacement(Widget widget) {
    Navigator.of(this).pushReplacement(MaterialPageRoute(
      builder: (context) => widget,
    ));
  }

  void showLoadingDialog() {
    showDialog(
      context: this,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget showLoading() => const Center(
        child: CircularProgressIndicator(),
      );

  void showWarningDialog(BuildContext context,
      {required String warningText,
      String? textLeft,
      String? textRight,
      Function? onTextRight,
      Widget? bottom}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        actions: [
          ElevatedButton(
              onPressed: () {
                context.popScreen();
              },
              child: Text(textLeft ?? 'No')),
          textRight == null
              ? const SizedBox()
              : ElevatedButton(
                  onPressed: () => onTextRight == null ? () {} : onTextRight(),
                  child: Text(textRight)),
        ],
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              warningText,
              style: const TextStyle(
                  fontFamily: roboto,
                  fontWeight: FontWeight.bold,
                  fontSize: kFs18x),
            ),
            SizedBox(
              height: bottom == null ? 0 : kAs20x,
            ),
            bottom ?? const SizedBox(),
          ],
        ),
      ),
    );
  }

  Future<void> showErrorDialog(BuildContext context,
      {required String errorMessage, required onPressed}) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: EasyText(
          text: errorMessage,
          fontSize: kFs18x,
          fontWeight: FontWeight.bold,
        ),
        actions: [
          ElevatedButton(onPressed: () => onPressed(), child: const Text('Ok'))
        ],
      ),
    );
  }

  Future<void> showSimpleWarningDialog(
      BuildContext context, String label) async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Column(
                children: [
                  EasyText(
                    text: label,
                    fontSize: kFs18x,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: kAs30x,
                  ),
                  const Icon(
                    CupertinoIcons.exclamationmark,
                    size: 40,
                    color: Colors.red,
                  ),
                  const SizedBox(
                    height: kAs20x,
                  ),
                  EasyButton(
                    label: 'Ok',
                    onPressed: () {
                      popScreen();
                    },
                    height: 40,
                    isNotIcon: true,
                  )
                ],
              ),
            ));
  }

  num getTotalGram(List<num> gramList) {
    num totalGram = 0;
    for (var g in gramList) {
      totalGram += g;
      return totalGram;
    }
    return 0;
  }
}

extension StringExtension on String {
  num textToNum() {
    if (isEmpty) {
      return num.parse('0');
    }
    return num.parse(trim());
  }

  String separateMoney() {
    if (length > 3) {
      if (startsWith('-')) {
        final temp = replaceFirst('-', '');
        return "-${NumberFormat.decimalPattern().format(num.parse(temp))}";
      }
      return NumberFormat.decimalPattern().format(num.parse(trim()));
    }

    return this;
  }

  String addS() {
    if (textToNum() <= 1) {
      return '$this item selected';
    }
    return '$this items selected';
  }

  // Function to get the current date in 'yyyy-MM-dd' format
  String getCurrentDate() {
    return DateFormat("yyyy-MM-dd").format(DateTime.now());
  }

  // Function to get yesterday's date in 'yyyy-MM-dd' format
  String getYesterdayDate() {
    return DateFormat("yyyy-MM-dd")
        .format(DateTime.now().subtract(const Duration(days: 1)));
  }

  // Function to get the date in 'yyyy-MM-dd' format
  String formatDate() {
    if (isEmpty) return "";
    DateTime dateTime = DateTime.parse(this);
    return DateFormat("yyyy-MM-dd").format(dateTime);
  }

  DateTime formatStringToDate() {
    if (isEmpty) return DateTime.now();
    DateTime dateTime = DateFormat("dd-MMM-yyyy").parse(this);
    return dateTime;
  }
}

extension DateTimeExtension on DateTime {
  String formatForFilter() {
    return DateFormat("M-d-yyyy").format(this);
  }

  String formatDateForPicker() {
    return DateFormat("dd/MM/yyyy").format(this);
  }

  String formatDateTimeForCreate() {
    return DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(this);
  }
}

extension NumExtension on num {
  num floorAsFixedTwo() {
    if (!toString().contains('.')) {
      return this;
    }
    int decimalIndex = toString().indexOf('.');
    final decimalNumbers = toString().split('.').last;
    if (decimalNumbers.length < 3) {
      return this;
    }
    return toString().substring(0, decimalIndex + 3).textToNum();
  }
}
