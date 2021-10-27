import 'package:dio/dio.dart';
import 'package:flutter_template/src/api/api_client.dart';
import 'package:flutter_template/src/constants/config.dart';
import 'package:flutter_template/src/repository/auth/auth_repository.dart';
import 'package:flutter_template/src/repository/settings/settings_repository.dart';
import 'package:flutter_template/src/util/dio_logger_interceptor.dart';
import 'package:kiwi/kiwi.dart';

void setupDI(IConfig config) {
  final KiwiContainer container = KiwiContainer();

  container.registerInstance(config);

  Dio dio = Dio()
    ..interceptors.add(DioLoggerInterceptor(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
    ));
  ApiClient apiClient = ApiClient(dio, baseUrl: config.getBaseUrl());
  container.registerInstance(apiClient);

  container.registerInstance(AuthRepository());
  container.registerInstance(SettingsRepository());
}
