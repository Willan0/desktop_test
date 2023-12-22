import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:desktop_test/provider/language_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../constant/color.dart';
import '../constant/dimen.dart';
import 'easy_text.dart';

const Map<String, String> localeNumberMY = {
  "1": "၁",
};

class ItemCountWidget extends StatelessWidget {
  const ItemCountWidget({
    super.key,
    required this.count,
  });

  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kAs50x,
      padding: const EdgeInsets.symmetric(horizontal: kAs20x),
      color: kBackGroundColor,
      child: Row(
        children: [
          EasyText(
            text: AppLocalizations.of(context)!.total_item,
            fontSize: kFs18x,
          ),
          Builder(builder: (context) {
            return EasyText(
              text: NumberFormat("###,###,###",
                      context.watch<LanguageProvider>().locale.toString())
                  .format(count),
              fontSize: kFs18x,
            );
          })
        ],
      ),
    );
  }
}
