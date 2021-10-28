import 'dart:async';

import 'package:flutter_template/src/api/api_client.dart';
import 'package:flutter_template/src/constant/auth.dart';

abstract class IAuthRepository {
  Stream<AuthStatus> get status;

  Future<void> logIn({
    required String username,
    required String password,
  });

  void logOut();

  void dispose();
}

class AuthRepository implements IAuthRepository {
  AuthRepository({required this.apiClient});

  final ApiClient apiClient;
  final _controller = StreamController<AuthStatus>();

  @override
  Stream<AuthStatus> get status async* {
    // Todo: Preference check
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthStatus.unauthenticated;
    yield* _controller.stream;
  }

@override
  Future<void> logIn({
    required String username,
    required String password,
  }) async {
    // Todo: Save to preference
    await Future.delayed(
      const Duration(milliseconds: 300),
      () => _controller.add(AuthStatus.authenticated),
    );
  }

  @override
  void logOut() {
    _controller.add(AuthStatus.unauthenticated);
  }

  @override
  void dispose() => _controller.close();
}
