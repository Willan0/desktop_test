import 'package:desktop_test/data/vms/access_token/access_token.dart';
import 'package:desktop_test/data/vms/issue_stock/issue_stock_vm.dart';
import 'package:desktop_test/data/vms/notification/noti_vm.dart';
import 'package:desktop_test/data/vms/return_voucher/grouped_return_voucher.dart';
import 'package:desktop_test/data/vms/user/user.dart';

import '../../vms/customer_payment/customer_payment.dart';
import '../../vms/customer_payment/grouped_customer_payment.dart';
import '../../vms/gold_price/gold_price.dart';
import '../../vms/issue_stock/item_type.dart';
import '../../vms/issue_stock/main_stock.dart';
import '../../vms/language_model/language_model.dart';
import '../../vms/notification/notification_token.dart';
import '../../vms/return_voucher/return_voucher.dart';
import '../../vms/return_voucher/return_voucher_detail_vm.dart';
import '../../vms/sale_voucher/grouped_sale_voucher.dart';
import '../../vms/sale_voucher/sale_voucher.dart';
import '../../vms/sale_voucher/sale_voucher_detail.dart';
import '../../vms/transfer_voucher/grouped_transfer_voucher.dart';
import '../../vms/transfer_voucher/transfer_voucher.dart';
import '../../vms/transfer_voucher/transfer_voucher_detail.dart';

abstract class GgLuckDataApply {
  // network
  Future<AccessToken?> postAccessToken(String userName, String password);
  Future<List<IssueStockVM>?> getIssues();
  Future<SaleVoucherVM?> postSaleVoucher(SaleVoucherVM saleVoucher);
  Future<List<UserVM>?> getCustomers();
  Future<List<GroupedSaleVoucher>?> getSaleVouchers(
      String startDate, String endDate, String query, String category);
  Future<int?> deleteSaleVoucher(String voucherNo, String remark);
  Future<List<GroupedReturnVoucher>?> getReturnVouchers(String startDate,
      String endDate, String query, String category, String mode);
  Future<int?> deleteReturnVoucher(String voucherNo, String deleteRemark);
  Future<List<MainStock>?> getMainStock();
  Future<int?> createReturnVoucher(ReturnVoucherVM returnVoucherVM);
  Future<dynamic> refreshToken();
  Future<List<GoldPrice>?> getGoldPrice();
  Future<List<ItemType>?> getItemType();
  Future<List<SaleVoucherDetailVM>?> getSaleVouchersDetail(String saleVno);
  Future<List<ReturnVoucherDetailVM>?> getReturnVouchersDetail(
      String returnVno);
  Future<int?> createTransferVoucher(TransferVoucherVM transferVno);
  Future<List<UserVM>?> getMarketingUsers();
  Future<List<GroupedSaleVoucher>?> getSaleVouchersByCustomer(
      String customerId, String startDate, String endDate, String search);
  Future<List<GroupedReturnVoucher>?> getReturnVouchersByCustomer(
      String customerId, String startDate, String endDate, String search);
  Future<List<GroupedCustomerPayment>?> getCustomerPaymentsByCustomer(
      String customerId, String startDate, String endDate, String search);
  Future<int?> createCustomerPayment(CustomerPayment customerPayment);
  Future<List<GroupedCustomerPayment>?> getCustomerPayments(
      String startDate, String endDate, String search, String mode);
  Future<int?> registerNotification(NotificationToken notiToken);
  Future<List<GroupedTransferVoucher>?> getTransferReports(String startDate,
      String endDate, String search, String type, String mode);
  Future<List<TransferVoucherDetailVM>?> getTransferVoucherDetail(
      String transferVno);
  Future<int?> deleteCustomerPayment(String vNo, String remark);
  Future<int?> deleteTransferVoucher(String vNo);
  Future<List<GroupedTransferVoucher>?> getReceivedTransferVouchers(
      String searchText);
  Future<void> receiveTransferVoucher(String transferVno, String remark);
  Future<bool?> checkDeviceSerial(String serialNo);

  //persistent

  void saveAccessTokenUser(AccessToken accessToken);

  Stream<AccessToken?> getAccessTokenFromDataBase();

  Future<void> deleteAccessToken();

  void saveSelectedIssueItem(IssueStockVM issue);

  Stream<List<IssueStockVM>?> getSelectedIssues();

  void saveSelectedCustomer(UserVM customer);

  Stream<UserVM?> getCustomerFromStreamDataBase();

  Future<void> deleteSelectedIssues();

  void deleteSelectedCustomer();

  Future<void> deleteSelectIssue(String gglCode);

  Future<void> saveMainStock(MainStock mainStock);

  Stream<List<MainStock>?> getMainStockFromDatabaseStream();

  Future<int?> deleteSelectedMainStocks();

  Future<int> saveNotification(NotificationVM notification);

  Future<List<NotificationVM>?> getNotificationFromDatabase();

  void saveLanguageState(Language language);

  Language? getLanguageState();

  void deleteSelectedMainStock(String gglCode);

  Future<List<IssueStockVM>?> getCustomerIssueStocks();
}
