
import '../../../data/vms/language_model/language_model.dart';

abstract class LanguageDao{
  void saveLanguageState(Language language);

  Language? getLanguageState();
}