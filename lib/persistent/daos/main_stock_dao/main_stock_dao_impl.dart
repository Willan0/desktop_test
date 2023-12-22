import 'package:desktop_test/constant/dao_constant.dart';
import 'package:desktop_test/data/vms/issue_stock/main_stock.dart';
import 'package:desktop_test/persistent/daos/main_stock_dao/main_stock_dao.dart';
import 'package:hive/hive.dart';

class MainStockDaoImpl extends MainStockDao {
  MainStockDaoImpl._();
  static final MainStockDaoImpl _singleton = MainStockDaoImpl._();
  factory MainStockDaoImpl() => _singleton;
  final Box<MainStock> _mainStockBox = Hive.box(kBoxNameForMainStock);
  @override
  List<MainStock>? getMainStockFromDatabase() => _mainStockBox.values.toList();

  @override
  Stream<List<MainStock>?> getMainStockFromDatabaseStream() =>
      Stream.value(getMainStockFromDatabase());

  @override
  Future saveMainStock(MainStock mainStock) async {
    await _mainStockBox.put(mainStock.gglCode, mainStock);
  }

  @override
  Stream watchMainStock() => _mainStockBox.watch();

  @override
  Future<int?> deleteMainStocks() async {
    return await _mainStockBox.clear();
  }

  @override
  void deleteSelectedMainStock(String gglCode) {
    _mainStockBox.delete(gglCode);
  }
}
