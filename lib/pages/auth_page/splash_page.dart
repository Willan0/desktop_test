import 'package:flutter/material.dart';
import 'package:desktop_test/constant/assets.dart';
import 'package:desktop_test/widgets/easy_image.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../constant/color.dart';
import '../../constant/dimen.dart';
import '../../widgets/easy_text.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackGroundColor,
      body: SingleChildScrollView(
        child: SizedBox(
          width: getWidth(context),
          height: getHeight(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Logo

              const Center(
                child: EasyImage(
                  url: kLogo,
                  width: 136,
                  height: kAs100x,
                  fit: BoxFit.contain,
                  isNetwork: false,
                ),
              ),

              const SizedBox(
                height: kAs70x,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  EasyText(
                    text: AppLocalizations.of(context)!.logging_in,
                    fontSize: kFs20x,
                  ),
                  const SizedBox(
                    width: kAs20x,
                  ),
                  const CircularProgressIndicator(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
