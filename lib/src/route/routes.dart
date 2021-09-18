import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import '../app.dart';

class Routes {
  static const splashRoute = "/";
  static const loginRoute = "/login";
  static const homeRoute = "/home";

  FluroRouter router = FluroRouter();

  void setupRouter() {
    router
      ..define(
        splashRoute,
        handler: Handler(
          handlerFunc: (context, params) => Container(),
        ),
      )
      ..define(
        homeRoute,
        handler: Handler(
          handlerFunc: (context, params) => Container(),
        ),
      )
      ..define(
        loginRoute,
        handler: Handler(
          handlerFunc: (context, params) => Container(),
        ),
      )
      ..notFoundHandler =
          Handler(handlerFunc: (context, params) => Container());
  }

  static Future<dynamic> navigateTo(String routeName,
      {Map<String, String>? queryParams, bool clearStack = false}) {
    if (clearStack) {
      return AppView.globalNavKey.currentState!
          .pushNamedAndRemoveUntil(routeName, (_) => false);
    }
    return AppView.globalNavKey.currentState!.pushNamed(routeName);
  }
}
