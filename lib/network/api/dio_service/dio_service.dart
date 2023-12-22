import 'package:dio/dio.dart';
import 'package:desktop_test/constant/api_constant.dart';
import 'package:desktop_test/data/vms/access_token/access_token.dart';
import 'package:desktop_test/data/vms/customer_payment/customer_payment.dart';
import 'package:desktop_test/data/vms/customer_payment/grouped_customer_payment.dart';
import 'package:desktop_test/data/vms/gold_price/gold_price.dart';
import 'package:desktop_test/data/vms/issue_stock/issue_stock_vm.dart';
import 'package:desktop_test/data/vms/issue_stock/item_type.dart';
import 'package:desktop_test/data/vms/issue_stock/main_stock.dart';
import 'package:desktop_test/data/vms/notification/notification_token.dart';
import 'package:desktop_test/data/vms/return_voucher/return_voucher.dart';
import 'package:desktop_test/data/vms/return_voucher/return_voucher_detail_vm.dart';
import 'package:desktop_test/data/vms/sale_voucher/grouped_sale_voucher.dart';
import 'package:desktop_test/data/vms/sale_voucher/sale_voucher.dart';
import 'package:desktop_test/data/vms/sale_voucher/sale_voucher_detail.dart';
import 'package:desktop_test/data/vms/transfer_voucher/grouped_transfer_voucher.dart';
import 'package:desktop_test/data/vms/transfer_voucher/transfer_voucher.dart';
import 'package:desktop_test/data/vms/transfer_voucher/transfer_voucher_detail.dart';
import 'package:desktop_test/data/vms/user/user.dart';
import 'package:desktop_test/error_handler/error_handler.dart';
import 'package:desktop_test/network/api/dio_service/exception.dart';
import 'package:desktop_test/network/api/dio_service/remote_service.dart';
import 'package:desktop_test/persistent/daos/user_dao/access_token_dao.dart';
import 'package:desktop_test/persistent/daos/user_dao/access_token_dao_impl.dart';

import '../../../data/vms/return_voucher/grouped_return_voucher.dart';

class DioService extends RemoteService {
  DioService._();

  static final DioService _singleton = DioService._();

  factory DioService() => _singleton;
  final AccessTokenDao _accessDao = AccessTokenDaoImpl();

  @override
  Future<AccessToken?> accessToken(String userName, String password) async {
    try {
      FormData formData = FormData.fromMap({
        'Username': userName,
        'Password': password,
      });

      var response = await Dio().post(
        '$kBaseUrl$kAccessToken',
        data: formData,
        options: Options(headers: {
          'Accept': 'application/json',
          'Content-Type': 'multipart/form-data',
        }),
      );
      if (response.statusCode == 200) {
        return AccessToken.fromJson(response.data["data"]);
      } else {
        return null;
      }
    } on DioException catch (error) {
      await ErrorHandler.handleErrorForLogin(error);
      rethrow;
    }
  }

