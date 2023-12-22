import 'package:flutter/material.dart';
import 'package:desktop_test/constant/dimen.dart';
import 'package:desktop_test/data/vms/customer_payment/grouped_customer_payment.dart';
import 'package:desktop_test/provider/customer_provider.dart';
import 'package:desktop_test/widgets/customer_payment_card.dart';
import 'package:desktop_test/widgets/easy_app_bar.dart';
import 'package:desktop_test/widgets/easy_text.dart';
import 'package:provider/provider.dart';

import '../../constant/color.dart';
import '../../view_items/filter_widget.dart';
import '../../widgets/center_column_widget.dart';
import '../../widgets/report_view.dart';

class StatementReportPage extends StatefulWidget {
  const StatementReportPage({super.key});

  @override
  State<StatementReportPage> createState() => _StatementReportPageState();
}

class _StatementReportPageState extends State<StatementReportPage>
    with SingleTickerProviderStateMixin {
  late CustomerProvider _customerProvider;
  List<GroupedCustomerPayment> _statementReportList = [];
  bool _isInitialized = false;
  bool isLoading = true;
  int _tabIndex = 0;
  DateTime? _startDate;
  DateTime? _endDate;
  late TabController _tabController;

  final List<Tab> _tabs = const [
    Tab(
      child: Text("Received"),
    ),
    Tab(
      child: Text("Deleted"),
    ),
  ];
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(() async {
      if (_tabIndex != _tabController.index) {
        setState(() {
          isLoading = true;
        });
        _tabIndex = _tabController.index;
        await _customerProvider.getStatementPaymentsReports(
            _startDate, _endDate, _tabIndex);
        isLoading = false;
      }
    });
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    _customerProvider = context.watch<CustomerProvider>();
    if (!_isInitialized) {
      _customerProvider.filterStatementReport.clear();
      await _customerProvider.getStatementPaymentsReports(
          _startDate, _endDate, _tabIndex);
      isLoading = false;
    }
    _statementReportList = _customerProvider.statementReportPayments ?? [];
  }

  @override
  Widget build(BuildContext context) {
    _isInitialized = true;
    return Scaffold(
      backgroundColor: kBackGroundColor,
      appBar: PreferredSize(
          preferredSize: Size(getWidth(context), kToolbarHeight),
          child: const EasyAppBar(
            text: "Statement Report",
            leading: true,
          )),
      body: Column(
        children: [
          FilterWidget(
            isNeedCategory: false,
            textEditingController: _customerProvider.filterStatementReport,
            filter: ({category, endDate, startDate}) async {
              _startDate = startDate;
              _endDate = endDate;
              isLoading = true;
              setState(() {});
              await _customerProvider.getStatementPaymentsReports(
                  _startDate, _endDate, _tabIndex);
              isLoading = false;
            },
          ),
          const SizedBox(
            height: kAs10x,
          ),
          Container(
            height: kAs50x,
            color: kBackGroundColor,
            child: TabBar(
              controller: _tabController,
              tabs: _tabs,
              labelColor: kPrimaryTextColor,
              unselectedLabelColor: kSecondaryTextColor,
              indicatorPadding: const EdgeInsets.symmetric(horizontal: kAs5x),
            ),
          ),
          const SizedBox(
            height: kAs10x,
          ),
          isLoading
              ? const CenterColumnWidget(
                  widget: CircularProgressIndicator(),
                )
              : _statementReportList.isEmpty
                  ? const CenterColumnWidget(
                      widget: EasyText(
                        text: "There is no payment statement",
                        fontSize: kFs16x,
                      ),
                    )
                  : Expanded(
                      child: TabBarView(controller: _tabController, children: [
                        StatementReportViewItem(
                            reportStatementVouchers: _statementReportList),
                        StatementReportViewItem(
                            reportStatementVouchers: _statementReportList),
                      ]),
                    )
        ],
      ),
    );
  }
}

class StatementReportViewItem extends StatefulWidget {
  const StatementReportViewItem(
      {super.key, required this.reportStatementVouchers});
  final List<GroupedCustomerPayment> reportStatementVouchers;
  @override
  State<StatementReportViewItem> createState() =>
      _StatementReportViewItemState();
}

class _StatementReportViewItemState extends State<StatementReportViewItem> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.reportStatementVouchers.length,
      itemBuilder: (context, i) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: kAs20x),
          child: ReportView(
            isCollapse: widget.reportStatementVouchers[i].isCollapse,
            widgets: (widget.reportStatementVouchers[i].customerPayments ?? [])
                .map((e) => CustomerPaymentCard(
                      customerPayment: e,
                      isReport: true,
                    ))
                .toList(),
            count: (widget.reportStatementVouchers[i].count ?? 0).toInt(),
            date: widget.reportStatementVouchers[i].date ?? '',
            onTap: () {
              setState(() {
                widget.reportStatementVouchers[i].isCollapse =
                    !widget.reportStatementVouchers[i].isCollapse;
              });
            },
          ),
        );
      },
    );
  }
}
