import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_template/src/api/api_client.dart';
import 'package:flutter_template/src/constant/preference_key.dart';
import 'package:flutter_template/src/models/language.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ISettingsRepository {
  Stream<Language> get language;

  Future<void> changeLanguage({required Language language});

  Stream<ThemeMode> get theme;

  Future<void> changeTheme({required ThemeMode themeMode});

  void dispose();
}

class SettingsRepository implements ISettingsRepository {
  SettingsRepository({required this.apiClient});

  final ApiClient apiClient;
  final _languageController = StreamController<Language>();
  final _themeModeController = StreamController<ThemeMode>();

  @override
  Stream<Language> get language async* {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString(PreferenceKey.language);

    if (jsonString == null) {
      yield Language.fallbackLanguage;
    } else {
      Language language = Language.fromJson(json.decode(jsonString));
      yield language;
    }

    yield* _languageController.stream;
  }

  @override
  Future<void> changeLanguage({required Language language}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = json.encode(language.toJson());
    await prefs.setString(PreferenceKey.language, jsonString);
    _languageController.add(language);
  }

  @override
  Stream<ThemeMode> get theme async* {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int themeMode = prefs.getInt(PreferenceKey.themeMode) ?? -1;

    switch (themeMode) {
      case 1:
        yield ThemeMode.light;
        break;
      case 2:
        yield ThemeMode.dark;
        break;
      default:
        yield ThemeMode.system;
    }

    yield* _themeModeController.stream;
  }

  @override
  Future<void> changeTheme({required ThemeMode themeMode}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(PreferenceKey.themeMode, themeMode.index);
    _themeModeController.add(themeMode);
  }

  @override
  void dispose() {
    _languageController.close();
    _themeModeController.close();
  }
}
