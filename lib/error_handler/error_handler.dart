import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:desktop_test/main.dart';
import 'package:desktop_test/pages/auth_page/login_page.dart';
import 'package:desktop_test/persistent/daos/user_dao/access_token_dao_impl.dart';
import 'package:desktop_test/utils/extension.dart';

class ErrorHandler {
  static Future<void> handleErrorForLogin(DioException? e) async {
    BuildContext? context = MyApp.navigatorKey.currentState?.context;
    if (e == null) return;
    if (context == null) return;
    if (e.type == DioExceptionType.connectionError ||
        e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.sendTimeout ||
        e.error is SocketException) {
      await context.showErrorDialog(context,
          errorMessage: 'Network error,Check your network connection',
          onPressed: () {
        while (Navigator.of(context).canPop()) {
          context.popScreen();
        }
      });
    } else if (e.response!.statusCode! == 401) {
      await context.showErrorDialog(context,
          errorMessage: 'Incorrect Password! Try again', onPressed: () {
        AccessTokenDaoImpl().deleteAccessToken();
        Navigator.popUntil(context, (route) => route.isFirst);
        context.pushReplacement(const LoginPage());
      });
    } else if (e.response!.statusCode! >= 400) {
      await context.showErrorDialog(context,
          errorMessage: 'There is no user with this name', onPressed: () {
        AccessTokenDaoImpl().deleteAccessToken();
        Navigator.popUntil(context, (route) => route.isFirst);
        context.pushReplacement(const LoginPage());
      });
    } else if (e.response!.statusCode! == 500) {
      await context.showErrorDialog(context,
          errorMessage: 'We are sorry! Sever error ', onPressed: () {
        while (Navigator.of(context).canPop()) {
          context.popScreen();
        }
      });
    } else {
      await context.showErrorDialog(context,
          errorMessage: 'Something went wrong', onPressed: () {
        while (Navigator.of(context).canPop()) {
          context.popScreen();
        }
      });
    }
  }

  static Future<void> handleError(DioException? e) async {
    BuildContext? context = MyApp.navigatorKey.currentState?.context;
    if (e == null) return;
    if (context == null) return;
    if (e.type == DioExceptionType.connectionError ||
        e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.sendTimeout ||
        e.error is SocketException) {
      await context.showErrorDialog(context,
          errorMessage: 'Network error,Check your network connection',
          onPressed: () {
        while (Navigator.of(context).canPop()) {
          context.popScreen();
        }
      });
    } else if (e.response!.statusCode! == 401) {
      await context.showErrorDialog(context,
          errorMessage: 'Login expired .Try to login again', onPressed: () {
        AccessTokenDaoImpl().deleteAccessToken();
        Navigator.popUntil(context, (route) => route.isFirst);
        context.pushReplacement(const LoginPage());
      });
    } else if (e.response!.statusCode! == 500) {
      await context.showErrorDialog(context,
          errorMessage: 'We are sorry ! Sever error', onPressed: () {
        context.popScreen();
      });
    } else if (e.response!.statusCode! == 404) {
      await context.showErrorDialog(context, errorMessage: 'Not found Error',
          onPressed: () {
        context.popScreen();
      });
    } else if (e.response!.statusCode! > 400) {
      await context.showErrorDialog(context,
          errorMessage: 'Login expired Try to login again', onPressed: () {
        while (Navigator.of(context).canPop()) {
          context.popScreen();
        }
      });
    } else {
      await context.showErrorDialog(context,
          errorMessage: 'Something went wrong', onPressed: () {
        while (Navigator.of(context).canPop()) {
          context.popScreen();
        }
      });
    }
  }

  static Future<void> handleErrorForDevice(DioException? e) async {
    BuildContext? context = MyApp.navigatorKey.currentState?.context;
    if (e == null) return;
    if (context == null) return;
    if (e.type == DioExceptionType.connectionError ||
        e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.sendTimeout ||
        e.error is SocketException) {
      await context.showErrorDialog(context,
          errorMessage: 'Network error,Check your network connection',
          onPressed: () {
        while (Navigator.of(context).canPop()) {
          context.popScreen();
        }
      });
    } else if (e.response!.statusCode! == 400) {
      await context.showErrorDialog(context,
          errorMessage: 'Your device is not allowed to login', onPressed: () {
        while (Navigator.of(context).canPop()) {
          context.popScreen();
        }
      });
    }
  }
}
