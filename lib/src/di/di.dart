import 'package:dio/dio.dart';
import 'package:flutter_template/src/api/api_client.dart';
import 'package:flutter_template/src/constant/config.dart';
import 'package:flutter_template/src/repositories/auth/auth_repository.dart';
import 'package:flutter_template/src/repositories/settings/settings_repository.dart';
import 'package:kiwi/kiwi.dart';

void setupDI(IConfig config) {
  final KiwiContainer container = KiwiContainer();

  container.registerInstance(config);

  Dio dio = Dio()
    ..interceptors.add(LogInterceptor(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
    ));
  ApiClient apiClient = ApiClient(dio, baseUrl: config.getBaseUrl());
  container.registerInstance(apiClient);

  container.registerInstance<IAuthRepository>(AuthRepository(apiClient: container.resolve()));
  container.registerInstance<ISettingsRepository>(SettingsRepository(apiClient: container.resolve()));
}
