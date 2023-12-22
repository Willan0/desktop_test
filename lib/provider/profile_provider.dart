// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:desktop_test/data/data_apply/data_apply/gg_luck_data_apply.dart';
import 'package:desktop_test/data/data_apply/data_apply/gg_luck_data_apply_imp.dart';
import 'package:desktop_test/main.dart';
import 'package:desktop_test/utils/extension.dart';

class ProfileProvider extends ChangeNotifier {
  bool _isDispose = false;
  num _gold16K = 0;
  num get gold16K => _gold16K;

  final GgLuckDataApply _ggLuckDataApply = GgLuckDataApplyImpl();
  ProfileProvider() {
    get16GoldPrice();
  }

  void get16GoldPrice() async {
    final temp = await _ggLuckDataApply.getGoldPrice();
    if (temp?.isNotEmpty ?? false) {
      for (var price in temp!) {
        if (price.stateId == 'AC') _gold16K = price.goldPrice ?? 0;
      }
      notifyListeners();
    } else {
      BuildContext? context = MyApp.navigatorKey.currentState?.context;
      context?.showErrorDialog(context,
          errorMessage: AppLocalizations.of(context)!.no_update_gold_price,
          onPressed: () {
        context.popScreen();
      });
      _gold16K = 0;
      notifyListeners();
    }
  }

  @override
  void notifyListeners() {
    if (!_isDispose) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _isDispose = true;
    super.dispose();
  }
}
