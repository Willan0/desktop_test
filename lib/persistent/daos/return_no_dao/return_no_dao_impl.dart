import 'package:desktop_test/constant/dao_constant.dart';
import 'package:desktop_test/persistent/daos/return_no_dao/return_no_dao.dart';
import 'package:hive/hive.dart';

class ReturnNoDaoImpl extends ReturnNoDao {
  ReturnNoDaoImpl._();
  static final ReturnNoDaoImpl _singleton = ReturnNoDaoImpl._();
  factory ReturnNoDaoImpl() => _singleton;
  final String _key = "Return_Vno";

  final Box<int> _returnNoBox = Hive.box(kBoxNameForReturnVno);
  @override
  int? getReturnVno() => _returnNoBox.get(_key);

  @override
  void saveReturnDao(int returnVno) {
    _returnNoBox.put(_key, returnVno);
  }
}
