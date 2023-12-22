import 'package:flutter/material.dart';
import 'package:desktop_test/constant/color.dart';
import 'package:desktop_test/constant/dimen.dart';
import 'package:desktop_test/data/vms/access_token/access_token.dart';
import 'package:desktop_test/persistent/daos/user_dao/access_token_dao_impl.dart';
import 'package:desktop_test/provider/profile_provider.dart';
import 'package:desktop_test/utils/extension.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../view_items/profile_view_item.dart';
import '../../widgets/easy_app_bar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    AccessToken? accessToken = AccessTokenDaoImpl().getTokenFromDatabase();
    print("Access token user ============> $accessToken");
    return Scaffold(
        backgroundColor: kBackGroundColor,
        appBar: PreferredSize(
            preferredSize: Size(getWidth(context), kToolbarHeight),
            child: EasyAppBar(text: AppLocalizations.of(context)!.profile)),
        body: Consumer<ProfileProvider>(
          builder: (context, profileProvider, child) => context.responsive(
              MobileProfileView(
                goldPrice: profileProvider.gold16K,
                name: accessToken?.user?.fullName ?? '',
                role: accessToken?.user?.userRole ?? '',
              ),
              lg: TabletProfileView(
                goldPrice: profileProvider.gold16K,
                name: accessToken?.user?.fullName ?? '',
                role: accessToken?.user?.userRole ?? '',
              ),
              md: TabletProfileView(
                goldPrice: profileProvider.gold16K,
                name: accessToken?.user?.fullName ?? '',
                role: accessToken?.user?.userRole ?? '',
              )),
        ));
  }
}
