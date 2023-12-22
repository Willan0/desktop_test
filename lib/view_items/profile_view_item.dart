import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:desktop_test/constant/assets.dart';
import 'package:desktop_test/provider/customer_provider.dart';
import 'package:desktop_test/provider/profile_provider.dart';
import 'package:desktop_test/utils/extension.dart';
import 'package:desktop_test/widgets/customer_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../constant/color.dart';
import '../constant/dimen.dart';
import '../data/data_apply/data_apply/gg_luck_data_apply_imp.dart';
import '../data/vms/language_model/language_model.dart';
import '../pages/auth_page/login_page.dart';
import '../pages/profile_page_components/return_report_page.dart';
import '../pages/profile_page_components/sale_report_page.dart';
import '../pages/profile_page_components/statement_report_page.dart';
import '../pages/profile_page_components/transfer_report_page.dart';
import '../provider/language_provider.dart';
import '../widgets/easy_text.dart';

class MobileProfileView extends StatelessWidget {
  const MobileProfileView(
      {super.key,
      required this.name,
      required this.role,
      required this.goldPrice});

  final String name;
  final String role;
  final num goldPrice;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kAs20x),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: kWhiteColor,
                    radius: kBr45x,
                  ),
                  const SizedBox(
                    width: kAs20x,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const MobileProfileInfoItemView(
                          firstValue: 'Name ',
                          secondValue: "Role ",
                          isLabel: true,
                          firstWidth: kAs50x),
                      const SizedBox(
                        width: kAs5x,
                      ),
                      const MobileProfileInfoItemView(
                        firstValue: ':',
                        secondValue: ":",
                      ),
                      const SizedBox(
                        width: kAs5x,
                      ),
                      MobileProfileInfoItemView(
                        firstValue: name,
                        secondValue: role,
                        firstWidth: kAs100x,
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: kAs20x,
              ),
              GoldPriceView(
                goldPrice: goldPrice,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: kAs45x,
        ),
        const ProfileFunctionsView()
      ],
    );
  }
}

class MobileProfileInfoItemView extends StatelessWidget {
  const MobileProfileInfoItemView({
    super.key,
    required this.firstValue,
    required this.secondValue,
    this.firstWidth = kAs5x,
    this.isLabel = false,
  });

  final String firstValue;
  final double firstWidth;
  final String secondValue;
  final bool isLabel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: firstWidth,
          child: EasyText(
            text: firstValue,
            overflow: isLabel ? null : TextOverflow.ellipsis,
            maxLine: 1,
            fontSize: isLabel ? kFs16x : kFs18x,
            textAlign: TextAlign.left,
            fontFamily: roboto,
          ),
        ),
        const SizedBox(
          height: kAs5x,
        ),
        EasyText(
          text: secondValue,
          textAlign: TextAlign.left,
          fontSize: isLabel ? kFs16x : kFs18x,
          fontFamily: roboto,
        ),
      ],
    );
  }
}

class TabletProfileView extends StatelessWidget {
  const TabletProfileView(
      {super.key,
      required this.name,
      required this.role,
      required this.goldPrice});

  final String name;
  final String role;
  final num goldPrice;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kAs20x),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                backgroundColor: kWhiteColor,
                radius: kBr45x,
              ),
              const SizedBox(
                width: kAs30x,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const TabletProfileInfoItemView(
                      firstText: 'Name', secondText: 'Role'),
                  const SizedBox(
                    width: kAs20x,
                  ),
                  TabletProfileInfoItemView(
                    firstText: name,
                    secondText: role,
                  )
                ],
              ),
              const SizedBox(
                width: kAs50x,
              ),
              GoldPriceView(
                goldPrice: goldPrice,
              ),
              context.responsive(const SizedBox(),
                  lg: const Expanded(child: ChangeLanguageView()))
            ],
          ),
          const SizedBox(
            height: kAs45x,
          ),
          context.responsive(const SizedBox(),
              md: const ChangeLanguageView(), lg: const SizedBox()),
          const ProfileFunctionsView()
        ],
      ),
    );
  }
}

