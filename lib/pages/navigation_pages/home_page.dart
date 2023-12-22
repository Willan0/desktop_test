import 'package:flutter/material.dart';
import 'package:desktop_test/constant/color.dart';
import 'package:desktop_test/constant/dimen.dart';
import 'package:desktop_test/data/vms/issue_stock/issue_stock_vm.dart';
import 'package:desktop_test/pages/voucher_creating_pages/selected_voucher_page.dart';
import 'package:desktop_test/pages/voucher_page_components/sliver_header.dart';
import 'package:desktop_test/provider/home_page_provider.dart';
import 'package:desktop_test/provider/login_provider.dart';
import 'package:desktop_test/utils/extension.dart';
import 'package:desktop_test/utils/responsive_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:desktop_test/widgets/easy_text.dart';
import 'package:desktop_test/widgets/reuse_floating_button.dart';
import 'package:provider/provider.dart';

import '../../widgets/easy_sliver_app_bar.dart';
import '../../widgets/item_count_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isInitialize = false;
  late LoginProvider loginProvider;
  late HomePageProvider _homePageProvider;
  List<IssueStockVM>? issues;

  @override
  void didChangeDependencies() {
    _homePageProvider = context.watch<HomePageProvider>();
    if (!_isInitialize) {
      _homePageProvider.getIssuesStocks();
    }
    issues = _homePageProvider.filteredIssueStocks.isEmpty
        ? _homePageProvider.issuesStock
        : _homePageProvider.filteredIssueStocks;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    _isInitialize = true;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: kBackGroundColor,
        body: RefreshIndicator(
          onRefresh: () async {
            await _homePageProvider.getIssuesStocks(isRefresh: true);
          },
          child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                    EasySliverAppBar(
                        title: AppLocalizations.of(context)!.sale_items,
                        expandedHeight: kAs130x,
                        textEditingController:
                            _homePageProvider.searchController,
                        onChange: (value) {
                          _homePageProvider.searchIssues();
                        },
                        hintText: AppLocalizations.of(context)!.search_sale),
                    SliverPersistentHeader(
                        pinned: true,
                        delegate: PersistentHeaderDelegateWidget(
                            ItemCountWidget(
                                count: _homePageProvider.isContain
                                    ? (issues ?? []).length
                                    : 0)))
                  ],
              body: (issues == null)
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : (issues!.isEmpty)
                      ? const Center(
                          child: EasyText(
                            text: 'There is no issues stocks',
                            fontSize: kFs16x,
                          ),
                        )
                      : _homePageProvider.isContain
                          ? context.responsive(
                              MobileListView(
                                list: issues ?? [],
                                isIssue: true,
                                scrollController:
                                    _homePageProvider.scrollController,
                              ),
                              lg: TabletGridView(
                                  list: issues ?? [],
                                  isIssue: true,
                                  scrollController:
                                      _homePageProvider.scrollController,
                                  childAspectRatio: 1.8,
                                  crossAxisCount: 3),
                              md: TabletGridView(
                                  list: issues ?? [],
                                  isIssue: true,
                                  scrollController:
                                      _homePageProvider.scrollController,
                                  childAspectRatio: 1.72,
                                  crossAxisCount: 2))
                          : const Center(
                              child: EasyText(
                                text: 'There is no issues stock',
                                fontSize: kFs16x,
                              ),
                            )),
        ),
        floatingActionButton: const ReuseFloatingActionButton(
          page: SelectedVoucherPage(
            isTransfer: true,
          ),
          padding: 0,
        ),
      ),
    );
  }
}
