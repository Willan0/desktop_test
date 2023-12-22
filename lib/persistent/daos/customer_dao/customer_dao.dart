import 'package:desktop_test/data/vms/user/user.dart';

abstract class CustomerDao {
  void save(UserVM customer);

  UserVM? getCustomerFromDataBase();

  Stream<UserVM?> getCustomerFromDataBaseStream();

  Stream wathCustomer();

  void deleteCustomer();
}
