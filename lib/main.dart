import 'package:desktop_test/firebase_options.dart';
import 'package:desktop_test/services/firebase_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:desktop_test/constant/color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:desktop_test/pages/auth_page/login_page.dart';
import 'package:desktop_test/pages/auth_page/splash_page.dart';
import 'package:desktop_test/pages/gg_luck.dart';
import 'package:desktop_test/pages/gg_luck_customer.dart';
import 'package:desktop_test/provider/customer_provider.dart';
import 'package:desktop_test/provider/home_page_provider.dart';
import 'package:desktop_test/provider/language_provider.dart';
import 'package:desktop_test/provider/notification_provider.dart';
import 'package:desktop_test/provider/print_provider.dart';
import 'package:desktop_test/provider/profile_provider.dart';
import 'package:desktop_test/provider/sale_voucher_provider.dart';
import 'package:desktop_test/provider/login_provider.dart';
import 'package:desktop_test/provider/return_voucher_provider.dart';
import 'package:desktop_test/provider/transfer_voucher_provider.dart';
import 'package:desktop_test/utils/register_adapter_and_open_box.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await RegisterAdapterAndOpenBox.init();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: kBackGroundColor,
      statusBarIconBrightness: Brightness.dark));

  FirebaseService().init();
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late NotificationProvider _notificationProvider;
  @override
  void initState() {
    _loadData();
    super.initState();
  }

  _loadData() async {
    _notificationProvider = await NotificationProvider.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SaleVoucherProvider>(
            create: (_) => SaleVoucherProvider()),
        ChangeNotifierProvider<LoginProvider>(create: (_) => LoginProvider()),
        ChangeNotifierProvider<ReturnVoucherProvider>(
            create: (_) => ReturnVoucherProvider()),
        ChangeNotifierProvider<HomePageProvider>(
          create: (_) => HomePageProvider(),
        ),
        ChangeNotifierProvider(create: (_) => _notificationProvider),
        ChangeNotifierProvider<TransferVoucherProvider>(
          create: (_) => TransferVoucherProvider(),
        ),
        ChangeNotifierProvider<CustomerProvider>(
          create: (context) => CustomerProvider(),
        ),
        ChangeNotifierProvider<ProfileProvider>(
            create: (_) => ProfileProvider()),
        ChangeNotifierProvider<LanguageProvider>(
            create: (_) => LanguageProvider()),
        ChangeNotifierProvider<PrintProvider>(create: (_) => PrintProvider())
      ],
      builder: (context, child) => const StartUp(),
    );
  }
}

class StartUp extends StatelessWidget {
  const StartUp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final localProvider = context.watch<LanguageProvider>();
    return MaterialApp(
      title: 'Gg Luck',
      navigatorKey: MyApp.navigatorKey,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: localProvider.locale,
      home: const StartUpViewItem(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class StartUpViewItem extends StatelessWidget {
  const StartUpViewItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final loginProvider = context.watch<LoginProvider>();
    if (loginProvider.isFirstLogin) {
      return const LoginPage();
    }
    if (loginProvider.isInitialized) {
      return const SplashPage();
    }
    return loginProvider.isSale ? const GgLuck() : const GgLuckCustomer();
    // return const GgLuck();
  }
}
