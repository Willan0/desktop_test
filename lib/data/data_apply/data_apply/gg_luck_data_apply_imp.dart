import 'package:desktop_test/data/vms/access_token/access_token.dart';
import 'package:desktop_test/data/vms/customer_payment/customer_payment.dart';
import 'package:desktop_test/data/vms/customer_payment/grouped_customer_payment.dart';
import 'package:desktop_test/data/vms/gold_price/gold_price.dart';
import 'package:desktop_test/data/vms/issue_stock/issue_stock_vm.dart';
import 'package:desktop_test/data/vms/issue_stock/item_type.dart';
import 'package:desktop_test/data/vms/issue_stock/main_stock.dart';
import 'package:desktop_test/data/vms/notification/noti_vm.dart';
import 'package:desktop_test/data/vms/notification/notification_token.dart';
import 'package:desktop_test/data/vms/return_voucher/grouped_return_voucher.dart';
import 'package:desktop_test/data/vms/return_voucher/return_voucher.dart';
import 'package:desktop_test/data/vms/return_voucher/return_voucher_detail_vm.dart';
import 'package:desktop_test/data/vms/sale_voucher/grouped_sale_voucher.dart';
import 'package:desktop_test/data/vms/sale_voucher/sale_voucher.dart';
import 'package:desktop_test/data/vms/sale_voucher/sale_voucher_detail.dart';
import 'package:desktop_test/data/vms/transfer_voucher/grouped_transfer_voucher.dart';
import 'package:desktop_test/data/vms/transfer_voucher/transfer_voucher.dart';
import 'package:desktop_test/data/vms/transfer_voucher/transfer_voucher_detail.dart';
import 'package:desktop_test/data/vms/user/user.dart';
import 'package:desktop_test/persistent/daos/customer_dao/customer_dao.dart';
import 'package:desktop_test/persistent/daos/customer_dao/customer_dao_impl.dart';
import 'package:desktop_test/persistent/daos/language_dao/language_dao.dart';
import 'package:desktop_test/persistent/daos/language_dao/language_dao_impl.dart';
import 'package:desktop_test/persistent/daos/main_stock_dao/main_stock_dao.dart';
import 'package:desktop_test/persistent/daos/main_stock_dao/main_stock_dao_impl.dart';
import 'package:desktop_test/persistent/daos/user_dao/access_token_dao.dart';
import 'package:desktop_test/persistent/daos/user_dao/access_token_dao_impl.dart';
import 'package:desktop_test/persistent/table/notification_table.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../../network/data_agent/gg_luck_data_agent.dart';
import '../../../network/data_agent/gg_luck_data_agent_impl.dart';
import '../../../persistent/daos/issue_dao/issue_dao.dart';
import '../../../persistent/daos/issue_dao/issue_dao_impl.dart';
import '../../vms/language_model/language_model.dart';
import 'gg_luck_data_apply.dart';

class GgLuckDataApplyImpl extends GgLuckDataApply {
  GgLuckDataApplyImpl._();
  static final GgLuckDataApplyImpl _singleton = GgLuckDataApplyImpl._();
  factory GgLuckDataApplyImpl() => _singleton;

  // instance variable

  final GgLuckDataAgent _ggLuckDataAgent = GgLuckDataAgentImpl();

  final AccessTokenDao _accessTokenDao = AccessTokenDaoImpl();

  final IssueStockDao _issueStockDao = IssueStockDaoImpl();

  final CustomerDao _customerDao = CustomerDaoImpl();

  final MainStockDao _mainStockDao = MainStockDaoImpl();

  final LanguageDao _languageDao = LanguageDaoImpl();

  final NotificationTable _notificationTable = NotificationTable();
  @override
  Future<AccessToken?> postAccessToken(String userName, String password) {
    return _ggLuckDataAgent.accessToken(userName, password).then((accessToken) {
      return accessToken;
    });
  }

