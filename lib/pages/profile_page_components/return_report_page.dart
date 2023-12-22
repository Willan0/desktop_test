import 'package:flutter/material.dart';
import 'package:desktop_test/constant/dimen.dart';
import 'package:desktop_test/data/vms/return_voucher/grouped_return_voucher.dart';
import 'package:desktop_test/provider/return_voucher_provider.dart';
import 'package:desktop_test/utils/extension.dart';
import 'package:desktop_test/widgets/easy_app_bar.dart';
import 'package:desktop_test/view_items/filter_widget.dart';
import 'package:desktop_test/widgets/return_voucher_card.dart';
import 'package:provider/provider.dart';

import '../../constant/color.dart';
import '../../widgets/center_column_widget.dart';
import '../../widgets/easy_text.dart';
import '../../widgets/report_view.dart';

class ReturnReportPage extends StatefulWidget {
  const ReturnReportPage({super.key});

  @override
  State<ReturnReportPage> createState() => _ReturnReportPageState();
}

class _ReturnReportPageState extends State<ReturnReportPage>
    with SingleTickerProviderStateMixin {
  late ReturnVoucherProvider _returnVoucherProvider;
  late TabController _tabController;
  bool isInitialized = false;
  List<GroupedReturnVoucher> _reportReturnVouchers = [];
  bool isLoading = true;
  int _tabIndex = 0;
  DateTime? _startDate;
  DateTime? _endDate;
  String _category = '';

  final List<Tab> _tabs = const [
    Tab(
      child: Text("Pending"),
    ),
    Tab(
      child: Text("Deleted"),
    ),
    Tab(
      child: Text("Received"),
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
        await _returnVoucherProvider.getReturnVouchers(
            isReport: true,
            index: _tabIndex,
            category: _category,
            startDate: _startDate,
            endDate: _endDate);
        isLoading = false;
      }
    });
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    _returnVoucherProvider = context.watch<ReturnVoucherProvider>();
    if (!isInitialized) {
      await _returnVoucherProvider.getReturnVouchers(
          isReport: true, index: _tabIndex);
      isLoading = false;
    }
    _reportReturnVouchers = _returnVoucherProvider.reportReturnVouchers ?? [];
    if (_reportReturnVouchers.isNotEmpty) {
      _reportReturnVouchers.sort(
        (a, b) => b.date!
            .formatStringToDate()
            .compareTo(a.date!.formatStringToDate()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    isInitialized = true;
    return Scaffold(
      backgroundColor: kBackGroundColor,
      appBar: PreferredSize(
          preferredSize: Size(getWidth(context), kToolbarHeight),
          child: const EasyAppBar(
            text: "Return Report",
            leading: true,
          )),
      body: Column(
        children: [
          FilterWidget(
            textEditingController: _returnVoucherProvider.filterTextController,
            filter: ({category, endDate, startDate}) async {
              _startDate = startDate;
              _endDate = endDate;
              _category = category ?? '';
              isLoading = true;
              setState(() {});
              await _returnVoucherProvider.getReturnVouchers(
                  isReport: true,
                  category: category,
                  startDate: startDate,
                  endDate: endDate,
                  index: _tabIndex);
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
              : _reportReturnVouchers.isEmpty
                  ? const CenterColumnWidget(
                      widget: EasyText(
                        text: "There is no return voucher",
                        fontSize: kFs16x,
                      ),
                    )
                  : Expanded(
                      child: TabBarView(controller: _tabController, children: [
                        ReturnReportViewItem(
                            reportReturnVouchers: _reportReturnVouchers),
                        ReturnReportViewItem(
                            reportReturnVouchers: _reportReturnVouchers),
                        ReturnReportViewItem(
                            reportReturnVouchers: _reportReturnVouchers),
                      ]),
                    )
        ],
      ),
    );
  }
}

class ReturnReportViewItem extends StatefulWidget {
  const ReturnReportViewItem({super.key, required this.reportReturnVouchers});
  final List<GroupedReturnVoucher> reportReturnVouchers;
  @override
  State<ReturnReportViewItem> createState() => _ReturnReportViewItemState();
}

class _ReturnReportViewItemState extends State<ReturnReportViewItem> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.reportReturnVouchers.length,
      itemBuilder: (context, i) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: kAs20x),
          child: ReportView(
            isCollapse: widget.reportReturnVouchers[i].isCollapse,
            widgets: (widget.reportReturnVouchers[i].returnVouchers ?? [])
                .map((e) => ReturnVoucherCard(
                      returnVoucher: e,
                      isReport: true,
                    ))
                .toList(),
            count: widget.reportReturnVouchers[i].count ?? 0,
            date: widget.reportReturnVouchers[i].date ?? '',
            onTap: () {
              setState(() {
                widget.reportReturnVouchers[i].isCollapse =
                    !widget.reportReturnVouchers[i].isCollapse;
              });
            },
          ),
        );
      },
    );
  }
}
