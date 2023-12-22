import 'package:flutter/material.dart';
import 'package:desktop_test/constant/color.dart';
import 'package:desktop_test/utils/extension.dart';
import 'package:desktop_test/widgets/center_column_widget.dart';
import 'package:provider/provider.dart';

import '../../constant/dimen.dart';
import '../../data/vms/customer_payment/grouped_customer_payment.dart';
import '../../persistent/daos/user_dao/access_token_dao_impl.dart';
import '../../provider/customer_provider.dart';
import '../../view_items/customer_detail_view_item.dart';
import '../../view_items/filter_widget.dart';
import '../../widgets/easy_app_bar.dart';
import '../../widgets/easy_text.dart';

class CustomerPaymentPage extends StatefulWidget {
  const CustomerPaymentPage({super.key});

  @override
  State<CustomerPaymentPage> createState() => _CustomerPaymentPageState();
}

class _CustomerPaymentPageState extends State<CustomerPaymentPage> {
  List<GroupedCustomerPayment> _customerPayments = [];
  bool _isInitialized = false;
  late CustomerProvider _customerProvider;
  bool isLoading = true;
  DateTime? _startDate;
  DateTime? _endDate;
  String id = AccessTokenDaoImpl().getTokenFromDatabase()?.user?.id ?? '';

  @override
  void didChangeDependencies() {
    _customerProvider = context.watch<CustomerProvider>();
    if (!_isInitialized) {
      _loadDataForPayment();
    }
    _getCustomerPayments();
    super.didChangeDependencies();
  }

  _getCustomerPayments() {
    _customerPayments = _customerProvider.customerPayments ?? [];
    if (_customerPayments.isNotEmpty) {
      _customerPayments.sort(
        (a, b) => b.date!
            .formatStringToDate()
            .compareTo(a.date!.formatStringToDate()),
      );
    }
  }

  _loadDataForPayment() async {
    await _customerProvider.getCustomerPayments(id, _startDate, _endDate);
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    _isInitialized = false;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(getWidth(context), kToolbarHeight),
          child: const EasyAppBar(
            text: "Payment",
          )),
      backgroundColor: kBackGroundColor,
      body: Column(
        children: [
          FilterWidget(
            hintText: 'Type Voucher code',
            textEditingController: _customerProvider.customerPaymentController,
            isNeedCategory: false,
            filter: ({category, endDate, startDate}) async {
              _startDate = startDate;
              _endDate = endDate;
              if (mounted) {
                setState(() {
                  isLoading = true;
                });
              }
              await _customerProvider.getCustomerPayments(
                  id, startDate ?? DateTime.now(), endDate ?? DateTime.now());
              isLoading = false;
            },
          ),
          isLoading
              ? const CenterColumnWidget(
                  widget: CircularProgressIndicator(),
                )
              : _customerPayments.isEmpty
                  ? const CenterColumnWidget(
                      widget: EasyText(
                        text: "There is no payments",
                        fontSize: kFs16x,
                      ),
                    )
                  : CustomerPaymentViewItem(customerPayments: _customerPayments)
        ],
      ),
    );
  }
}
