import 'package:desktop_test/data/vms/customer_payment/customer_payment.dart';
import 'package:desktop_test/data/vms/customer_payment/grouped_customer_payment.dart';
import 'package:desktop_test/data/vms/gold_price/gold_price.dart';
import 'package:desktop_test/data/vms/issue_stock/issue_stock_vm.dart';
import 'package:desktop_test/data/vms/issue_stock/item_type.dart';
import 'package:desktop_test/data/vms/issue_stock/main_stock.dart';
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

import '../../data/vms/access_token/access_token.dart';
import '../../data/vms/user/user.dart';
import '../api/dio_service/dio_service.dart';
import '../api/dio_service/remote_service.dart';
import 'gg_luck_data_agent.dart';

class GgLuckDataAgentImpl extends GgLuckDataAgent {
  GgLuckDataAgentImpl._();
  static final GgLuckDataAgentImpl _singleton = GgLuckDataAgentImpl._();
  factory GgLuckDataAgentImpl() => _singleton;

  //instant variable
  final RemoteService _remoteService = DioService();
  @override
  Future<AccessToken?> accessToken(String userName, String password) {
    return _remoteService
        .accessToken(userName, password)
        .then((value) => value);
  }

  @override
  Future<List<IssueStockVM>?> getIssues() => _remoteService.getIssues();

  @override
  Future<List<UserVM>?> getCustomers() =>
      _remoteService.getCustomers().then((value) {
        List<UserVM>? customers = (value['customers'] as List)
            .map((e) => UserVM.fromJson(e))
            .toList();
        return customers;
      });

  @override
  Future<SaleVoucherVM?> postSaleVoucher(SaleVoucherVM saleVoucher) =>
      _remoteService.createSaleVoucher(saleVoucher);

  @override
  Future<int?> deleteSaleVoucher(String voucherNo, String remark) {
    return _remoteService.deleteSaleVoucher(voucherNo, remark);
  }

  @override
  Future<List<GroupedReturnVoucher>?> getReturnVouchers(String startDate,
      String endDate, String query, String category, String mode) {
    return _remoteService.getReturnVouchers(
        startDate, endDate, query, category, mode);
  }

  @override
  Future<List<MainStock>?> getMainStock() {
    return _remoteService.getMainStock().then((value) => value);
  }

  @override
  Future<int?> createReturnVoucher(ReturnVoucherVM returnVoucherVM) =>
      _remoteService.createReturnVoucher(returnVoucherVM);

  @override
  Future refreshToken() async {
    return _remoteService.refreshToken();
  }

  @override
  Future<List<GoldPrice>?> getGoldPrice() => _remoteService.getGoldPrice();

  @override
  Future<List<GroupedSaleVoucher>?> getSaleVouchers(
          String startDate, String endDate, String query, String category) =>
      _remoteService.getSaleVouchers(startDate, endDate, query, category);

  @override
  Future<List<ItemType>?> getItemType() => _remoteService.getItemType();

  @override
  Future<List<SaleVoucherDetailVM>?> getSaleVouchersDetail(String saleVno) =>
      _remoteService.getSaleVoucherDetail(saleVno);

  @override
  Future<List<ReturnVoucherDetailVM>?> getReturnVouchersDetail(
          String returnVno) =>
      _remoteService.getReturnVouchersDetail(returnVno);

  @override
  Future<int?> createTransferVoucher(TransferVoucherVM transferVno) =>
      _remoteService.createTransferVoucher(transferVno);

  @override
  Future<List<UserVM>?> getMarketingUsers() =>
      _remoteService.getMarketingUsers();

  @override
  Future<List<GroupedSaleVoucher>?> getSaleVouchersByCustomer(
          String customerId, String startDate, String endDate, String search) =>
      _remoteService.getSaleVouchersByCustomer(
          customerId, startDate, endDate, search);

  @override
  Future<List<GroupedReturnVoucher>?> getReturnVouchersByCustomer(
          String customerId, String startDate, String endDate, String search) =>
      _remoteService.getReturnVouchersByCustomer(
          customerId, startDate, endDate, search);

  @override
  Future<List<GroupedCustomerPayment>?> getCustomerPaymentsByCustomer(
          String customerId, String startDate, String endDate, String search) =>
      _remoteService.getCustomerPaymentsByCustomer(
          customerId, startDate, endDate, search);

  @override
  Future<int?> createCustomerPayment(CustomerPayment customerPayment) =>
      _remoteService.createCustomerPayment(customerPayment);

  @override
  Future<List<GroupedCustomerPayment>?> getCustomerPayments(
          String startDate, String endDate, String search, String mode) =>
      _remoteService.getCustomerPayments(startDate, endDate, search, mode);

  @override
  Future<int?> registerNotification(NotificationToken notiToken) =>
      _remoteService.registerNotification(notiToken);

  @override
  Future<List<GroupedTransferVoucher>?> getTransferReports(String startDate,
          String endDate, String search, String type, String mode) =>
      _remoteService.getTransferReports(startDate, endDate, search, type, mode);

  @override
  Future<List<TransferVoucherDetailVM>?> getTransferVoucherDetail(
          String transferVno) =>
      _remoteService.getTransferVoucherDetail(transferVno);

  @override
  Future<int?> deleteReturnVoucher(String voucherNo, String deleteRemark) =>
      _remoteService.deleteReturnVoucher(voucherNo, deleteRemark);

  @override
  Future<int?> deleteCustomerPayment(String vNo, String remark) =>
      _remoteService.deleteCustomerPayment(vNo, remark);

  @override
  Future<int?> deleteTransferVoucher(String vNo) =>
      _remoteService.deleteTransferVoucher(vNo);

  @override
  Future<List<GroupedTransferVoucher>?> getReceivedTransferVouchers(
          String searchText) =>
      _remoteService.getReceivedTransferVouchers(searchText);

  @override
  Future<void> receiveTransferVoucher(String transferVno, String remark) =>
      _remoteService.receiveTransferVoucher(transferVno, remark);

  @override
  Future<bool?> checkDeviceSerial(String serialNo) =>
      _remoteService.checkDeviceSerial(serialNo);

  @override
  Future<List<IssueStockVM>?> getCustomerIssueStocks() =>
      _remoteService.getCustomerIssueStocks();
}
