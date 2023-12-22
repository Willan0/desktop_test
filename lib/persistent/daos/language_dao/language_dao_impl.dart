import 'package:desktop_test/constant/dao_constant.dart';
import 'package:desktop_test/persistent/daos/language_dao/language_dao.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../data/vms/language_model/language_model.dart';

class LanguageDaoImpl extends LanguageDao {
  LanguageDaoImpl._();

  static final LanguageDaoImpl _singleton = LanguageDaoImpl._();

  factory LanguageDaoImpl() => _singleton;

  final Box<Language> _languageBox = Hive.box(kBoxNameForLanguage);
  @override
  Language? getLanguageState() => _languageBox.get('1');

  @override
  void saveLanguageState(Language language) {
    _languageBox.put('1', language);
  }
}
