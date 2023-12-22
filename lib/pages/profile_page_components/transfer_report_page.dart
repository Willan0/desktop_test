import 'package:flutter/material.dart';
import 'package:desktop_test/constant/color.dart';
import 'package:desktop_test/constant/dimen.dart';
import 'package:desktop_test/data/vms/transfer_voucher/grouped_transfer_voucher.dart';
import 'package:desktop_test/provider/transfer_voucher_provider.dart';
import 'package:desktop_test/utils/extension.dart';
import 'package:desktop_test/view_items/filter_widget.dart';
import 'package:desktop_test/widgets/center_column_widget.dart';
import 'package:desktop_test/widgets/easy_app_bar.dart';
import 'package:desktop_test/widgets/easy_text.dart';
import 'package:provider/provider.dart';

import '../../widgets/report_view.dart';
import '../../widgets/transfer_voucher_card.dart';

class TransferReportPage extends StatefulWidget {
  const TransferReportPage({super.key});

  @override
  State<TransferReportPage> createState() => _TransferReportPageState();
}

class _TransferReportPageState extends State<TransferReportPage>
    with SingleTickerProviderStateMixin {
  bool _isInitialized = false;
  late TabController _tabController;
  int tabIndex = 0;
  bool isLoading = true;
  DateTime? _startDate;
  DateTime? _endDate;
  String? _type;
  late TransferVoucherProvider _transferVoucherProvider;
  List<GroupedTransferVoucher> _transferVouchers = [];
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() async {
      if (tabIndex != _tabController.index) {
        isLoading = true;
        if (mounted) {
          setState(() {});
        }
        tabIndex = _tabController.index;
        await _transferVoucherProvider.getTransferVouchersReport(
            _startDate, _endDate, _type ?? "",
            index: tabIndex);
        isLoading = false;
      }
    });
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    _transferVoucherProvider = context.watch<TransferVoucherProvider>();
    if (!_isInitialized) {
      await _transferVoucherProvider.getTransferVouchersReport(
          DateTime.now(), DateTime.now(), '',
          index: tabIndex);
      isLoading = false;
    }
    _transferVouchers = _transferVoucherProvider.groupedTransferVouchers ?? [];
    if (_transferVouchers.isNotEmpty) {
      _transferVouchers.sort(
        (a, b) => b.date!
            .formatStringToDate()
            .compareTo(a.date!.formatStringToDate()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    _isInitialized = true;
    return Scaffold(
      backgroundColor: kBackGroundColor,
      appBar: PreferredSize(
          preferredSize: Size(getWidth(context), kToolbarHeight),
          child: const EasyAppBar(
            text: "Transfer Report",
            leading: true,
          )),
      body: Column(
        children: [
          FilterWidget(
            textEditingController:
                _transferVoucherProvider.voucherOrCsController,
            filter: ({category, endDate, startDate}) async {
              _startDate = startDate;
              _endDate = endDate;
              _type = category;
              isLoading = true;
              if (mounted) {
                setState(() {});
              }
              await _transferVoucherProvider.getTransferVouchersReport(
                  _startDate, _endDate, category ?? '',
                  index: tabIndex);
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
              tabs: const [
                Tab(
                  text: 'Pending',
                ),
                Tab(
                  text: 'Transferred',
                ),
                Tab(
                  text: "Received",
                )
              ],
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
              : _transferVouchers.isEmpty
                  ? const CenterColumnWidget(
                      widget: EasyText(
                        text: "There is no transfer Vouchers",
                        fontSize: kFs16x,
                      ),
                    )
                  : Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          TransferVoucherPageViewItem(
                              groupedTransferVouchers: _transferVouchers),
                          TransferVoucherPageViewItem(
                              groupedTransferVouchers: _transferVouchers),
                          TransferVoucherPageViewItem(
                              groupedTransferVouchers: _transferVouchers),
                        ],
                      ),
                    )
        ],
      ),
    );
  }
}

class TransferVoucherPageViewItem extends StatefulWidget {
  const TransferVoucherPageViewItem(
      {super.key, required this.groupedTransferVouchers});

  final List<GroupedTransferVoucher> groupedTransferVouchers;

  @override
  State<TransferVoucherPageViewItem> createState() =>
      _TransferVoucherPageViewItemState();
}

class _TransferVoucherPageViewItemState
    extends State<TransferVoucherPageViewItem> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.groupedTransferVouchers.length,
      itemBuilder: (context, i) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: kAs20x),
          child: ReportView(
              isCollapse: widget.groupedTransferVouchers[i].isCollapse,
              widgets:
                  (widget.groupedTransferVouchers[i].transferVouchers ?? [])
                      .map((e) => TransferVoucherCard(
                            transferVm: e,
                            isReport: true,
                          ))
                      .toList(),
              onTap: () {
                setState(() {
                  widget.groupedTransferVouchers[i].isCollapse =
                      !widget.groupedTransferVouchers[i].isCollapse;
                });
              },
              count: (widget.groupedTransferVouchers[i].count ?? 0).toInt(),
              date: widget.groupedTransferVouchers[i].date ?? ''),
        );
      },
    );
  }
}
