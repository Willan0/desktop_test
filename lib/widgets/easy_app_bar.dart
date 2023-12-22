import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:desktop_test/constant/dimen.dart';
import 'package:desktop_test/utils/extension.dart';
import 'package:desktop_test/widgets/easy_text.dart';

class EasyAppBar extends StatelessWidget {
  const EasyAppBar(
      {super.key,
      required this.text,
      this.leading,
      this.action,
      this.onPressed});

  final String text;
  final bool? leading;
  final String? action;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle:
          const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leadingWidth: kAs50x,
      centerTitle: false,
      actions: action == null
          ? []
          : [
              Center(
                child: EasyText(
                  text: action ?? '0',
                  fontSize: kFs12x,
                ),
              ),
              const SizedBox(
                width: kAs5x,
              )
            ],
      leading: leading == null
          ? null
          : Padding(
              padding: const EdgeInsets.only(left: kFs10x),
              child: IconButton(
                  onPressed: onPressed ??
                      () {
                        context.popScreen();
                      },
                  icon: const Icon(
                    CupertinoIcons.arrow_left,
                    color: Colors.black,
                  )),
            ),
      title: Padding(
        padding: EdgeInsets.only(left: leading == null ? kAs10x : 0),
        child: EasyText(
          text: text,
          fontSize: leading == null ? kFs20x : kFs16x,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
