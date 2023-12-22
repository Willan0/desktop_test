import 'package:flutter/material.dart';
import 'package:desktop_test/constant/color.dart';
import 'package:desktop_test/utils/extension.dart';
import 'package:desktop_test/widgets/easy_button.dart';

import '../../data/data_apply/data_apply/gg_luck_data_apply_imp.dart';
import '../auth_page/login_page.dart';

class CustomerProfilePage extends StatelessWidget {
  const CustomerProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackGroundColor,
      body: Center(
        child: EasyButton(
          label: 'Logout',
          isNotIcon: true,
          onPressed: () {
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
      ),
    );
  }
}