  @override
  Stream<AccessToken?> getAccessTokenFromDataBase() => _accessTokenDao
      .watchUser()
      .startWith(_accessTokenDao.getTokenFromStreamDataBase())
      .map((event) => _accessTokenDao.getTokenFromDatabase());

  @override
  Future<void> deleteAccessToken() => _accessTokenDao.deleteAccessToken();

  @override
  Future<List<IssueStockVM>?> getIssues() {
    return _ggLuckDataAgent.getIssues();
  }

  @override
  Stream<List<IssueStockVM>?> getSelectedIssues() => _issueStockDao
      .watchIssue()
      .startWith(_issueStockDao.getIssuesFromDataBaseStream())
      .map((event) => _issueStockDao.getIssuesFromDataBase());

  @override
  void saveSelectedIssueItem(IssueStockVM issue) {
    _issueStockDao.saveIssue(issue);
  }

  @override
  Future<List<UserVM>?> getCustomers() => _ggLuckDataAgent.getCustomers();

  @override
  Future<SaleVoucherVM?> postSaleVoucher(SaleVoucherVM saleVoucher) =>
      _ggLuckDataAgent.postSaleVoucher(saleVoucher);

  @override
  void saveSelectedCustomer(UserVM customer) => _customerDao.save(customer);

  @override
  Stream<UserVM?> getCustomerFromStreamDataBase() {
    return _customerDao
        .wathCustomer()
        .startWith(_customerDao.getCustomerFromDataBaseStream())
        .map((event) => _customerDao.getCustomerFromDataBase());
  }

  @override
  void deleteSelectedCustomer() {
    _customerDao.deleteCustomer();
  }

  @override
  Future<void> deleteSelectedIssues() async {
    await _issueStockDao.deleteIssues();
  }

  @override
  Future<List<GroupedSaleVoucher>?> getSaleVouchers(
          String startDate, String endDate, String query, String category) =>
      _ggLuckDataAgent.getSaleVouchers(startDate, endDate, query, category);

  @override
  Future<int?> deleteSaleVoucher(String voucherNo, String remark) {
    return _ggLuckDataAgent.deleteSaleVoucher(voucherNo, remark);
  }

  @override
  Future deleteSelectIssue(String gglCode) {
    return _issueStockDao.deleteSelectIssue(gglCode);
  }

  @override
  Future<List<GroupedReturnVoucher>?> getReturnVouchers(String startDate,
      String endDate, String query, String category, String mode) {
    return _ggLuckDataAgent.getReturnVouchers(
        startDate, endDate, query, category, mode);
  }

  @override
  Future<List<MainStock>?> getMainStock() {
    return _ggLuckDataAgent.getMainStock();
  }

  @override
  Stream<List<MainStock>?> getMainStockFromDatabaseStream() => _mainStockDao
      .watchMainStock()
      .startWith(_mainStockDao.getMainStockFromDatabaseStream())
      .map((event) => _mainStockDao.getMainStockFromDatabase());

  @override
  Future<void> saveMainStock(MainStock mainStock) async {
    await _mainStockDao.saveMainStock(mainStock);
  }

  @override
  Future<int?> createReturnVoucher(ReturnVoucherVM returnVoucherVM) =>
      _ggLuckDataAgent.createReturnVoucher(returnVoucherVM);

  @override
  Future<int?> deleteSelectedMainStocks() async =>
      await _mainStockDao.deleteMainStocks();

  @override
  Future refreshToken() => _ggLuckDataAgent.refreshToken();

  @override
  Future<List<GoldPrice>?> getGoldPrice() => _ggLuckDataAgent.getGoldPrice();

  @override
  Future<int> saveNotification(NotificationVM notification) async =>
      await _notificationTable.insert(notification);

  @override
  Future<List<NotificationVM>?> getNotificationFromDatabase() async =>
      await _notificationTable.getNotifications();

  @override
  Future<List<ItemType>?> getItemType() => _ggLuckDataAgent.getItemType();

  @override
  Future<List<SaleVoucherDetailVM>?> getSaleVouchersDetail(String saleVno) =>
      _ggLuckDataAgent.getSaleVouchersDetail(saleVno);

