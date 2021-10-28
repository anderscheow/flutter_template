import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/src/models/language.dart';
import 'package:flutter_template/src/repositories/settings/settings_repository.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc({
    required ISettingsRepository settingsRepo,
  })  : _settingsRepo = settingsRepo,
        super(SettingsState.defaultState()) {
    _languageSubscription = _settingsRepo.language.listen(
      (status) => add(LanguageChanged(status)),
    );

    _themeSubscription = _settingsRepo.theme.listen(
      (status) => add(ThemeChanged(status)),
    );
  }

  final ISettingsRepository _settingsRepo;
  late StreamSubscription<Language> _languageSubscription;
  late StreamSubscription<ThemeMode> _themeSubscription;

  @override
  Stream<SettingsState> mapEventToState(
    SettingsEvent event,
  ) async* {
    if (event is LanguageChanged) {
      yield await _mapLanguageChangedToState(event);
    } else if (event is ChangeLanguage) {
      changeLanguage(event);
    } else if (event is ThemeChanged) {
      yield await _mapThemeChangedToState(event);
    } else if (event is ChangeTheme) {
      changeTheme(event);
    }
  }

  @override
  Future<void> close() {
    _languageSubscription.cancel();
    _themeSubscription.cancel();
    _settingsRepo.dispose();
    return super.close();
  }

  Future<SettingsState> _mapLanguageChangedToState(
      LanguageChanged event) async {
    return SettingsState(language: event.language, themeMode: state.themeMode);
  }

  Future<SettingsState> _mapThemeChangedToState(ThemeChanged event) async {
    return SettingsState(language: state.language, themeMode: event.themeMode);
  }

  void changeLanguage(ChangeLanguage event) {
    if (state.language != event.language) {
      _settingsRepo.changeLanguage(language: event.language);
    }
  }

  void changeTheme(ChangeTheme event) {
    if (state.themeMode != event.themeMode) {
      _settingsRepo.changeTheme(themeMode: event.themeMode);
    }
  }
}
