import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:desktop_test/constant/color.dart';
import 'package:desktop_test/data/data_apply/data_apply/gg_luck_data_apply.dart';
import 'package:desktop_test/data/data_apply/data_apply/gg_luck_data_apply_imp.dart';
import 'package:desktop_test/pages/navigation_pages/home_page.dart';
import 'package:desktop_test/pages/navigation_pages/notification_page.dart';
import 'package:desktop_test/pages/navigation_pages/profile_page.dart';
import 'package:desktop_test/pages/navigation_pages/voucher_page.dart';
import 'package:desktop_test/provider/profile_provider.dart';
import 'package:desktop_test/widgets/custom_floating_bottom_btn.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GgLuck extends StatefulWidget {
  const GgLuck({super.key, this.index = 0});

  final int index;

  @override
  State<GgLuck> createState() => _GgLuckState();
}

class _GgLuckState extends State<GgLuck> {
  List<Widget> pages = [
    const HomePage(),
    const VoucherPage(),
    const NotificationPage(),
    const ProfilePage()
  ];

  int index = 0;

  @override
  void initState() {
    index = widget.index;
    GgLuckDataApply ggLuckDataApply = GgLuckDataApplyImpl();
    ggLuckDataApply.deleteSelectedMainStocks();
    ggLuckDataApply.deleteSelectedCustomer();
    ggLuckDataApply.deleteSelectedIssues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBackGroundColor,
        body: IndexedStack(index: index, children: pages),
        bottomNavigationBar: CustomFloatingBottomButton(
          index: index,
          onTap: (value) {
            setState(() {
              if (index != value) {
                index = value!;
                if (value == 3) {
                  context.read<ProfileProvider>().get16GoldPrice();
                }
              }
            });
          },
          items: [
            FloatingNavbarItem(
                icon: Icons.home, title: AppLocalizations.of(context)!.home),
            FloatingNavbarItem(
                icon: Icons.assignment,
                title: AppLocalizations.of(context)!.voucher),
            FloatingNavbarItem(
                icon: Icons.notifications,
                title: AppLocalizations.of(context)!.noti),
            FloatingNavbarItem(
                icon: Icons.person,
                title: AppLocalizations.of(context)!.profile),
          ],
        ));
  }
}
