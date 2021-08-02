import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/bloc/auth/auth_bloc.dart';
import 'package:flutter_template/repository/auth/auth_repository.dart';

import 'bloc/auth/auth_bloc.dart';
import 'route/routes.dart';

class App extends StatelessWidget {
  final AuthRepository authRepo = AuthRepository();

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authRepo,
      child: BlocProvider(
        create: (_) => AuthBloc(
          authRepo: authRepo,
        ),
        child: AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  static final globalNavKey = GlobalKey<NavigatorState>();

  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> with WidgetsBindingObserver {
  final botToastBuilder = BotToastInit();
  final Routes routes = Routes();

  _AppViewState() {
    routes.setupRouter();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      builder: (context, child) {
        child = BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthStatus.authenticated:
                Routes.navigateTo(Routes.homeRoute);
                break;
              case AuthStatus.unauthenticated:
                Routes.navigateTo(Routes.loginRoute);
                break;
              default:
                break;
            }
          },
          child: child,
        );
        child = botToastBuilder(context,child);
        return child;
      },
      navigatorKey: AppView.globalNavKey,
      navigatorObservers: [
        HeroController(),
        BotToastNavigatorObserver(),
      ],
      initialRoute: Routes.splashRoute,
      onGenerateRoute: (settings) {
        return routes.router
            .matchRoute(context, settings.name, routeSettings: settings)
            .route;
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Container(),
    );
  }
}
