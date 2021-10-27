import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_template/src/bloc/settings/settings_bloc.dart';
import 'package:flutter_template/src/constants/config.dart';
import 'package:flutter_template/src/styles/theme.dart';
import 'package:kiwi/kiwi.dart';

import 'bloc/auth/auth_bloc.dart';
import 'constants/auth.dart';
import 'constants/language.dart';
import 'di/di.dart';
import 'route/routes.dart';

/// The Widget that configures your application.
class App extends StatelessWidget {
  const App({Key? key, required this.config}) : super(key: key);

  final IConfig config;

  @override
  Widget build(BuildContext context) {
    return AppView(config: config);
  }
}

class AppView extends StatefulWidget {
  static final globalNavKey = GlobalKey<NavigatorState>();

  final IConfig config;

  const AppView({
    Key? key,
    required this.config,
  }) : super(key: key);

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> with WidgetsBindingObserver {
  final botToastBuilder = BotToastInit();
  final Routes routes = Routes();

  final KiwiContainer container = KiwiContainer();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    _setup();
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => SettingsBloc(settingsRepo: container.resolve())),
        BlocProvider(create: (_) => AuthBloc(authRepo: container.resolve())),
      ],
      child: BlocBuilder<SettingsBloc, SettingsState>(
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
      ),
    );
  }

  void _setup() {
    setupDI(widget.config);
    routes.setupRouter();
  }
}