  @override
  Future<List<ReturnVoucherDetailVM>?> getReturnVouchersDetail(
          String returnVno) =>
      _ggLuckDataAgent.getReturnVouchersDetail(returnVno);

  @override
  Future<int?> createTransferVoucher(TransferVoucherVM transferVno) =>
      _ggLuckDataAgent.createTransferVoucher(transferVno);

  @override
  Future<List<UserVM>?> getMarketingUsers() =>
      _ggLuckDataAgent.getMarketingUsers();

  @override
  Future<List<GroupedSaleVoucher>?> getSaleVouchersByCustomer(
          String customerId, String startDate, String endDate, String search) =>
      _ggLuckDataAgent.getSaleVouchersByCustomer(
          customerId, startDate, endDate, search);

  @override
  Future<List<GroupedReturnVoucher>?> getReturnVouchersByCustomer(
          String customerId, String startDate, String endDate, String search) =>
      _ggLuckDataAgent.getReturnVouchersByCustomer(
          customerId, startDate, endDate, search);

  @override
  Future<List<GroupedCustomerPayment>?> getCustomerPaymentsByCustomer(
          String customerId, String startDate, String endDate, String search) =>
      _ggLuckDataAgent.getCustomerPaymentsByCustomer(
          customerId, startDate, endDate, search);

  @override
  Future<int?> createCustomerPayment(CustomerPayment customerPayment) =>
      _ggLuckDataAgent.createCustomerPayment(customerPayment);

  @override
  Future<List<GroupedCustomerPayment>?> getCustomerPayments(
          String startDate, String endDate, String search, String mode) =>
      _ggLuckDataAgent.getCustomerPayments(startDate, endDate, search, mode);

  @override
  void saveAccessTokenUser(AccessToken accessToken) {
    _accessTokenDao.saveUser(accessToken);
  }

  @override
  Future<int?> registerNotification(NotificationToken notiToken) =>
      _ggLuckDataAgent.registerNotification(notiToken);

  @override
  Future<List<GroupedTransferVoucher>?> getTransferReports(String startDate,
          String endDate, String search, String type, String mode) =>
      _ggLuckDataAgent.getTransferReports(
          startDate, endDate, search, type, mode);

  @override
  Future<List<TransferVoucherDetailVM>?> getTransferVoucherDetail(
          String transferVno) =>
      _ggLuckDataAgent.getTransferVoucherDetail(transferVno);

  @override
  Future<int?> deleteReturnVoucher(String voucherNo, String deleteRemark) =>
      _ggLuckDataAgent.deleteReturnVoucher(voucherNo, deleteRemark);

  @override
  Future<int?> deleteCustomerPayment(String vNo, String remark) =>
      _ggLuckDataAgent.deleteCustomerPayment(vNo, remark);

  @override
  Future<int?> deleteTransferVoucher(String vNo) =>
      _ggLuckDataAgent.deleteTransferVoucher(vNo);

  @override
  Future<List<GroupedTransferVoucher>?> getReceivedTransferVouchers(
          String searchText) =>
      _ggLuckDataAgent.getReceivedTransferVouchers(searchText);

  @override
  Future<void> receiveTransferVoucher(String transferVno, String remark) =>
      _ggLuckDataAgent.receiveTransferVoucher(transferVno, remark);

  @override
  void saveLanguageState(Language language) =>
      _languageDao.saveLanguageState(language);

  @override
  Language? getLanguageState() => _languageDao.getLanguageState();

  @override
  Future<bool?> checkDeviceSerial(String serialNo) =>
      _ggLuckDataAgent.checkDeviceSerial(serialNo);

  @override
  void deleteSelectedMainStock(String gglCode) =>
      _mainStockDao.deleteSelectedMainStock(gglCode);

  @override
  Future<List<IssueStockVM>?> getCustomerIssueStocks() =>
      _ggLuckDataAgent.getCustomerIssueStocks();
}
