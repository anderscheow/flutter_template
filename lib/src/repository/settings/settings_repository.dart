import 'dart:async';

import 'package:flutter/material.dart';

class SettingsRepository {
  final _themeModeController = StreamController<ThemeMode>();

  Stream<ThemeMode> get status async* {
    // Todo: Preference check
    yield ThemeMode.system;
    yield* _themeModeController.stream;
  }

  Future<void> changeTheme({required ThemeMode themeMode}) async {
    // Todo: Save to preference
    await Future.delayed(
      const Duration(milliseconds: 300),
      () => _themeModeController.add(themeMode),
    );
  }

  void dispose() => _themeModeController.close();
}
