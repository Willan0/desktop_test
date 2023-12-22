import 'package:flutter/material.dart';
import 'package:desktop_test/constant/color.dart';
import 'package:desktop_test/constant/dimen.dart';
import 'package:desktop_test/data/vms/sale_voucher/grouped_sale_voucher.dart';
import 'package:desktop_test/provider/sale_voucher_provider.dart';
import 'package:desktop_test/utils/extension.dart';
import 'package:desktop_test/widgets/easy_app_bar.dart';
import 'package:desktop_test/widgets/easy_text.dart';
import 'package:desktop_test/view_items/filter_widget.dart';
import 'package:desktop_test/widgets/report_view.dart';
import 'package:desktop_test/widgets/sale_voucher_card.dart';
import 'package:provider/provider.dart';

import '../../widgets/center_column_widget.dart';

class SaleReportPage extends StatefulWidget {
  const SaleReportPage({super.key});

  @override
  State<SaleReportPage> createState() => _SaleReportPageState();
}

class _SaleReportPageState extends State<SaleReportPage>
    with SingleTickerProviderStateMixin {
  late SaleVoucherProvider _saleVoucherProvider;
  late TabController _tabController;
  bool _isInitialize = false;
  List<GroupedSaleVoucher> _reportSaleVoucher = [];
  bool isLoading = true;
  int _tabIndex = 0;
  DateTime? _startDate;
  DateTime? _endDate;
  String _category = '';

  final List<Tab> _tabs = const [
    Tab(
      child: Text("Active"),
    ),
    Tab(
      child: Text("Deleted"),
    ),
  ];
  @override
  void initState() {
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(() async {
      if (_tabIndex != _tabController.index) {
        setState(() {
          isLoading = true;
        });
        _tabIndex = _tabController.index;
        await _saleVoucherProvider.getSaleVouchers(
            startDate: _startDate,
            endDate: _endDate,
            category: _category,
            isReport: true,
            index: _tabIndex);
        isLoading = false;
      }
    });
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    _saleVoucherProvider = context.watch<SaleVoucherProvider>();
    if (!_isInitialize) {
      await _saleVoucherProvider.getSaleVouchers(
          isReport: true, index: _tabIndex);
      isLoading = false;
    }
    _reportSaleVoucher = _saleVoucherProvider.reportSaleVouchers ?? [];
    if (_reportSaleVoucher.isNotEmpty) {
      _reportSaleVoucher.sort(
        (a, b) => b.date!
            .formatStringToDate()
            .compareTo(a.date!.formatStringToDate()),
      );
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    _isInitialize = true;
    return Scaffold(
      backgroundColor: kBackGroundColor,
      appBar: PreferredSize(
          preferredSize: Size(getWidth(context), kToolbarHeight),
          child: const EasyAppBar(
            text: "Sale Report",
            leading: true,
          )),
      body: Column(
        children: [
          FilterWidget(
            filter: ({category, endDate, startDate}) async {
              _startDate = startDate;
              _endDate = endDate;
              _category = category ?? '';
              isLoading = true;
              if (mounted) setState(() {});
              await _saleVoucherProvider.getSaleVouchers(
                  startDate: _startDate,
                  endDate: _endDate,
                  isReport: true,
                  index: _tabIndex,
                  category: category);
              isLoading = false;
            },
            textEditingController:
                _saleVoucherProvider.reportSearchTextEditingController,
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
              : _reportSaleVoucher.isEmpty
                  ? const CenterColumnWidget(
                      widget: EasyText(
                        text: "There is no sale voucher",
                        fontSize: kFs16x,
                      ),
                    )
                  : Expanded(
                      child: TabBarView(controller: _tabController, children: [
                        SaleReportViewItem(
                          reportSaleVouchers: _reportSaleVoucher,
                        ),
                        SaleReportViewItem(
                          reportSaleVouchers: _reportSaleVoucher,
                        ),
                      ]),
                    )
        ],
      ),
    );
  }
}

class SaleReportViewItem extends StatefulWidget {
  const SaleReportViewItem({super.key, required this.reportSaleVouchers});

  final List<GroupedSaleVoucher> reportSaleVouchers;
  @override
  State<SaleReportViewItem> createState() => _SaleReportViewItemState();
}

class _SaleReportViewItemState extends State<SaleReportViewItem> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.reportSaleVouchers.length,
      itemBuilder: (context, i) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: kAs20x),
          child: ReportView(
              isCollapse: widget.reportSaleVouchers[i].isCollapse,
              widgets: (widget.reportSaleVouchers[i].saleVouchers ?? [])
                  .map((e) => SaleVoucherCard(
                        saleVoucher: e,
                        isReport: true,
                      ))
                  .toList(),
              onTap: () {
                setState(() {
                  widget.reportSaleVouchers[i].isCollapse =
                      !widget.reportSaleVouchers[i].isCollapse;
                });
              },
              count: (widget.reportSaleVouchers[i].count ?? 0).toInt(),
              date: widget.reportSaleVouchers[i].date ?? ''),
        );
      },
    );
  }
}
