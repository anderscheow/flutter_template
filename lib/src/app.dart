import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_template/src/bloc/settings/settings_bloc.dart';
import 'package:flutter_template/src/repository/settings/settings_repository.dart';
import 'package:flutter_template/src/styles/theme.dart';

import 'bloc/auth/auth_bloc.dart';
import 'constants/auth.dart';
import 'constants/language.dart';
import 'repository/auth/auth_repository.dart';
import 'route/routes.dart';

/// The Widget that configures your application.
class App extends StatelessWidget {
  final AuthRepository authRepo = AuthRepository();
  final SettingsRepository settingsRepo = SettingsRepository();

  App({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SettingsBloc(settingsRepo: settingsRepo)),
        BlocProvider(create: (_) => AuthBloc(authRepo: authRepo)),
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatefulWidget {
  static final globalNavKey = GlobalKey<NavigatorState>();

  const AppView({
    Key? key,
  }) : super(key: key);

  @override
  State<AppView> createState() => _AppViewState();
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
    return BlocBuilder<SettingsBloc, SettingsState>(
      buildWhen: (previousState, currentState) {
        return previousState.language != currentState.language ||
            previousState.themeMode != currentState.themeMode;
      },
      builder: (context, state) {
        return MaterialApp(
            builder: (context, child) {
              child = BlocListener<AuthBloc, AuthState>(
                listener: (context, state) {
                  switch (state.status) {
                    case AuthStatus.authenticated:
                      Routes.navigateTo(Routes.homeRoute, clearStack: true);
                      break;
                    case AuthStatus.unauthenticated:
                      Routes.navigateTo(Routes.loginRoute, clearStack: true);
                      break;
                    default:
                      break;
                  }
                },
                child: child,
              );
              child = botToastBuilder(context, child);
              return child;
            },
            navigatorKey: AppView.globalNavKey,
            navigatorObservers: [
              HeroController(),
              BotToastNavigatorObserver(),
            ],
            restorationScopeId: 'app',
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: supportedLocales,
            onGenerateTitle: (BuildContext context) => 'Title here',
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: state.themeMode,
            locale: Locale.fromSubtags(
              languageCode: state.language.languageCode,
              scriptCode: state.language.scriptCode,
            ),
            initialRoute: Routes.splashRoute,
            onGenerateRoute: (settings) {
              return routes.router
                  .matchRoute(context, settings.name, routeSettings: settings)
                  .route;
            });
      },
    );
  }
}
