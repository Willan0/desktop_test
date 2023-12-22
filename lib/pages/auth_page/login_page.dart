// ignore_for_file: use_build_context_synchronously

import 'package:android_id/android_id.dart';
import 'package:flutter/material.dart';
import 'package:desktop_test/constant/assets.dart';
import 'package:desktop_test/pages/gg_luck.dart';
import 'package:desktop_test/pages/gg_luck_customer.dart';
import 'package:desktop_test/provider/login_provider.dart';
import 'package:desktop_test/utils/extension.dart';
import 'package:desktop_test/widgets/easy_image.dart';
import 'package:desktop_test/widgets/easy_text_field.dart';
import 'package:provider/provider.dart';

import '../../constant/color.dart';
import '../../constant/dimen.dart';
import '../../widgets/easy_text.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  bool visible = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void changVisible() {
    if (mounted) {
      setState(() {
        visible = !visible;
      });
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    passwordController.dispose();
    nameFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Form(
        key: _formKey,
        child: Consumer<LoginProvider>(
          builder: (context, loginProvider, child) => Scaffold(
            backgroundColor: kBackGroundColor,
            body: SingleChildScrollView(
              child: SizedBox(
                width: getWidth(context),
                height: getHeight(context),
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                      left: kAs20x,
                      right: kAs20x),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      /// Logo

                      const Center(
                        child: EasyImage(
                          url: kLogo,
                          fit: BoxFit.contain,
                          width: 136,
                          height: kAs100x,
                          isNetwork: false,
                        ),
                      ),

                      SizedBox(
                        height: context.responsive(kAs30x, md: kAs50x),
                      ),

                      /// login title
                      SizedBox(
                        width: context.responsive(getWidth(context),
                            lg: getWidth(context) * 0.5,
                            md: getWidth(context) * 0.8),
                        child: const EasyText(
                          text: 'Login to your account',
                          fontSize: kFs20x,
                          fontWeight: FontWeight.w500,
                          fontColor: kPrimaryTextColor,
                          textAlign: TextAlign.left,
                        ),
                      ),

                      SizedBox(
                        width: context.responsive(getWidth(context),
                            lg: getWidth(context) * 0.5,
                            md: getWidth(context) * 0.8),
                        child: const EasyText(
                          text: 'Welcome back',
                          fontSize: kFs12x,
                          fontColor: kSecondaryTextColor,
                        ),
                      ),
                      const SizedBox(
                        height: kAs10x,
                      ),

                      /// user name
                      SizedBox(
                        width: context.responsive(getWidth(context),
                            lg: getWidth(context) * 0.5,
                            md: getWidth(context) * 0.8),
                        child: EasyTextField(
                          controller: nameController,
                          hintText: "Username",
                          focusNode: nameFocusNode,
                          iconData: Icons.person,
                          onChanged: (value) {
                            _formKey.currentState!.validate();
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Username can\'t be empty';
                            }
                            return null;
                          },
                        ),
                      ),

                      const SizedBox(
                        height: kAs10x,
                      ),

                      // password
                      SizedBox(
                        width: context.responsive(getWidth(context),
                            lg: getWidth(context) * 0.5,
                            md: getWidth(context) * 0.8),
                        child: EasyTextField(
                          controller: passwordController,
                          hintText: "Password",
                          obscure: visible,
                          focusNode: passwordFocusNode,
                          iconData: Icons.lock,
                          onChanged: (value) {
                            _formKey.currentState!.validate();
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password can\'t be empty';
                            }
                            return null;
                          },
                          suffix: SizedBox(
                            child: IconButton(
                              splashColor: Colors.transparent,
                              icon: Icon(visible
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () => changVisible(),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: kAs10x,
                      ),

                      ///login button
                      ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState?.validate() ?? false) {
                              showDialog(
                                context: context,
                                builder: (context) => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );

                              final value = await loginProvider.login(
                                  nameController.text, passwordController.text);
                              if (value != null) {
                                context.popScreen();
                                if (value.user?.userRole == "sale") {
                                  const androidIdPlugin = AndroidId();
                                  final String? serialNo =
                                      await androidIdPlugin.getId();
                                  if (await loginProvider
                                          .checkDevice(serialNo) ??
                                      false) {
                                    context.pushReplacement(const GgLuck());
                                  }
                                } else {
                                  context
                                      .pushReplacement(const GgLuckCustomer());
                                }
                                nameController.clear();
                                passwordController.clear();
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              fixedSize: Size(
                                  context.responsive(getWidth(context),
                                      lg: getWidth(context) * 0.5,
                                      md: getWidth(context) * 0.8),
                                  50)),
                          child: const EasyText(
                            text: 'Login',
                            fontSize: kFs16x,
                            fontColor: kWhiteColor,
                          ))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
