import 'package:desktop_test/constant/dao_constant.dart';
import 'package:desktop_test/data/vms/issue_stock/issue_stock_vm.dart';
import 'package:desktop_test/persistent/daos/issue_dao/issue_dao.dart';
import 'package:hive_flutter/hive_flutter.dart';

class IssueStockDaoImpl extends IssueStockDao {
  IssueStockDaoImpl._();
  static final IssueStockDaoImpl _singleton = IssueStockDaoImpl._();
  factory IssueStockDaoImpl() => _singleton;

  final Box<IssueStockVM> _issueBox = Hive.box<IssueStockVM>(kBoxNameForIssue);
  @override
  List<IssueStockVM>? getIssuesFromDataBase() => _issueBox.values.toList();

  @override
  Stream<List<IssueStockVM>?> getIssuesFromDataBaseStream() =>
      Stream.value(getIssuesFromDataBase());

  @override
  void saveIssue(IssueStockVM issue) {
    _issueBox.put(issue.gglCode, issue);
  }

  @override
  Stream watchIssue() => _issueBox.watch();

  @override
  Future deleteIssues() async {
    await _issueBox.clear();
  }

  @override
  Future deleteSelectIssue(String gglCode) async {
    await _issueBox.delete(gglCode);
  }
}