class TabletProfileInfoItemView extends StatelessWidget {
  const TabletProfileInfoItemView({
    super.key,
    required this.firstText,
    required this.secondText,
  });

  final String firstText;
  final String secondText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: kAs10x,
        ),
        EasyText(
          text: firstText,
          fontSize: kFs18x,
          fontFamily: roboto,
        ),
        const SizedBox(
          height: kAs20x,
        ),
        EasyText(
          text: secondText,
          fontSize: kFs18x,
          fontFamily: roboto,
        )
      ],
    );
  }
}

class ProfileFunctionsView extends StatelessWidget {
  const ProfileFunctionsView({super.key});

  @override
  Widget build(BuildContext context) {
    List<ProfileFunctionItemView> profileFunctionViews = [
      ProfileFunctionItemView(
        label: "Customer",
        leadingIcon: Icons.perm_identity_sharp,
        onTap: () {
          context.pushScreen(const CustomerPage(
            isCreate: false,
          ));
          context.read<CustomerProvider>().customerSearchController.clear();
        },
      ),
      ProfileFunctionItemView(
        label: "Sale Report",
        leadingIcon: Icons.assignment,
        onTap: () {
          context.pushScreen(const SaleReportPage());
        },
      ),
      ProfileFunctionItemView(
        label: "Return Report",
        leadingIcon: Icons.assignment,
        onTap: () {
          context.pushScreen(const ReturnReportPage());
        },
      ),
      ProfileFunctionItemView(
        label: "Statement Report",
        leadingIcon: Icons.assignment,
        onTap: () {
          context.pushScreen(const StatementReportPage());
        },
      ),
      ProfileFunctionItemView(
        label: "Transfer Report",
        leadingIcon: Icons.assignment,
        onTap: () {
          context.pushScreen(const TransferReportPage());
        },
      ),
      ProfileFunctionItemView(
        label: "Logout",
        leadingIcon: Icons.logout,
        isLogout: true,
        onTap: () {
          context.showWarningDialog(context,
              textLeft: 'Cancel',
              textRight: 'Yes',
              warningText: 'Are your sure to logout?', onTextRight: () async {
            Navigator.of(context).popUntil((route) => route.isFirst);
            context.pushReplacement(const LoginPage());
            await GgLuckDataApplyImpl().deleteAccessToken();
          });
        },
      ),
    ];
    return context.responsive(LayoutBuilder(builder: (context, constraints) {
      return DraggableScrollableSheet(
          snap: true,
          minChildSize: context.responsiveHeight(0.64, md: 0.68, lg: 0.7),
          initialChildSize: context.responsiveHeight(0.64, md: 0.68, lg: 0.7),
          maxChildSize: context.responsiveHeight(0.87, lg: 0.83, md: 0.84),
          builder: (context, scrollController) => Container(
              decoration: const BoxDecoration(
                  color: kWhiteColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(kBr20x),
                      topRight: Radius.circular(kAs20x))),
              padding: const EdgeInsets.only(top: kAs30x),
              child: ListView(
                shrinkWrap: true,
                controller: scrollController,
                children: [
                  const ChangeLanguageView(
                    color: kBackGroundColor,
                  ),
                  Column(
                    children: profileFunctionViews,
                  ),
                ],
              )));
    }),
        lg: Expanded(
          child: GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: kAs10x,
              crossAxisCount: 5,
            ),
            children: profileFunctionViews,
          ),
        ),
        md: Expanded(
          child: GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: kAs10x,
              crossAxisCount: 3,
            ),
            children: profileFunctionViews,
          ),
        ));
  }
}

class ProfileFunctionItemView extends StatelessWidget {
  const ProfileFunctionItemView(
      {super.key,
      required this.label,
      required this.leadingIcon,
      this.onTap,
      this.isLogout = false});

  final String label;
  final IconData leadingIcon;
  final bool isLogout;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: context.responsive(
          MobileProfileFunctionView(leadingIcon: leadingIcon, label: label),
          lg: TabletProfileFunctionView(
            leadingIcon: leadingIcon,
            label: label,
            isLogout: isLogout,
          ),
          md: TabletProfileFunctionView(
            leadingIcon: leadingIcon,
            label: label,
            isLogout: isLogout,
          )),
    );
  }
}

