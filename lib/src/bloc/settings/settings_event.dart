part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class LanguageChanged extends SettingsEvent {
  const LanguageChanged(this.language);

  final Language language;

  @override
  List<Object> get props => [language];
}

class ChangeLanguage extends SettingsEvent {
  const ChangeLanguage(this.language);

  final Language language;

  @override
  List<Object> get props => [language];
}

class ThemeChanged extends SettingsEvent {
  const ThemeChanged(this.themeMode);

  final ThemeMode themeMode;

  @override
  List<Object> get props => [themeMode];
}

class ChangeTheme extends SettingsEvent {
  const ChangeTheme(this.themeMode);

  final ThemeMode themeMode;

  @override
  List<Object> get props => [themeMode];
}
