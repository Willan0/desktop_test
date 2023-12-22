import 'package:flutter/material.dart';
import 'package:desktop_test/data/data_apply/data_apply/gg_luck_data_apply.dart';
import 'package:desktop_test/data/data_apply/data_apply/gg_luck_data_apply_imp.dart';

import '../data/vms/language_model/language_model.dart';

class LanguageProvider extends ChangeNotifier {
  bool _isDispose = false;
  Locale? _locale;
  Language _language = Language.english;

  final GgLuckDataApply _ggLuckDataApply = GgLuckDataApplyImpl();
  Locale? get locale => _locale;
  LanguageProvider() {
    _locale = const Locale('en');
    if (_ggLuckDataApply.getLanguageState() != null) {
      _language = _ggLuckDataApply.getLanguageState() ?? Language.english;
      if (_language == Language.myanmar) {
        _locale = const Locale('my');
      }
    }
  }

  void changeLanguage(Locale locale, language) {
    _locale = locale;
    _language = language;
    _ggLuckDataApply.saveLanguageState(language);
    notifyListeners();
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

  Language get language => _language;
}
