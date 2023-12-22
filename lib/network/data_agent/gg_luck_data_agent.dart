import 'package:desktop_test/data/vms/issue_stock/issue_stock_vm.dart';
import 'package:desktop_test/data/vms/return_voucher/return_voucher_detail_vm.dart';
import 'package:desktop_test/data/vms/sale_voucher/sale_voucher_detail.dart';
import 'package:desktop_test/data/vms/transfer_voucher/transfer_voucher.dart';
import 'package:desktop_test/data/vms/user/user.dart';

import '../../data/vms/access_token/access_token.dart';
import '../../data/vms/customer_payment/customer_payment.dart';
import '../../data/vms/customer_payment/grouped_customer_payment.dart';
import '../../data/vms/gold_price/gold_price.dart';
import '../../data/vms/issue_stock/item_type.dart';
import '../../data/vms/issue_stock/main_stock.dart';
import '../../data/vms/notification/notification_token.dart';
import '../../data/vms/return_voucher/grouped_return_voucher.dart';
import '../../data/vms/return_voucher/return_voucher.dart';
import '../../data/vms/sale_voucher/grouped_sale_voucher.dart';
import '../../data/vms/sale_voucher/sale_voucher.dart';
import '../../data/vms/transfer_voucher/grouped_transfer_voucher.dart';
import '../../data/vms/transfer_voucher/transfer_voucher_detail.dart';

abstract class GgLuckDataAgent {
  Future<AccessToken?> accessToken(String userName, String password);
  Future<SaleVoucherVM?> postSaleVoucher(SaleVoucherVM saleVoucher);
  Future<int?> deleteSaleVoucher(String voucherNo, String remark);
  Future<int?> createReturnVoucher(ReturnVoucherVM returnVoucherVM);
  Future<int?> deleteReturnVoucher(String voucherNo, String deleteRemark);
  Future<int?> createTransferVoucher(TransferVoucherVM transferVno);
  Future<dynamic> refreshToken();
  Future<int?> createCustomerPayment(CustomerPayment customerPayment);
  Future<int?> registerNotification(NotificationToken notiToken);
  Future<int?> deleteCustomerPayment(String vNo, String remark);
  Future<int?> deleteTransferVoucher(String vNo);
  Future<void> receiveTransferVoucher(String transferVno, String remark);
  Future<bool?> checkDeviceSerial(String serialNo);

  Future<List<IssueStockVM>?> getIssues();
  Future<List<UserVM>?> getCustomers();
  Future<List<GroupedSaleVoucher>?> getSaleVouchers(
      String startDate, String endDate, String query, String category);
  Future<List<GroupedReturnVoucher>?> getReturnVouchers(String startDate,
      String endDate, String query, String category, String mode);
  Future<List<MainStock>?> getMainStock();
  Future<List<GoldPrice>?> getGoldPrice();
  Future<List<ItemType>?> getItemType();
  Future<List<SaleVoucherDetailVM>?> getSaleVouchersDetail(String saleVno);
  Future<List<ReturnVoucherDetailVM>?> getReturnVouchersDetail(
      String returnVno);
  Future<List<UserVM>?> getMarketingUsers();
  Future<List<GroupedSaleVoucher>?> getSaleVouchersByCustomer(
      String customerId, String startDate, String endDate, String search);
  Future<List<GroupedReturnVoucher>?> getReturnVouchersByCustomer(
      String customerId, String startDate, String endDate, String search);
  Future<List<GroupedCustomerPayment>?> getCustomerPaymentsByCustomer(
      String customerId, String startDate, String endDate, String search);
  Future<List<GroupedCustomerPayment>?> getCustomerPayments(
      String startDate, String endDate, String search, String mode);
  Future<List<GroupedTransferVoucher>?> getTransferReports(String startDate,
      String endDate, String search, String type, String mode);
  Future<List<GroupedTransferVoucher>?> getReceivedTransferVouchers(
      String searchText);
  Future<List<TransferVoucherDetailVM>?> getTransferVoucherDetail(
      String transferVno);
  Future<List<IssueStockVM>?> getCustomerIssueStocks();
}
