import 'package:desktop_test/data/vms/issue_stock/main_stock.dart';

abstract class MainStockDao {
  Future saveMainStock(MainStock mainStock);
  List<MainStock>? getMainStockFromDatabase();
  Stream<List<MainStock>?> getMainStockFromDatabaseStream();
  Stream watchMainStock();
  Future deleteMainStocks();
  void deleteSelectedMainStock(String gglCode);
}
