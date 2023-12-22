import 'package:desktop_test/constant/dao_constant.dart';
import 'package:hive/hive.dart';
part 'language_model.g.dart';

@HiveType(typeId: kTypeIdForLanguage)
enum Language {
  @HiveField(0)
  english,

  @HiveField(1)
  myanmar
}
