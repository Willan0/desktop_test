import 'package:desktop_test/data/vms/sale_voucher/sale_voucher.dart';
import 'package:desktop_test/data/vms/user/user.dart';
import 'package:desktop_test/utils/extension.dart';
import 'package:intl/intl.dart';

class Filtering {
  static List<SaleVoucherVM> filterForSale(
      List<SaleVoucherVM> list, String method,
      {DateTime? startDate, DateTime? endDate, UserVM? customer}) {
    if (method == "Date") {
      if (startDate != null && endDate == null) {
        list = list
            .where((sale) =>
                sale.date.toString().formatDate() ==
                DateFormat("yyyy/MM/dd").format(startDate))
            .toList();
        return list;
      }
    }
    if (method == "Customer") {
      if (customer != null) {
        List<SaleVoucherVM> listByCustomer = [];
        for (int c = 0; c < list.length; c++) {
          if (list[c].customerId == customer.userId) {
            listByCustomer.add(list[c]);
          }
        }
        return listByCustomer;
      }
    }
    return [];
  }
}