  @override
  Future<List<IssueStockVM>?> getIssues() async {
    try {
      AccessToken? accessToken = AccessTokenDaoImpl().getTokenFromDatabase();
      var response = await Dio().get('$kBaseUrl$kGetIssue',
          options: Options(headers: {
            'Accept': 'text/plain',
            'Authorization': 'Bearer ${accessToken?.accessToken}'
          }));

      if (response.statusCode == 200 || response.statusCode == 201) {
        List<IssueStockVM>? issues = (response.data['data'] as List)
            .map((issue) => IssueStockVM.fromJson(issue))
            .toList();
        return issues;
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      ErrorHandler.handleError(e);
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> getCustomers() async {
    try {
      AccessToken? accessToken = AccessTokenDaoImpl().getTokenFromDatabase();

      var response = await Dio().get('$kBaseUrl$kGetSaleCustomer',
          options: Options(headers: {
            'accept': 'text/plain',
            'Authorization': 'Bearer ${accessToken?.accessToken}'
          }));
      if (response.statusCode == 200) {
        return response.data['data'];
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<SaleVoucherVM?> createSaleVoucher(SaleVoucherVM saleVoucher) async {
    try {
      var rawData = {
        "saleVno": saleVoucher.saleVno,
        "lat": 0,
        "long": 0,
        "totalQty": saleVoucher.totalQty,
        "customerId": saleVoucher.customerId,
        "totalAmt": saleVoucher.totalAmount,
        "totalGram": saleVoucher.totalGram,
        "totalWasteKyat": saleVoucher.totalWasteKyat,
        "totalWastePae": saleVoucher.totalWastePae,
        "totalWasteYawe": saleVoucher.totalWasteYawe,
        "totalKyat": saleVoucher.totalKyat,
        "totalPae": saleVoucher.totalPae,
        "totalYawe": saleVoucher.totalYawe,
        "kyat16": saleVoucher.kyat16,
        "pae16": saleVoucher.pae16,
        "yawe16": saleVoucher.yawe16,
        "remark": saleVoucher.remark,
        "saleVoDetailsModelList": saleVoucher.saleVoucherDetail
            ?.map((e) => {
                  "saleVno": saleVoucher.saleVno,
                  "gglCode": e.gglCode,
                  "qty": e.qty,
                  "goldPrice": e.goldPrice,
                  "charges": e.charges,
                  "gram": e.gram,
                  "kyat": e.kyat,
                  "pae": e.pae,
                  "yawe": e.yawe,
                  "wasteKyat": e.wasteKyat,
                  "wastePae": e.wastePae,
                  "wasteYawe": e.wasteYawe,
                  "totalKyat": e.totalKyat,
                  "totalPae": e.totalPae,
                  "totalYawe": e.totalYawe,
                  "kyat16": e.kyat16,
                  "pae16": e.pae16,
                  "yawe16": e.yawe16,
                  "totalAmt": e.totalAmt
                })
            .toList()
      };

      AccessToken? accessToken = AccessTokenDaoImpl().getTokenFromDatabase();

      var response = await Dio().post('$kBaseUrl$kCreateVoucher',
          data: rawData,
          options: Options(headers: {
            'Content-Type': 'application/json',
            'accept': 'text/plain',
            'Authorization': 'Bearer ${accessToken?.accessToken}'
          }));
      if (response.statusCode == 200 || response.statusCode == 201) {
        return SaleVoucherVM.fromJson(response.data['data']);
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<GroupedSaleVoucher>?> getSaleVouchers(
      String startDate, String endDate, String query, String category) async {
    try {
      String saleVoucherEndPoint =
          '$kBaseUrl$kGetSaleVoucher?sdate=$startDate&edate=$endDate${query == "" ? "" : "&q=$query"}${category == "" ? "" : "&category=$category"}';
      AccessToken? accessToken = AccessTokenDaoImpl().getTokenFromDatabase();
      var response = await Dio().get(saleVoucherEndPoint,
          options: Options(headers: {
            'accept': 'text/plain',
            'Authorization': 'Bearer ${accessToken?.accessToken}'
          }));

      if (response.statusCode == 200) {
        List<GroupedSaleVoucher>? saleVouchers = (response.data['data'] as List)
            .map((e) => GroupedSaleVoucher.fromJson(e))
            .toList();
        return saleVouchers;
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<int?> deleteSaleVoucher(String voucherNO, String remark) async {
    try {
      AccessToken? accessToken = AccessTokenDaoImpl().getTokenFromDatabase();
      var response = await Dio().delete(
          '$kBaseUrl$kDeleteSaleVoucher?saleVno=$voucherNO&$remark',
          options: Options(headers: <String, dynamic>{
            'accept': '*/*',
            'Authorization': 'Bearer ${accessToken?.accessToken}'
          }));

      if (response.statusCode == 200) {
        return response.statusCode;
      } else {
        return response.statusCode;
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<GroupedReturnVoucher>?> getReturnVouchers(String startDate,
      String endDate, String query, String category, String mode) async {
    String returnVoucherEndpoint =
        '$kBaseUrl$kGetReturnVoucher?sdate=$startDate&edate=$endDate${query == "" ? "" : "&q=$query"}${category == "" ? "" : "&category=$category"}&mode=$mode';
    try {
      AccessToken? accessToken = AccessTokenDaoImpl().getTokenFromDatabase();
      var response = await Dio().get(returnVoucherEndpoint,
          options: Options(headers: <String, dynamic>{
            "accept": "application/json",
            "Authorization": "Bearer ${accessToken?.accessToken}"
          }));

      if (response.statusCode == 200) {
        List<GroupedReturnVoucher>? returnVouchers =
            (response.data['data'] as List)
                .map((e) => GroupedReturnVoucher.fromJson(e))
                .toList();

        return returnVouchers;
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<int?> createReturnVoucher(ReturnVoucherVM returnVoucherVM) async {
    try {
      var rawData = {
        "returnVno": returnVoucherVM.returnVno,
        "date": returnVoucherVM.date,
        "totalQty": returnVoucherVM.totalQty,
        "lat": returnVoucherVM.lat,
        "long": returnVoucherVM.long,
        "customerId": returnVoucherVM.customerId,
        "createBy": returnVoucherVM.createBy,
        "totalAmt": returnVoucherVM.totalAmt,
        "totalGram": returnVoucherVM.totalGram,
        "totalWasteKyat": returnVoucherVM.totalWasteKyat,
        "totalWastePae": returnVoucherVM.totalWastePae,
        "totalWasteYawe": returnVoucherVM.totalWasteYawe,
        "totalKyat": returnVoucherVM.totalKyat,
        "totalPae": returnVoucherVM.totalPae,
        "totalYawe": returnVoucherVM.totalYawe,
        "kyat16": returnVoucherVM.kyat16,
        "pae16": returnVoucherVM.pae16,
        "yawe16": returnVoucherVM.yawe16,
        "remark": returnVoucherVM.remark,
        "voucherDetailModel": returnVoucherVM.voucherDetailModel
            ?.map((e) => {
                  "returnVno": returnVoucherVM.returnVno,
                  "gglCode": e.gglCode,
                  "qty": e.qty,
                  "goldPrice": e.goldPrice,
                  "gram": e.gram,
                  "kyat": e.kyat,
                  "pae": e.pae,
                  "yawe": e.yawe,
                  "wasteKyat": e.wasteKyat,
                  "wastePae": e.wastePae,
                  "wasteYawe": e.wasteYawe,
                  "totalKyat": e.totalKyat,
                  "totalPae": e.totalPae,
                  "totalYawe": e.totalYawe,
                  "kyat16": e.kyat16,
                  "pae16": e.pae16,
                  "yawe16": e.yawe16,
                  "totalAmt": e.totalAmt
                })
            .toList(),
      };
      AccessToken? accessToken = AccessTokenDaoImpl().getTokenFromDatabase();
      var response = await Dio().post("$kBaseUrl$kCreateReturnVoucher",
          data: rawData,
          options: Options(headers: <String, dynamic>{
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${accessToken?.accessToken}'
          }));
      return response.statusCode;
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<int?> deleteReturnVoucher(
      String voucherNo, String deleteRemark) async {
    try {
      AccessToken? accessToken = AccessTokenDaoImpl().getTokenFromDatabase();
      var response = await Dio().delete(
          "$kBaseUrl$kDeleteReturnVoucher?vno=$voucherNo${deleteRemark.isEmpty ? "" : "&deleteRemark=$deleteRemark"}",
          options: Options(headers: <String, dynamic>{
            "Accept": "text/plain",
            "Authorization": "Bearer ${accessToken?.accessToken}"
          }));
      return response.statusCode;
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<MainStock>?> getMainStock() async {
    try {
      AccessToken? accessToken = AccessTokenDaoImpl().getTokenFromDatabase();
      var response = await Dio().get('$kBaseUrl$kGetMainStock',
          options: Options(headers: {
            "Accept": "application/json",
            "Authorization": "Bearer ${accessToken?.accessToken}"
          }));
      if (response.statusCode == 200) {
        List<MainStock>? mainStocks = (response.data["data"] as List)
            .map((e) => MainStock.fromJson(e))
            .toList();
        return mainStocks;
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future refreshToken() async {
    AccessToken? accessToken = AccessTokenDaoImpl().getTokenFromDatabase();
    try {
      FormData? formData = FormData.fromMap(<String, dynamic>{
        "Access_Token": accessToken?.accessToken,
        "refresh_token": accessToken?.refreshToken
      });
      var response = await Dio().post('$kBaseUrl$kRefreshToken',
          data: formData,
          options: Options(headers: <String, dynamic>{
            "accept": "application/json",
            "Content-Type": "multipart/form-data"
          }));
      if (response.statusCode == 200) {
        AccessToken? accessToken = AccessToken.fromJson(response.data['data']);
        AccessTokenDaoImpl().saveUser(accessToken);
        return accessToken;
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      ErrorHandler.handleError(e);
      throw ServerException();
    }
  }

  @override
  Future<List<GoldPrice>?> getGoldPrice() async {
    try {
      AccessToken? accessToken = _accessDao.getTokenFromDatabase();
      var response = await Dio().get('$kBaseUrl$kGetGoldPrice',
          options: Options(headers: {
            'Accept': 'application/json',
            'Authorization': "Bearer ${accessToken?.accessToken}"
          }));
      List<GoldPrice>? goldPriceList = (response.data['data'] as List)
          .map((e) => GoldPrice.fromJson(e))
          .toList();
      if (response.statusCode == 200) return goldPriceList;
      return null;
    } on DioException catch (e) {
      ErrorHandler.handleErrorForLogin(e);
      return null;
    }
  }

  @override
  Future<List<ItemType>?> getItemType() async {
    try {
      AccessToken? accessToken = _accessDao.getTokenFromDatabase();
      var response = await Dio().get("$kBaseUrl$kGetItemTypes",
          options: Options(headers: <String, dynamic>{
            "Accept": "application/json",
            "Authorization": "Bearer ${accessToken?.accessToken}"
          }));
      if (response.statusCode == 200) {
        List<ItemType>? itemTypes = (response.data["data"] as List)
            .map((e) => ItemType.fromJson(e))
            .toList();
        return itemTypes;
      } else {
        return null;
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<SaleVoucherDetailVM>?> getSaleVoucherDetail(
      String saleVoucherNo) async {
    try {
      AccessToken? accessToken = _accessDao.getTokenFromDatabase();

      var response = await Dio().get(
          "$kBaseUrl$kGetSaleVoucherDetail?saleVno=$saleVoucherNo",
          options: Options(headers: {
            "Accept": "text/plain",
            "Authorization": "Bearer ${accessToken?.accessToken}"
          }));
      if (response.statusCode == 200) {
        List<SaleVoucherDetailVM>? saleVouchersDetail =
            (response.data["data"] as List)
                .map((e) => SaleVoucherDetailVM.fromJson(e))
                .toList();
        return saleVouchersDetail;
      } else {
        return null;
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<ReturnVoucherDetailVM>?> getReturnVouchersDetail(
      String returnVoucherNo) async {
    try {
      AccessToken? accessToken = _accessDao.getTokenFromDatabase();
      var response = await Dio().get(
          '$kBaseUrl$kGetReturnVouchersDetail?returnVno=$returnVoucherNo',
          options: Options(headers: {
            "Accept": "text/plain",
            "Authorization": "Bearer ${accessToken?.accessToken}"
          }));
      if (response.statusCode == 200) {
        List<ReturnVoucherDetailVM>? returnVouchers =
            (response.data["data"] as List)
                .map((e) => ReturnVoucherDetailVM.fromJson(e))
                .toList();
        return returnVouchers;
      } else {
        return null;
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<int?> createTransferVoucher(TransferVoucherVM transferVo) async {
    try {
      AccessToken? accessToken = _accessDao.getTokenFromDatabase();
      var rawData = <String, dynamic>{
        "transferVno": transferVo.transferVno,
        "lat": 0,
        "long": 0,
        "transferUserId": transferVo.transferUserId,
        "transferTo": transferVo.transferTo,
        "totalQty": transferVo.totalQty,
        "totalGram": transferVo.totalGram,
        "totalKyat": transferVo.totalKyat,
        "totalPae": transferVo.totalPae,
        "totalYawe": transferVo.totalYawe,
        "kyat16": transferVo.kyat16,
        "pae16": transferVo.pae16,
        "yawe16": transferVo.yawe16,
        "recepentUserId": transferVo.recepentUserId,
        "transferVoDetails": transferVo.transferVoucherDetail
            ?.map((e) => {
                  "transferVno": transferVo.transferVno,
                  "gglCode": e.gglCode,
                  "qty": e.qty,
                  "gram": e.gram,
                  "kyat": e.kyat,
                  "pae": e.pae,
                  "yawe": e.yawe
                })
            .toList()
      };
      var response = await Dio().post('$kBaseUrl$kCreateTransferVo',
          data: rawData,
          options: Options(headers: {
            "Content-Type": 'application/json',
            'accept': 'text/plain',
            "Authorization": "Bearer ${accessToken?.accessToken}"
          }));
      return response.statusCode;
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<UserVM>?> getMarketingUsers() async {
    try {
      var response = await Dio().get('$kBaseUrl$kGetMarketing',
          options: Options(headers: {"accept": "text/plain"}));
      if (response.statusCode == 200) {
        List<UserVM>? marketingUsers = (response.data["data"] as List)
            .map((e) => UserVM.fromJson(e))
            .toList();
        return marketingUsers;
      }
      return null;
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<GroupedSaleVoucher>?> getSaleVouchersByCustomer(String customerId,
      String startDate, String endDate, String search) async {
    try {
      AccessToken? accessToken = _accessDao.getTokenFromDatabase();
      String kEndpointForSaleVouchersByCustomer =
          '$kBaseUrl$kGetSaleVoucherByCustomer?customerId=$customerId&sdate=$startDate&edate=$endDate${search.isEmpty ? "" : "&searchText=$search"}';
      var response = await Dio().get(kEndpointForSaleVouchersByCustomer,
          options: Options(headers: {
            "accept": "text/plain",
            "Authorization": "Bearer ${accessToken?.accessToken}"
          }));
      if (response.statusCode == 200) {
        List<GroupedSaleVoucher>? saleVouchers = (response.data["data"] as List)
            .map((e) => GroupedSaleVoucher.fromJson(e))
            .toList();
        return saleVouchers;
      } else {
        return null;
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<GroupedReturnVoucher>?> getReturnVouchersByCustomer(
      String customerId,
      String startDate,
      String endDate,
      String search) async {
    try {
      AccessToken? accessToken = _accessDao.getTokenFromDatabase();
      String gettingReturnVoEndPoint =
          '$kBaseUrl$kGetCustomerReturnVouchers?customerId=$customerId&sdate=$startDate&edate=$endDate';
      var response = await Dio().get(gettingReturnVoEndPoint,
          options: Options(headers: {
            "accept": "text/plain",
            "Authorization": "Bearer ${accessToken?.accessToken}"
          }));
      if (response.statusCode == 200) {
        List<GroupedReturnVoucher>? customerReturnVouchers =
            (response.data['data'] as List)
                .map((e) => GroupedReturnVoucher.fromJson(e))
                .toList();
        return customerReturnVouchers;
      } else {
        return null;
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<GroupedCustomerPayment>?> getCustomerPaymentsByCustomer(
      String customerId,
      String startDate,
      String endDate,
      String search) async {
    try {
      AccessToken? accessToken = _accessDao.getTokenFromDatabase();
      String customerPaymentEndPoint =
          '$kBaseUrl$kGetCustomerPayment?customerId=$customerId&sdate=$startDate&edate=$endDate${search.isEmpty ? "" : "&searchText=$search"}';

      var response = await Dio().get(customerPaymentEndPoint,
          options: Options(headers: {
            "accept": "text/plain",
            "Authorization": "Bearer ${accessToken?.accessToken}"
          }));
      if (response.statusCode == 200) {
        return (response.data['data'] as List)
            .map((e) => GroupedCustomerPayment.fromJson(e))
            .toList();
      } else {
        return null;
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<int?> createCustomerPayment(CustomerPayment customerPayment) async {
    try {
      var rawData = {
        "paymentVno": customerPayment.paymentVno,
        "date": customerPayment.date,
        "lat": customerPayment.lat,
        "long": customerPayment.long,
        "customerId": customerPayment.customerId,
        "customerName": customerPayment.customerName,
        "isGold": customerPayment.isGold,
        "isDiscount": customerPayment.isDiscount,
        "goldPrice": customerPayment.goldPrice,
        "totalAmt": customerPayment.totalAmt,
        "gram": customerPayment.gram,
        "kyat": customerPayment.kyat,
        "pae": customerPayment.pae,
        "yawe": customerPayment.yawe,
        "receiveBy": null,
        "remark": customerPayment.remark,
        "deleteDate": null,
        "deleteBy": null,
        "deleteRemark": null
      };
      AccessToken? accessToken = _accessDao.getTokenFromDatabase();
      var response = await Dio().post('$kBaseUrl$kCreateCustomerPayment',
          data: rawData,
          options: Options(headers: <String, dynamic>{
            "accept": "text/plain",
            "Content-Type": "application/json",
            "Authorization": "Bearer ${accessToken?.accessToken}"
          }));
      return response.statusCode;
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<GroupedCustomerPayment>?> getCustomerPayments(
      String startDate, String endDate, String search, String mode) async {
    try {
      AccessToken? accessToken = _accessDao.getTokenFromDatabase();
      String customersPaymentUrl =
          '$kBaseUrl$kGetStatement?sDate=$startDate&eDate=$endDate${search.isEmpty ? "" : '&searchText=$search'}&mode=$mode';
      var response = await Dio().get(customersPaymentUrl,
          options: Options(headers: {
            "accept": "text/plain",
            "Authorization": "Bearer ${accessToken?.accessToken}"
          }));
      return (response.data['data'] as List)
          .map((e) => GroupedCustomerPayment.fromJson(e))
          .toList();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<int?> registerNotification(NotificationToken notiToken) async {
    try {
      AccessToken? accessToken = _accessDao.getTokenFromDatabase();
      FormData? formData = FormData.fromMap({
        "UserId": notiToken.userId,
        "Role": notiToken.role,
        "Platform": 'mobile',
        "NotificationToken": notiToken.notificationToken
      });
      var response = await Dio().post('$kBaseUrl$kRegisterNotiToken',
          data: formData,
          options: Options(headers: {
            "accept": "application/json",
            "Content-Type": "multipart/form-data",
            "Authorization": "Bearer ${accessToken?.accessToken}"
          }));
      return response.statusCode;
    } catch (e) {
      throw UnimplementedError();
    }
  }

  @override
  Future<List<GroupedTransferVoucher>?> getTransferReports(String startDate,
      String endDate, String search, String type, String mode) async {
    try {
      AccessToken? accessToken = _accessDao.getTokenFromDatabase();
      String getTransferReportsEndPoint =
          '$kBaseUrl$kGetTransfersVouchers?sDate=$startDate&eDate=$endDate&mode=$mode${search.isEmpty ? "" : "&q$search"}${type.isEmpty ? "" : "&category=$type"}';
      var response = await Dio().get(getTransferReportsEndPoint,
          options: Options(headers: {
            "accept": "text/plain",
            "Authorization": "Bearer ${accessToken?.accessToken}"
          }));
      return (response.data['data'] as List)
          .map((e) => GroupedTransferVoucher.fromJson(e))
          .toList();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<TransferVoucherDetailVM>?> getTransferVoucherDetail(
      String transferVno) async {
    try {
      AccessToken? accessToken = _accessDao.getTokenFromDatabase();
      var response = await Dio().get(
          '$kBaseUrl$kGetTransferVoucherDetail?transferVno=$transferVno',
          options: Options(headers: {
            "accept": "text/plain",
            "Authorization": "Bearer ${accessToken?.accessToken}"
          }));
      return (response.data['data'] as List)
          .map((e) => TransferVoucherDetailVM.fromJson(e))
          .toList();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<int?> deleteCustomerPayment(String vNo, String remark) async {
    try {
      AccessToken? accessToken = _accessDao.getTokenFromDatabase();

      var response = await Dio().delete(
          '$kBaseUrl$kDeleteCustomerPayment?Vno=$vNo${remark.isEmpty ? "" : "&Deleteremark=$remark"}',
          options: Options(headers: {
            'accept': 'text/plain',
            'Authorization': 'Bearer ${accessToken?.accessToken}'
          }));
      return response.statusCode;
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<int?> deleteTransferVoucher(String vNo) async {
    try {
      AccessToken? accessToken = _accessDao.getTokenFromDatabase();
      var response = await Dio().delete(
          '$kBaseUrl$kDeleteTransferVoucher?transferVno=$vNo',
          options: Options(headers: {
            'accept': 'text/plain',
            'Authorization': 'Bearer ${accessToken?.accessToken}'
          }));

      return response.statusCode;
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<GroupedTransferVoucher>?> getReceivedTransferVouchers(
      String searchText) async {
    try {
      AccessToken? accessToken = _accessDao.getTokenFromDatabase();
      var response = await Dio().get(
          '$kBaseUrl$kGetReceivedTransferVouchers${searchText.isEmpty ? "" : "?searchText=$searchText"}',
          options: Options(headers: {
            'accept': 'text/plain',
            'Authorization': 'Bearer ${accessToken?.accessToken}'
          }));
      return (response.data['data'] as List)
          .map((e) => GroupedTransferVoucher.fromJson(e))
          .toList();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<void> receiveTransferVoucher(String transferVno, String remark) async {
    try {
      AccessToken? accessToken = _accessDao.getTokenFromDatabase();
      await Dio().post(
          '$kBaseUrl$kReceivedTransferVouchers?transferVno=$transferVno${remark.isEmpty ? "" : "&remark=$remark"}',
          options: Options(headers: {
            'accept': 'text/plain',
            'Authorization': "Bearer ${accessToken?.accessToken}"
          }));
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<bool?> checkDeviceSerial(String serialNo) async {
    try {
      var response = await Dio().get(
          "$kBaseUrl$kCheckDevice?serialNo=$serialNo",
          options: Options(headers: {"accept": "text/plain"}));
      if (response.statusCode == 200) {
        return response.data['data'];
      }
      return null;
    } on DioException catch (error) {
      AccessTokenDaoImpl().deleteAccessToken();
      ErrorHandler.handleErrorForDevice(error);
      return null;
    }
  }

  @override
  Future<List<IssueStockVM>?> getCustomerIssueStocks() async {
    try {
      AccessToken? accessToken = _accessDao.getTokenFromDatabase();
      var response = await Dio().get("$kBaseUrl$kGetCustomerStocks",
          options: Options(headers: {
            "accept": "text/plain",
            "Authorization": "Bearer ${accessToken?.accessToken}"
          }));
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((e) => IssueStockVM.fromJson(e))
            .toList();
      }
    } catch (e) {
      throw ServerException();
    }
    return null;
  }
}
