import 'package:desktop_test/data/vms/issue_stock/issue_stock_vm.dart';

abstract class IssueStockDao {
  void saveIssue(IssueStockVM issue);

  List<IssueStockVM>? getIssuesFromDataBase();

  Stream<List<IssueStockVM>?> getIssuesFromDataBaseStream();

  Stream watchIssue();

  Future deleteSelectIssue(String gglCode);

  Future deleteIssues();
}
