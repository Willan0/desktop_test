import 'package:desktop_test/constant/dao_constant.dart';
import 'package:desktop_test/data/vms/user/user.dart';
import 'package:desktop_test/persistent/daos/customer_dao/customer_dao.dart';
import 'package:hive/hive.dart';

class CustomerDaoImpl extends CustomerDao {
  CustomerDaoImpl._();

  static final CustomerDaoImpl _singleton = CustomerDaoImpl._();

  factory CustomerDaoImpl() => _singleton;

  final Box<UserVM> _customerBox = Hive.box(kBoxNameForCustomer);
  @override
  UserVM? getCustomerFromDataBase() {
    return _customerBox.get('customer');
  }

  @override
  Stream<UserVM?> getCustomerFromDataBaseStream() =>
      Stream.value(getCustomerFromDataBase());

  @override
  void save(UserVM customer) {
    customer.isSelect = true;
    _customerBox.put('customer', customer);
  }

  @override
  Stream wathCustomer() => _customerBox.watch();

  @override
  void deleteCustomer() {
    _customerBox.clear();
  }
}