class MobileProfileFunctionView extends StatelessWidget {
  const MobileProfileFunctionView({
    super.key,
    required this.leadingIcon,
    required this.label,
  });

  final IconData leadingIcon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kAs15x),
      margin:
          const EdgeInsets.only(bottom: kAs10x, left: kAs20x, right: kAs20x),
      decoration: BoxDecoration(
          color: kBackGroundColor, borderRadius: BorderRadius.circular(kBr10x)),
      child: Row(
        children: [
          Icon(leadingIcon),
          const SizedBox(
            width: kAs20x,
          ),
          EasyText(
            text: label,
            fontSize: kFs16x,
          ),
        ],
      ),
    );
  }
}

class TabletProfileFunctionView extends StatelessWidget {
  const TabletProfileFunctionView(
      {super.key,
      required this.leadingIcon,
      required this.label,
      required this.isLogout});

  final IconData leadingIcon;
  final String label;
  final bool isLogout;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kAs15x),
      margin: const EdgeInsets.only(bottom: kAs10x),
      decoration: BoxDecoration(
          color: kWhiteColor, borderRadius: BorderRadius.circular(kBr10x)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: const EdgeInsets.all(kAs20x),
              decoration: BoxDecoration(
                  color: kBackGroundColor,
                  borderRadius: BorderRadius.circular(kBr10x)),
              child: Icon(
                leadingIcon,
              )),
          const SizedBox(
            height: kAs20x,
          ),
          Flexible(
              child: EasyText(
            text: label,
            fontSize: kFs16x,
          )),
          const SizedBox(
            height: kAs30x,
          ),
          isLogout
              ? const SizedBox()
              : Container(
                  width: getWidth(context),
                  padding: const EdgeInsets.only(right: kAs10x),
                  alignment: Alignment.bottomRight,
                  child: const CircleAvatar(
                      backgroundColor: kBackGroundColor,
                      child: Icon(CupertinoIcons.right_chevron)),
                )
        ],
      ),
    );
  }
}

class ChangeLanguageView extends StatelessWidget {
  const ChangeLanguageView({super.key, this.color = kWhiteColor});

  final Color color;
  @override
  Widget build(BuildContext context) {
    final languageProvider = context.watch<LanguageProvider>();
    return Container(
      margin: EdgeInsets.only(
          bottom: kAs20x,
          left: context.responsive(kAs20x, lg: kAs20x, md: 0),
          right: context.responsive(kAs20x, lg: kAs20x, md: 0)),
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(kBr10x)),
      child: Row(
        children: [
          Expanded(
            child: ListTile(
              title: const Text('English'),
              leading: SizedBox(
                width: kAs20x,
                child: Radio(
                  value: Language.english,
                  groupValue: languageProvider.language,
                  onChanged: (language) {
                    languageProvider.changeLanguage(
                        const Locale('en'), language);
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: ListTile(
              title: const Text('Myanmar'),
              leading: SizedBox(
                width: kAs20x,
                child: Radio(
                  value: Language.myanmar,
                  groupValue: languageProvider.language,
                  onChanged: (language) {
                    languageProvider.changeLanguage(
                        const Locale('my'), language);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GoldPriceView extends StatelessWidget {
  const GoldPriceView({super.key, required this.goldPrice});

  final num goldPrice;
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        height: kAs70x,
        decoration: BoxDecoration(
            color: kWhiteColor, borderRadius: BorderRadius.circular(kBr10x)),
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: kAs20x, vertical: kAs19x),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              EasyText(
                text: AppLocalizations.of(context)!.today_gold_price,
                fontSize: kFs16x,
              ),
              const EasyText(
                text: ' : ',
                fontSize: kFs16x,
              ),
              EasyText(
                text: goldPrice.toString().separateMoney(),
                fontSize: kFs16x,
              ),
            ],
          ),
        ),
      ),
      Positioned(
        top: -10,
        right: -8,
        child: IconButton(
            onPressed: () {
              context.read<ProfileProvider>().get16GoldPrice();
            },
            icon: const Icon(Icons.refresh)),
      ),
    ]);
  }
}
