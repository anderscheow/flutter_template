import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/src/repository/settings/settings_repository.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc({
    required SettingsRepository settingsRepo,
  })  : _settingsRepo = settingsRepo,
        super(const ThemeState.system()) {
    _themeSubscription = _settingsRepo.theme.listen(
      (status) => add(ThemeChanged(status)),
    );
  }

  final SettingsRepository _settingsRepo;
  late StreamSubscription<ThemeMode> _themeSubscription;

  @override
  Stream<ThemeState> mapEventToState(
    ThemeEvent event,
  ) async* {
    if (event is ThemeChanged) {
      yield await _mapThemeChangedToState(event);
    } else if (event is ChangeTheme) {
      _settingsRepo.changeTheme(themeMode: event.themeMode);
    }
  }

  @override
  Future<void> close() {
    _themeSubscription.cancel();
    _settingsRepo.dispose();
    return super.close();
  }

  Future<ThemeState> _mapThemeChangedToState(
    ThemeChanged event,
  ) async {
    return ThemeState(themeMode: event.themeMode);
  }
}
