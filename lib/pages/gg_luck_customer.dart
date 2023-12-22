import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:desktop_test/constant/color.dart';
import 'package:desktop_test/pages/ggLuck_customer_navigation_pages/customer_home_page.dart';
import 'package:desktop_test/pages/ggLuck_customer_navigation_pages/customer_payment_page.dart';
import 'package:desktop_test/pages/ggLuck_customer_navigation_pages/customer_profile_page.dart';
import 'package:desktop_test/pages/ggLuck_customer_navigation_pages/customer_voucher_page.dart';
import 'package:desktop_test/widgets/custom_floating_bottom_btn.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GgLuckCustomer extends StatefulWidget {
  const GgLuckCustomer({super.key});

  @override
  State<GgLuckCustomer> createState() => _GgLuckCustomerState();
}

class _GgLuckCustomerState extends State<GgLuckCustomer> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const CustomerHomePage(),
    const CustomerVoucherPage(),
    const CustomerPaymentPage(),
    const CustomerProfilePage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackGroundColor,
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: CustomFloatingBottomButton(
        index: _currentIndex,
        onTap: (value) {
          if (_currentIndex != value) {
            _currentIndex = value!;
            setState(() {});
          }
        },
        items: [
          FloatingNavbarItem(
              icon: Icons.home, title: AppLocalizations.of(context)!.home),
          FloatingNavbarItem(
              icon: Icons.assignment,
              title: AppLocalizations.of(context)!.voucher),
          FloatingNavbarItem(
            icon: Icons.payment,
            title: "Payment",
          ),
          FloatingNavbarItem(
              icon: Icons.person, title: AppLocalizations.of(context)!.profile),
        ],
      ),
    );
  }
}
