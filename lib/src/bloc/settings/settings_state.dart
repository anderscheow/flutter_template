part of 'settings_bloc.dart';

class SettingsState extends Equatable {
  const SettingsState({
    required this.language,
    required this.themeMode,
  });

  SettingsState.defaultState()
      : this(
          language: Language.fallbackLanguage,
          themeMode: ThemeMode.system,
        );

  final Language language;
  final ThemeMode themeMode;

  @override
  List<Object> get props => [language, themeMode];
}
